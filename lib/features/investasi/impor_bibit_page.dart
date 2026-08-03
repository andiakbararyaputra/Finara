import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../app/data_providers.dart';
import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/money.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/empty_state.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../domain/services/bibit_statement_parser.dart';
import '../../l10n/app_localizations.dart';

/// Hasil pemilihan + ekstraksi dokumen; di-override pada widget test.
typedef DokumenTerpilih = ({String teks, String nama, String hash});

final pilihDanEkstrakPdfProvider = Provider<
    Future<DokumenTerpilih?> Function(
        {Future<String?> Function()? mintaPassword})>((ref) {
  return ({mintaPassword}) async {
    final hasil = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );
    final bytes = hasil?.files.single.bytes;
    if (bytes == null) return null;
    // §69: password hanya utk sesi ini — tidak disimpan, dicatat,
    // atau dipertahankan di state.
    String? password;
    while (true) {
      // Ekstraksi di isolate agar UI tidak beku (§81).
      final ekstrak =
          await compute(_ekstrakTeks, (bytes: bytes, password: password));
      if (!ekstrak.terproteksi) {
        return (
          teks: ekstrak.teks ?? '',
          nama: hasil!.files.single.name,
          hash: fingerprintDokumen(bytes),
        );
      }
      if (mintaPassword == null) return null;
      password = await mintaPassword();
      if (password == null || password.isEmpty) return null;
    }
  };
});

({String? teks, bool terproteksi}) _ekstrakTeks(
    ({Uint8List bytes, String? password}) args) {
  PdfDocument? dokumen;
  try {
    dokumen =
        PdfDocument(inputBytes: args.bytes, password: args.password);
    // Hanya lapisan teks asli; tanpa OCR (§63).
    return (
      teks: PdfTextExtractor(dokumen).extractText(),
      terproteksi: false,
    );
  } catch (e) {
    // Syncfusion melempar error berisi kata 'password' utk PDF terkunci.
    if (e.toString().toLowerCase().contains('password')) {
      return (teks: null, terproteksi: true);
    }
    rethrow;
  } finally {
    dokumen?.dispose();
  }
}

/// Impor Statement of Account Bibit (§62–§73, MVP §84).
class ImporBibitPage extends ConsumerStatefulWidget {
  const ImporBibitPage({super.key});

  @override
  ConsumerState<ImporBibitPage> createState() => _ImporBibitPageState();
}

class _ImporBibitPageState extends ConsumerState<ImporBibitPage> {
  bool _sibuk = false;
  String? _pesan;
  DokumenTerpilih? _dokumen;
  BibitParseResult? _hasil;

  final _bulanCtrl = TextEditingController();
  final _tahunCtrl = TextEditingController();
  final _portofolioCtrl = TextEditingController();
  final _modalCtrl = TextEditingController();
  final _pembelianCtrl = TextEditingController();
  final _penjualanCtrl = TextEditingController();

  @override
  void dispose() {
    for (final c in [
      _bulanCtrl,
      _tahunCtrl,
      _portofolioCtrl,
      _modalCtrl,
      _pembelianCtrl,
      _penjualanCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pilih() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _sibuk = true;
      _pesan = null;
    });
    try {
      final dokumen = await ref.read(pilihDanEkstrakPdfProvider)(
          mintaPassword: () => _dialogPasswordPdf(context));
      if (dokumen == null) return;
      // Anti-duplikat berdasarkan hash file (§73).
      final duplikat = await ref
          .read(importRepositoryProvider)
          .sudahPernahDiimpor(dokumen.hash);
      if (duplikat) {
        setState(() => _pesan = l10n.dokumenDuplikat);
        return;
      }
      final hasil = const BibitStatementParser().parse(dokumen.teks);
      setState(() {
        _dokumen = dokumen;
        _hasil = hasil;
        _bulanCtrl.text = hasil.bulan?.toString() ?? '';
        _tahunCtrl.text = hasil.tahun?.toString() ?? '';
        _isiNominal(_portofolioCtrl, hasil.nilaiPortofolio.nilai);
        _isiNominal(_modalCtrl, hasil.modalInvestasi.nilai);
        _isiNominal(_pembelianCtrl, hasil.totalPembelian.nilai);
        _isiNominal(_penjualanCtrl, hasil.totalPenjualan.nilai);
        if (!hasil.dikenaliSebagaiBibit) _pesan = l10n.jenisTidakDikenali;
      });
    } catch (_) {
      setState(() => _pesan = l10n.gagalMembacaPdf);
    } finally {
      if (mounted) setState(() => _sibuk = false);
    }
  }

  void _isiNominal(TextEditingController c, int? nilai) {
    c.text = nilai == null ? '' : formatRupiah(nilai).substring(2);
  }

