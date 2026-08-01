import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/money.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/ai_provider_repository.dart'
    show policyDariRow;
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/layout_widgets.dart';
import '../../domain/ai/ai_models.dart';
import '../../domain/ai/ai_provider_adapter.dart';
import '../../domain/ai/financial_context_builder.dart';
import '../../domain/ai/model_policy.dart';
import '../../l10n/app_localizations.dart';
import 'ai_providers.dart';

/// Layar chat Finara AI (§42, §46): streaming, hentikan, salin, disclaimer.
class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, required this.conversationId});

  final int conversationId;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _inputCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  AIProviderAdapter? _adapterAktif;
  StreamSubscription<String>? _langgananStream;
  Completer<void>? _selesaiStream;
  String _sedangDiketik = '';
  bool _streaming = false;
  String? _estimasiTerakhir;

  @override
  void dispose() {
    _adapterAktif?.cancelRequest();
    _langgananStream?.cancel();
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  Future<void> _kirim(String teks) async {
    final l10n = AppLocalizations.of(context)!;
    final isi = teks.trim();
    if (isi.isEmpty || _streaming) return;
    _inputCtrl.clear();

    final chatRepo = ref.read(chatRepositoryProvider);
    final percakapan =
        await chatRepo.percakapan(widget.conversationId);
    if (percakapan == null) return;
    final config = await ref
        .read(aiProviderRepositoryProvider)
        .provider(percakapan.providerId);
    if (config == null) return;

    await chatRepo.tambahPesan(
        conversationId: widget.conversationId, role: 'user', content: isi);
    // Judul percakapan = pesan pertama.
    final pesanSebelum =
        await chatRepo.pesanPercakapan(widget.conversationId);
    if (pesanSebelum.where((m) => m.role == 'user').length == 1) {
      await chatRepo.ubahJudul(widget.conversationId,
          isi.length > 40 ? '${isi.substring(0, 40)}…' : isi);
    }
    ref
      ..invalidate(pesanPercakapanProvider(widget.conversationId))
      ..invalidate(daftarPercakapanProvider);

    final apiKey =
        await ref.read(apiKeyStoreProvider).baca(config.id) ?? '';
    final adapter =
        buatAdapter(ref.read(aiAdapterFactoryProvider), config);
    _adapterAktif = adapter;

    final riwayat = [
      const AIMessage(
          role: AIRole.system,
          content: FinancialContextBuilder.systemPrompt),
      for (final m in pesanSebelum)
        AIMessage(
          role: m.role == 'assistant' ? AIRole.assistant : AIRole.user,
          content: m.content,
        ),
    ];

    setState(() {
      _streaming = true;
      _sedangDiketik = '';
    });

    final daftarModel = await ref
        .read(aiProviderRepositoryProvider)
        .modelProvider(config.id);
    final kebijakan = [for (final m in daftarModel) policyDariRow(m)];

    var modelAktif = percakapan.modelId;
    try {
      var jawaban = '';
      // Rantai fallback §37: utama → cadangan1 → cadangan2 dalam provider
      // yang sama (izin data identik).
      for (var percobaan = 0; percobaan < 3; percobaan++) {
        try {
          jawaban = await _mintaJawaban(
            adapter: adapter,
            apiKey: apiKey,
            model: modelAktif,
            riwayat: riwayat,
            streaming: config.streamingAktif,
          );
          break;
        } on AIProviderException catch (e) {
          final berikutnya = const FallbackService().modelBerikutnya(
            modelGagal: modelAktif,
            error: e.kind,
            fallback1: config.fallbackModel1,
            fallback2: config.fallbackModel2,
            mode: config.allowedMode,
            daftarModel: kebijakan,
          );
          if (berikutnya == null) rethrow;
          modelAktif = berikutnya;
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(l10n.beralihKeCadangan(berikutnya))));
          }
        }
      }
      // Jawaban parsial saat dihentikan tetap disimpan.
      if (jawaban.trim().isNotEmpty) {
        await chatRepo.tambahPesan(
          conversationId: widget.conversationId,
          role: 'assistant',
          content: jawaban.trim(),
        );
      }
      await ref
          .read(aiProviderRepositoryProvider)
          .catatModelDipakai(config.id, modelAktif);
      _hitungEstimasi(l10n, daftarModel, modelAktif, riwayat, jawaban);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(labelErrorAi(l10n, e))));
      }
    } finally {
      _langgananStream = null;
      _selesaiStream = null;
      if (mounted) {
        setState(() {
          _streaming = false;
          _sedangDiketik = '';
        });
        ref.invalidate(pesanPercakapanProvider(widget.conversationId));
      }
    }
  }

  Future<String> _mintaJawaban({
    required AIProviderAdapter adapter,
    required String apiKey,
    required String model,
    required List<AIMessage> riwayat,
    required bool streaming,
  }) async {
    final request = AIChatRequest(
      model: model,
      messages: riwayat,
      stream: streaming,
    );
    if (!streaming) {
      return (await adapter.sendMessage(request, apiKey: apiKey)).content;
    }
    var jawaban = '';
    final selesai = Completer<void>();
    _selesaiStream = selesai;
    _langgananStream =
        adapter.streamMessage(request, apiKey: apiKey).listen(
      (potongan) {
        jawaban += potongan;
        if (mounted) setState(() => _sedangDiketik = jawaban);
        _gulirKeBawah();
      },
      onDone: () {
        if (!selesai.isCompleted) selesai.complete();
      },
      onError: (Object e) {
        if (!selesai.isCompleted) selesai.completeError(e);
      },
      cancelOnError: true,
    );
    await selesai.future;
    return jawaban;
  }

  /// Estimasi biaya §39: hanya tampil jika harga model tersedia.
  void _hitungEstimasi(
    AppLocalizations l10n,
    List<AiModel> daftarModel,
    String modelId,
    List<AIMessage> riwayat,
    String jawaban,
  ) {
    const estimator = CostEstimator();
    final baris =
        daftarModel.where((m) => m.modelId == modelId).toList();
    if (baris.isEmpty) return;
    final tokenInput = estimator.estimasiToken(
        riwayat.map((m) => m.content).join('\n'));
    final tokenOutput = estimator.estimasiToken(jawaban);
    final biaya = estimator.estimasiBiaya(
      tokenInput: tokenInput,
      tokenOutput: tokenOutput,
      hargaInputPerJuta: baris.first.hargaInputPerJuta,
      hargaOutputPerJuta: baris.first.hargaOutputPerJuta,
    );
    if (biaya == null) return; // tanpa harga → tanpa estimasi palsu
    if (mounted) {
      setState(() => _estimasiTerakhir = l10n.estimasiBiayaTerakhir(
          tokenInput + tokenOutput, formatRupiah(biaya)));
    }
  }

  void _hentikan() {
    _adapterAktif?.cancelRequest();
    _langgananStream?.cancel();
    final selesai = _selesaiStream;
    if (selesai != null && !selesai.isCompleted) selesai.complete();
  }

  void _gulirKeBawah() {
    if (!_scrollCtrl.hasClients) return;
    _scrollCtrl.jumpTo(_scrollCtrl.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final pesan = ref
            .watch(pesanPercakapanProvider(widget.conversationId))
            .value ??
        const [];
    final tampil =
        pesan.where((m) => m.role != 'system').toList();

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future:
              ref.read(chatRepositoryProvider).percakapan(widget.conversationId),
          builder: (context, snap) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.navFinaraAi),
              if (snap.data != null)
                Text(snap.data!.modelId,
                    style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
          child: Column(
            children: [
              Expanded(
                child: tampil.isEmpty && !_streaming
                    ? _SaranAwal(onPilih: _kirim)
                    : ListView(
                        controller: _scrollCtrl,
                        padding: const EdgeInsets.all(FinaraSpacing.lg),
                        children: [
                          for (final m in tampil)
                            _GelembungPesan(
                              teks: m.content,
                              dariPengguna: m.role == 'user',
                            ),
                          if (_streaming)
                            _GelembungPesan(
                              teks: _sedangDiketik.isEmpty
                                  ? '…'
                                  : _sedangDiketik,
                              dariPengguna: false,
                            ),
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: FinaraSpacing.lg),
                child: Column(
                  children: [
                    if (_estimasiTerakhir != null)
                      Text(
                        '$_estimasiTerakhir · ${l10n.disclaimerBiaya}',
                        style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    Text(
                      l10n.disclaimerAi,
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              StickyActionBar(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _inputCtrl,
                        decoration:
                            InputDecoration(hintText: l10n.ketikPesan),
                        minLines: 1,
                        maxLines: 4,
                        textInputAction: TextInputAction.send,
                        onSubmitted: _kirim,
                      ),
                    ),
                    const SizedBox(width: FinaraSpacing.sm),
                    if (_streaming)
                      IconButton.filledTonal(
                        icon: const Icon(Icons.stop_rounded),
                        tooltip: l10n.hentikan,
                        onPressed: _hentikan,
                      )
                    else
                      IconButton.filled(
                        icon: const Icon(Icons.send_rounded),
                        tooltip: l10n.navFinaraAi,
                        onPressed: () => _kirim(_inputCtrl.text),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaranAwal extends StatelessWidget {
  const _SaranAwal({required this.onPilih});

  final ValueChanged<String> onPilih;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final saran = [
      l10n.chipAnalisisAlokasi,
      l10n.chipUangJajan,
      l10n.chipDanaDarurat,
      l10n.chipInvestasi,
    ];
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(FinaraSpacing.xl),
        child: Wrap(
          spacing: FinaraSpacing.sm,
          runSpacing: FinaraSpacing.sm,
          alignment: WrapAlignment.center,
          children: [
            for (final s in saran)
              ActionChip(label: Text(s), onPressed: () => onPilih(s)),
          ],
        ),
      ),
    );
  }
}

class _GelembungPesan extends StatelessWidget {
  const _GelembungPesan({required this.teks, required this.dariPengguna});

  final String teks;
  final bool dariPengguna;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return Align(
      alignment:
          dariPengguna ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: dariPengguna
            ? null
            : () async {
                await Clipboard.setData(ClipboardData(text: teks));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.jawabanTersalin)));
              },
        child: Container(
          margin: const EdgeInsets.only(bottom: FinaraSpacing.sm),
          padding: const EdgeInsets.all(FinaraSpacing.md),
          constraints: const BoxConstraints(maxWidth: 440),
          decoration: BoxDecoration(
            color: dariPengguna
                ? scheme.primaryContainer
                : scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(FinaraRadius.md),
          ),
          child: SelectableText(teks),
        ),
      ),
    );
  }
}
