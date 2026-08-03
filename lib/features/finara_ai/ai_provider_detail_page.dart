import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/money.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/ai_provider_repository.dart';
import '../../data/services/api_key_store.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../domain/ai/ai_models.dart';
import '../../domain/models/ai_enums.dart';
import '../../l10n/app_localizations.dart';
import 'ai_providers.dart';

final _providerDetailProvider =
    FutureProvider.family<AiProviderConfiguration?, int>((ref, id) {
  ref.watch(daftarProviderAiProvider);
  return ref.watch(aiProviderRepositoryProvider).provider(id);
});

/// Detail satu provider (§29–§35, §37, §39): model, kemampuan, allowed,
/// fallback, harga, izin data.
class AiProviderDetailPage extends ConsumerStatefulWidget {
  const AiProviderDetailPage({super.key, required this.providerId});

  final int providerId;

  @override
  ConsumerState<AiProviderDetailPage> createState() =>
      _AiProviderDetailPageState();
}

class _AiProviderDetailPageState
    extends ConsumerState<AiProviderDetailPage> {
  bool _sibuk = false;
  String? _status;
  String _cari = '';

  AiProviderConfiguration? get _provider =>
      ref.watch(_providerDetailProvider(widget.providerId)).value;

  Future<void> _jalankan(
      Future<String> Function(AiProviderConfiguration p) aksi) async {
    final p = _provider;
    if (p == null) return;
    setState(() {
      _sibuk = true;
      _status = null;
    });
    final l10n = AppLocalizations.of(context)!;
    try {
      final hasil = await aksi(p);
      if (mounted) setState(() => _status = hasil);
    } catch (e) {
      if (mounted) setState(() => _status = labelErrorAi(l10n, e));
    } finally {
      if (mounted) setState(() => _sibuk = false);
    }
  }

  Future<String> _ambilModel(AiProviderConfiguration p) async {
    final l10n = AppLocalizations.of(context)!;
    final apiKey = await ref.read(apiKeyStoreProvider).baca(p.id) ?? '';
    final adapter = buatAdapter(ref.read(aiAdapterFactoryProvider), p);
    final models = await adapter.fetchModels(apiKey: apiKey);
    await ref
        .read(aiProviderRepositoryProvider)
        .simpanHasilDiscovery(providerId: p.id, models: models);
    ref.invalidate(modelTersimpanProvider(p.id));
    return l10n.modelDitemukan(models.length);
  }

  Future<String> _tesKoneksi(AiProviderConfiguration p) async {
    final l10n = AppLocalizations.of(context)!;
    final apiKey = await ref.read(apiKeyStoreProvider).baca(p.id) ?? '';
    final adapter = buatAdapter(ref.read(aiAdapterFactoryProvider), p);
    final ok = await adapter.testConnection(apiKey: apiKey);
    return ok ? l10n.koneksiBerhasil : l10n.errTidakDiketahui;
  }

  /// Tes chat model (§35): VERIFIED saat lulus; UNSUPPORTED hanya saat
  /// provider merespons bahwa model tidak tersedia.
  Future<String> _tesModel(AiProviderConfiguration p, AiModel m) async {
    final l10n = AppLocalizations.of(context)!;
    final apiKey = await ref.read(apiKeyStoreProvider).baca(p.id) ?? '';
    final adapter = buatAdapter(ref.read(aiAdapterFactoryProvider), p);
    final repo = ref.read(aiProviderRepositoryProvider);
    try {
      final ok =
          await adapter.testModel(apiKey: apiKey, modelId: m.modelId);
      await repo.setStatusKemampuan(m.id,
          chat: ok ? CapabilityStatus.verified : CapabilityStatus.unknown);
      ref.invalidate(modelTersimpanProvider(p.id));
      return ok ? l10n.statusVerified : l10n.statusUnknown;
    } on AIProviderException catch (e) {
      if (e.kind == AIErrorKind.modelTidakTersedia) {
        await repo.setStatusKemampuan(m.id,
            chat: CapabilityStatus.unsupported);
        ref.invalidate(modelTersimpanProvider(p.id));
        return l10n.statusUnsupported;
      }
      rethrow; // error lain tidak menandai kemampuan gagal (§35)
    }
  }

  Future<String> _tesStreaming(AiProviderConfiguration p, AiModel m) async {
    final l10n = AppLocalizations.of(context)!;
    final apiKey = await ref.read(apiKeyStoreProvider).baca(p.id) ?? '';
    final adapter = buatAdapter(ref.read(aiAdapterFactoryProvider), p);
    final repo = ref.read(aiProviderRepositoryProvider);
    try {
      final isi = await adapter
          .streamMessage(
            AIChatRequest(model: m.modelId, messages: const [
              AIMessage(role: AIRole.user, content: 'Balas singkat: OK'),
            ], stream: true),
            apiKey: apiKey,
          )
          .join();
      final ok = isi.trim().isNotEmpty;
      await repo.setStatusKemampuan(m.id,
          streaming:
              ok ? CapabilityStatus.verified : CapabilityStatus.unknown);
      ref.invalidate(modelTersimpanProvider(p.id));
      return ok ? l10n.statusVerified : l10n.statusUnknown;
    } on AIProviderException catch (e) {
      if (e.kind == AIErrorKind.responsKosong ||
          e.kind == AIErrorKind.streamingTerputus) {
        await repo.setStatusKemampuan(m.id,
            streaming: CapabilityStatus.unsupported);
        ref.invalidate(modelTersimpanProvider(p.id));
        return l10n.statusUnsupported;
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final p = _provider;
    if (p == null) {
      return Scaffold(appBar: AppBar(title: Text(l10n.penyediaDanModel)));
    }
    final models =
        ref.watch(modelTersimpanProvider(p.id)).value ?? const [];
    final tersaring = _cari.isEmpty
        ? models
        : models
            .where((m) =>
                m.modelId.toLowerCase().contains(_cari.toLowerCase()) ||
                (m.displayName ?? '')
                    .toLowerCase()
                    .contains(_cari.toLowerCase()))
            .toList();
    final idModel = models.map((m) => m.modelId).toList();

    return Scaffold(
      appBar: AppBar(title: Text(p.nama)),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.all(FinaraSpacing.lg),
            children: [
              FinaraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.baseUrl, style: theme.textTheme.bodySmall),
                    FutureBuilder<String?>(
                      future: ref.read(apiKeyStoreProvider).baca(p.id),
                      builder: (context, snap) => Text(
                        l10n.apiKeyTersimpan(
                            ApiKeyStore.samarkan(snap.data ?? '')),
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    const SizedBox(height: FinaraSpacing.md),
                    Wrap(
                      spacing: FinaraSpacing.sm,
                      runSpacing: FinaraSpacing.sm,
                      children: [
                        FilledButton.tonal(
                          onPressed:
                              _sibuk ? null : () => _jalankan(_tesKoneksi),
                          child: Text(l10n.tesKoneksi),
                        ),
                        FilledButton.tonal(
                          onPressed:
                              _sibuk ? null : () => _jalankan(_ambilModel),
                          child: Text(models.isEmpty
                              ? l10n.ambilDaftarModel
                              : l10n.muatUlangModel),
                        ),
                        OutlinedButton(
                          onPressed: _sibuk ? null : _tambahManual,
                          child: Text(l10n.tambahModelManual),
                        ),
                      ],
                    ),
                    if (_sibuk) ...[
                      const SizedBox(height: FinaraSpacing.md),
                      const LinearProgressIndicator(),
                    ],
                    if (_status != null) ...[
                      const SizedBox(height: FinaraSpacing.sm),
                      Text(_status!, style: theme.textTheme.bodySmall),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: FinaraSpacing.lg),
              DropdownButtonFormField<AIDataScope>(
                initialValue: p.izinData,
                decoration: InputDecoration(labelText: l10n.izinDataAi),
                items: [
                  DropdownMenuItem(
                      value: AIDataScope.tanpaAkses,
                      child: Text(l10n.izinTanpaAkses)),
                  DropdownMenuItem(
                      value: AIDataScope.bulanAktif,
                      child: Text(l10n.izinBulanAktif)),
                  DropdownMenuItem(
                      value: AIDataScope.tigaBulan,
                      child: Text(l10n.izinTigaBulan)),
                  DropdownMenuItem(
                      value: AIDataScope.enamBulan,
                      child: Text(l10n.izinEnamBulan)),
                ],
                onChanged: (v) async {
                  if (v == null) return;
                  await ref
                      .read(aiProviderRepositoryProvider)
                      .perbaruiProvider(
                          p.id,
                          AiProviderConfigurationsCompanion(
                              izinData: Value(v)));
                  ref.invalidate(daftarProviderAiProvider);
                },
              ),
              const SizedBox(height: FinaraSpacing.lg),
              DropdownButtonFormField<AllowedModelsMode>(
                initialValue: p.allowedMode,
                decoration: InputDecoration(labelText: l10n.allowedModels),
                items: [
                  DropdownMenuItem(
                      value: AllowedModelsMode.izinkanSemua,
                      child: Text(l10n.modeIzinkanSemua)),
                  DropdownMenuItem(
                      value: AllowedModelsMode.hanyaTertentu,
                      child: Text(l10n.modeHanyaTertentu)),
                  DropdownMenuItem(
                      value: AllowedModelsMode.hanyaFavorit,
                      child: Text(l10n.modeHanyaFavorit)),
                ],
                onChanged: (v) async {
                  if (v == null) return;
                  await ref
                      .read(aiProviderRepositoryProvider)
                      .setAllowedMode(p.id, v);
                  ref.invalidate(daftarProviderAiProvider);
                },
              ),
              const SizedBox(height: FinaraSpacing.lg),
              _DropdownFallback(
                label: l10n.fallbackModel1,
                nilai: p.fallbackModel1,
                pilihan: idModel,
                onChanged: (v) async {
                  await ref.read(aiProviderRepositoryProvider).setFallback(
                      p.id, model1: v, model2: p.fallbackModel2);
                  ref.invalidate(daftarProviderAiProvider);
                },
              ),
              const SizedBox(height: FinaraSpacing.md),
              _DropdownFallback(
                label: l10n.fallbackModel2,
                nilai: p.fallbackModel2,
                pilihan: idModel,
                onChanged: (v) async {
                  await ref.read(aiProviderRepositoryProvider).setFallback(
                      p.id, model1: p.fallbackModel1, model2: v);
                  ref.invalidate(daftarProviderAiProvider);
                },
              ),
              const SizedBox(height: FinaraSpacing.md),
              DropdownButtonFormField<FallbackMode>(
                initialValue: p.fallbackMode,
                isExpanded: true,
                decoration:
                    InputDecoration(labelText: l10n.fallbackModeLabel),
                items: [
                  DropdownMenuItem(
                      value: FallbackMode.otomatis,
                      child: Text(l10n.fbOtomatis)),
                  DropdownMenuItem(
                      value: FallbackMode.konfirmasi,
                      child: Text(l10n.fbKonfirmasi)),
                  DropdownMenuItem(
                      value: FallbackMode.nonaktif,
                      child: Text(l10n.fbNonaktif)),
                ],
                onChanged: (v) async {
                  if (v == null) return;
                  await ref
                      .read(aiProviderRepositoryProvider)
                      .setFallbackMode(p.id, v);
                  ref.invalidate(daftarProviderAiProvider);
                },
              ),
              const SizedBox(height: FinaraSpacing.lg),
              TextField(
                decoration: InputDecoration(
                  labelText: l10n.cariModel,
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
                onChanged: (v) => setState(() => _cari = v),
              ),
              const SizedBox(height: FinaraSpacing.sm),
              if (models.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(FinaraSpacing.lg),
                  child: Text(l10n.belumAdaModel,
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center),
                )
              else
                for (final m in tersaring) _TileModel(provider: p, model: m,
                    onTes: () => _jalankan((p) => _tesModel(p, m)),
                    onTesStreaming: () =>
                        _jalankan((p) => _tesStreaming(p, m))),
              const Divider(height: FinaraSpacing.xxl),
              TextButton.icon(
                style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error),
                icon: const Icon(Icons.delete_forever_outlined),
                label: Text(l10n.hapusProvider),
                onPressed: _konfirmasiHapus,
              ),
              const SizedBox(height: FinaraSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _tambahManual() async {
    final l10n = AppLocalizations.of(context)!;
    final idCtrl = TextEditingController();
    final namaCtrl = TextEditingController();
    final simpan = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.tambahModelManual),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: idCtrl,
              decoration: InputDecoration(labelText: l10n.modelIdLabel),
            ),
            const SizedBox(height: FinaraSpacing.md),
            TextField(
              controller: namaCtrl,
              decoration: InputDecoration(labelText: l10n.namaTampilan),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.batal),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.simpan),
          ),
        ],
      ),
    );
    if (simpan == true && idCtrl.text.trim().isNotEmpty) {
      await ref.read(aiProviderRepositoryProvider).tambahModelManual(
            providerId: widget.providerId,
            modelId: idCtrl.text.trim(),
            displayName:
                namaCtrl.text.trim().isEmpty ? null : namaCtrl.text.trim(),
          );
      ref.invalidate(modelTersimpanProvider(widget.providerId));
    }
  }

  Future<void> _konfirmasiHapus() async {
    final l10n = AppLocalizations.of(context)!;
    final yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.hapusProvider),
        content: Text(l10n.hapusProviderPesan),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.batal),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.hapus),
          ),
        ],
      ),
    );
    if (yakin != true) return;
    await ref
        .read(aiProviderRepositoryProvider)
        .hapusProvider(widget.providerId);
    await ref.read(apiKeyStoreProvider).hapus(widget.providerId);
    ref
      ..invalidate(daftarProviderAiProvider)
      ..invalidate(daftarPercakapanProvider);
    if (mounted) context.pop();
  }
}