  /// §69: password sekali pakai; controller lokal dialog, tidak disimpan.
  Future<String?> _dialogPasswordPdf(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final ctrl = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.pdfTerproteksiJudul),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: ctrl,
              obscureText: true,
              autofocus: true,
              decoration:
                  InputDecoration(labelText: l10n.passwordPdfLabel),
            ),
            const SizedBox(height: FinaraSpacing.sm),
            Text(l10n.infoPasswordPdf,
                style: Theme.of(dialogContext).textTheme.bodySmall),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.batal),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, ctrl.text),
            child: Text(l10n.bukaPdf),
          ),
        ],
      ),
    );
  }

  Future<void> _konfirmasi() async {
    final l10n = AppLocalizations.of(context)!;
    final dokumen = _dokumen;
    if (dokumen == null) return;
    final bulan = int.tryParse(_bulanCtrl.text);
    final tahun = int.tryParse(_tahunCtrl.text);
    if (bulan == null || bulan < 1 || bulan > 12 || tahun == null) {
      setState(() => _pesan = l10n.periodeWajib);
      return;
    }
    await ref.read(importRepositoryProvider).konfirmasiImporBibit(
          fileHash: dokumen.hash,
          namaFile: dokumen.nama,
          tahun: tahun,
          bulan: bulan,
          nilaiPortofolio: parseRupiah(_portofolioCtrl.text),
          modalInvestasi: parseRupiah(_modalCtrl.text),
          totalPembelian: parseRupiah(_pembelianCtrl.text),
          totalPenjualan: parseRupiah(_penjualanCtrl.text),
        );
    ref
      ..invalidate(aktualInvestasiBulanIniProvider)
      ..invalidate(kontribusiGabunganProvider)
      ..invalidate(skorKesehatanProvider)
      ..invalidate(riwayatImporProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.imporBerhasil)));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final hasil = _hasil;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.imporLaporanBibit)),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.all(FinaraSpacing.lg),
            children: [
              Wrap(
                spacing: FinaraSpacing.sm,
                runSpacing: FinaraSpacing.sm,
                children: [
                  FilledButton.icon(
                    onPressed: _sibuk ? null : _pilih,
                    icon: const Icon(Icons.picture_as_pdf_outlined),
                    label: Text(l10n.pilihPdf),
                  ),
                  OutlinedButton(
                    onPressed: () =>
                        context.push(FinaraRoutes.investasiAktual),
                    child: Text(l10n.catatInvestasiAktual),
                  ),
                ],
              ),
              if (_sibuk) ...[
                const SizedBox(height: FinaraSpacing.md),
                const LinearProgressIndicator(),
                const SizedBox(height: FinaraSpacing.xs),
                Text(l10n.sedangMembacaDokumen,
                    style: theme.textTheme.bodySmall),
              ],
              if (_pesan != null) ...[
                const SizedBox(height: FinaraSpacing.md),
                Text(_pesan!,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: theme.colorScheme.tertiary)),
              ],
              if (hasil != null && _dokumen != null) ...[
                const SizedBox(height: FinaraSpacing.lg),
                FinaraCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ringkasNamaFile(_dokumen!.nama),
                          style: theme.textTheme.titleSmall),
                      const SizedBox(height: FinaraSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _bulanCtrl,
                              decoration: InputDecoration(
                                  labelText:
                                      '${l10n.periodeLaporan} — bulan'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: FinaraSpacing.md),
                          Expanded(
                            child: TextField(
                              controller: _tahunCtrl,
                              decoration: const InputDecoration(
                                  labelText: 'Tahun'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: FinaraSpacing.md),
                      _FieldPratinjau(
                        label: l10n.nilaiPortofolio,
                        controller: _portofolioCtrl,
                        confidence: hasil.nilaiPortofolio.confidence,
                      ),
                      _FieldPratinjau(
                        label: l10n.modalInvestasi,
                        controller: _modalCtrl,
                        confidence: hasil.modalInvestasi.confidence,
                      ),
                      _FieldPratinjau(
                        label: l10n.pembelianBersih,
                        controller: _pembelianCtrl,
                        confidence: hasil.totalPembelian.confidence,
                      ),
                      _FieldPratinjau(
                        label: l10n.penjualanBersih,
                        controller: _penjualanCtrl,
                        confidence: hasil.totalPenjualan.confidence,
                      ),
                      const SizedBox(height: FinaraSpacing.md),
                      FilledButton(
                        onPressed: _konfirmasi,
                        child: Text(l10n.konfirmasiImpor),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: FinaraSpacing.lg),
              const _RiwayatImpor(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldPratinjau extends StatelessWidget {
  const _FieldPratinjau({
    required this.label,
    required this.controller,
    required this.confidence,
  });

  final String label;
  final TextEditingController controller;
  final ParseConfidence confidence;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final tinggi = confidence == ParseConfidence.tinggi;
    return Padding(
      padding: const EdgeInsets.only(bottom: FinaraSpacing.md),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixText: 'Rp',
          isDense: true,
          helperText:
              tinggi ? l10n.confidenceTinggi : l10n.confidenceRendah,
          helperStyle: theme.textTheme.bodySmall!.copyWith(
            color: tinggi
                ? theme.colorScheme.primary
                : theme.colorScheme.tertiary,
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: const [RupiahInputFormatter()],
      ),
    );
  }
}

final riwayatImporProvider = FutureProvider((ref) {
  return ref.watch(importRepositoryProvider).riwayatImpor();
});

class _RiwayatImpor extends ConsumerWidget {
  const _RiwayatImpor();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final riwayat = ref.watch(riwayatImporProvider).value ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.lihatRiwayatImpor, style: theme.textTheme.titleMedium),
        const SizedBox(height: FinaraSpacing.sm),
        if (riwayat.isEmpty)
          EmptyState(
            icon: Icons.upload_file_outlined,
            title: l10n.belumAdaImpor,
            message: l10n.pilihPdf,
          )
        else
          for (final r in riwayat)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.description_outlined),
              title: Text(ringkasNamaFile(r.namaFile)),
              subtitle: Text('${r.bulan ?? '-'}/${r.tahun ?? '-'}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline_rounded),
                tooltip: l10n.hapusCatatanImpor,
                onPressed: () async {
                  await ref
                      .read(importRepositoryProvider)
                      .hapusCatatan(r.id);
                  ref.invalidate(riwayatImporProvider);
                },
              ),
            ),
      ],
    );
  }
}