class _TileModel extends ConsumerWidget {
  const _TileModel({
    required this.provider,
    required this.model,
    required this.onTes,
    required this.onTesStreaming,
  });

  final AiProviderConfiguration provider;
  final AiModel model;
  final VoidCallback onTes;
  final VoidCallback onTesStreaming;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final repo = ref.read(aiProviderRepositoryProvider);

    String labelStatus(CapabilityStatus s) => switch (s) {
          CapabilityStatus.unknown => l10n.statusUnknown,
          CapabilityStatus.claimed => l10n.statusClaimed,
          CapabilityStatus.verified => l10n.statusVerified,
          CapabilityStatus.unsupported => l10n.statusUnsupported,
        };

    Future<void> segarkan() async {
      ref
        ..invalidate(modelTersimpanProvider(provider.id))
        ..invalidate(daftarProviderAiProvider);
    }

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Flexible(child: Text(model.displayName ?? model.modelId)),
          if (provider.modelDefault == model.modelId) ...[
            const SizedBox(width: FinaraSpacing.sm),
            Icon(Icons.check_circle_rounded,
                size: 16, color: theme.colorScheme.primary),
          ],
          if (model.diblokir) ...[
            const SizedBox(width: FinaraSpacing.sm),
            Icon(Icons.block_rounded,
                size: 16, color: theme.colorScheme.error),
          ],
        ],
      ),
      subtitle: Text(
        '${model.modelId}\n'
        'Chat: ${labelStatus(model.statusChat)} · '
        'Streaming: ${labelStatus(model.statusStreaming)}',
        style: theme.textTheme.bodySmall,
      ),
      isThreeLine: true,
      leading: IconButton(
        icon: Icon(
          model.favorit ? Icons.star_rounded : Icons.star_border_rounded,
          color: model.favorit ? theme.colorScheme.tertiary : null,
        ),
        tooltip: l10n.favorit,
        onPressed: () async {
          await repo.setFavorit(model.id, favorit: !model.favorit);
          await segarkan();
        },
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (aksi) async {
          switch (aksi) {
            case 'default':
              await repo.setModelDefault(provider.id, model.modelId);
            case 'blokir':
              await repo.setDiblokir(model.id, diblokir: !model.diblokir);
            case 'allowlist':
              await repo.setDiizinkan(model.id,
                  diizinkan: !model.diizinkan);
            case 'tes':
              onTes();
            case 'tesStreaming':
              onTesStreaming();
            case 'harga':
              await _dialogHarga(context, repo);
          }
          await segarkan();
        },
        itemBuilder: (context) => [
          PopupMenuItem(value: 'default', child: Text(l10n.jadikanDefault)),
          PopupMenuItem(value: 'tes', child: Text(l10n.tesModel)),
          PopupMenuItem(
              value: 'tesStreaming', child: Text(l10n.tesStreaming)),
          PopupMenuItem(
              value: 'blokir',
              child: Text(
                  model.diblokir ? l10n.bukaBlokirModel : l10n.blokirModel)),
          PopupMenuItem(
              value: 'allowlist',
              child: Text(model.diizinkan
                  ? l10n.keluarkanAllowlist
                  : l10n.masukkanAllowlist)),
          PopupMenuItem(value: 'harga', child: Text(l10n.aturHarga)),
        ],
      ),
    );
  }

  Future<void> _dialogHarga(
      BuildContext context, AIProviderRepository repo) async {
    final l10n = AppLocalizations.of(context)!;
    final inputCtrl = TextEditingController(
        text: model.hargaInputPerJuta?.toString() ?? '');
    final outputCtrl = TextEditingController(
        text: model.hargaOutputPerJuta?.toString() ?? '');
    final simpan = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.aturHarga),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: inputCtrl,
              decoration: InputDecoration(
                  labelText: l10n.hargaInputPerJuta, prefixText: 'Rp'),
              keyboardType: TextInputType.number,
              inputFormatters: const [RupiahInputFormatter()],
            ),
            const SizedBox(height: FinaraSpacing.md),
            TextField(
              controller: outputCtrl,
              decoration: InputDecoration(
                  labelText: l10n.hargaOutputPerJuta, prefixText: 'Rp'),
              keyboardType: TextInputType.number,
              inputFormatters: const [RupiahInputFormatter()],
            ),
            const SizedBox(height: FinaraSpacing.sm),
            Text(l10n.disclaimerBiaya,
                style: Theme.of(dialogContext).textTheme.bodySmall),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.batal),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.simpan),
          ),
        ],
      ),
    );
    if (simpan == true) {
      await repo.setHarga(
        model.id,
        inputPerJuta: parseRupiah(inputCtrl.text),
        outputPerJuta: parseRupiah(outputCtrl.text),
      );
    }
  }
}

class _DropdownFallback extends StatelessWidget {
  const _DropdownFallback({
    required this.label,
    required this.nilai,
    required this.pilihan,
    required this.onChanged,
  });

  final String label;
  final String? nilai;
  final List<String> pilihan;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DropdownButtonFormField<String?>(
      initialValue: pilihan.contains(nilai) ? nilai : null,
      decoration: InputDecoration(labelText: label),
      items: [
        DropdownMenuItem(value: null, child: Text(l10n.tanpaFallback)),
        for (final id in pilihan)
          DropdownMenuItem(value: id, child: Text(id)),
      ],
      onChanged: onChanged,
    );
  }
}
