import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/data_providers.dart';
import '../../app/phase_config.dart';
import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/basis_points.dart';
import '../../core/money.dart';
import '../../design_system/tokens/finara_colors.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/amount_text.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../design_system/widgets/layout_widgets.dart';
import '../../domain/ai/financial_context_builder.dart';
import '../../domain/models/ai_enums.dart';
import '../../domain/models/allocation_result.dart';
import '../../domain/services/dana_split_service.dart';
import '../../l10n/app_localizations.dart';
import '../dana_plus/dana_plus_page.dart';
import '../finara_ai/ai_providers.dart';
import '../hitung/hitung_controller.dart';

/// Hasil alokasi: donut ringkasan §20 + 4 card §19 + simpan ke riwayat.
class HasilPage extends ConsumerWidget {
  const HasilPage({super.key, required this.args});

  final HasilArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final hasil = args.hasil;
    final bulan = DateFormat('MMMM yyyy', 'id_ID')
        .format(DateTime(args.input.tahun, args.input.bulan));

    return Scaffold(
      appBar: AppBar(title: Text('${l10n.hasilAlokasi} — $bulan')),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.all(FinaraSpacing.lg),
            children: [
              _RingkasanDonut(hasil: hasil),
              const SizedBox(height: FinaraSpacing.lg),
              _CardBrimo(hasil: hasil),
              const SizedBox(height: FinaraSpacing.md),
              _CardJago(hasil: hasil),
              const SizedBox(height: FinaraSpacing.md),
              _CardInvestasi(hasil: hasil),
              const SizedBox(height: FinaraSpacing.md),
              _CardDana(hasil: hasil),
              if (ref.watch(appPhaseProvider).isAtLeast(AppPhase.fase2)) ...[
                const SizedBox(height: FinaraSpacing.lg),
                OutlinedButton.icon(
                  icon: const Icon(Icons.smart_toy_outlined),
                  label: Text(l10n.tanyakanHasilIniKeAi),
                  onPressed: () => _tanyaAi(context, ref),
                ),
              ],
              const SizedBox(height: FinaraSpacing.xxl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: StickyActionBar(
        child: FilledButton.icon(
          onPressed: () => _simpan(context, ref),
          icon: const Icon(Icons.save_outlined),
          label: Text(l10n.simpanKeRiwayat),
        ),
      ),
    );
  }

  Future<void> _tanyaAi(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final provider = await ref.read(providerAiAktifProvider.future);
    if (!context.mounted) return;
    if (provider == null) {
      await context.push(FinaraRoutes.aiPengaturan);
      return;
    }
    if (provider.izinData == AIDataScope.tanpaAkses) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.izinDataDiperlukan)));
      return;
    }
    if (provider.modelDefault == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errModelTidakTersedia)));
      return;
    }

    final hasil = args.hasil;
    final konteks = const FinancialContextBuilder().bangunKonteksAlokasi(
      tahun: args.input.tahun,
      bulan: args.input.bulan,
      totalPendapatan: hasil.totalPendapatan,
      kasPeganganBrimo: hasil.kasPeganganBrimo,
      totalPengeluaranWajib: hasil.totalPengeluaranWajib,
      totalDanaMasukJago: hasil.totalDanaMasukJago,
      danaBersih: hasil.danaBersih,
      alokasiJago: hasil.alokasiJago,
      totalAlokasiInvestasi: hasil.totalAlokasiInvestasi,
      alokasiBibit: hasil.alokasiBibit,
      alokasiStockbit: hasil.alokasiStockbit,
      alokasiDana: hasil.alokasiDana,
      subJagoLangganan: hasil.subAlokasiJago.kebutuhanLangganan,
      subJagoDanaDarurat: hasil.subAlokasiJago.danaDarurat,
      subJagoOperasional: hasil.subAlokasiJago.danaOperasional,
      namaPreset: args.namaPreset,
    );

    // Persetujuan eksplisit sebelum data dikirim (§43–§44).
    final setuju = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.tanyakanHasilIniKeAi),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.konteksAkanDikirim),
                const SizedBox(height: FinaraSpacing.md),
                Text(konteks,
                    style: Theme.of(dialogContext).textTheme.bodySmall),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.batal),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.kirimDanTanya),
          ),
        ],
      ),
    );
    if (setuju != true || !context.mounted) return;

    final chatRepo = ref.read(chatRepositoryProvider);
    final convId = await chatRepo.buatPercakapan(
      judul: l10n.tanyakanHasilIniKeAi,
      providerId: provider.id,
      modelId: provider.modelDefault!,
    );
    await chatRepo.tambahPesan(
        conversationId: convId, role: 'user', content: konteks);
    ref.invalidate(daftarPercakapanProvider);
    if (!context.mounted) return;
    await context.push('${FinaraRoutes.aiChat}/$convId');
  }

  Future<void> _simpan(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final repo = ref.read(allocationRepositoryProvider);
    final revisiId = await repo.simpanRevisi(
      input: args.input,
      hasil: args.hasil,
      namaPreset: args.namaPreset,
    );
    ref.read(hitungControllerProvider.notifier).reset();
    ref
      ..invalidate(revisiBulanAktifProvider)
      ..invalidate(daftarRiwayatProvider);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.tersimpanKeRiwayat)));
    context.go('${FinaraRoutes.riwayat}/$revisiId');
  }
}

class _RingkasanDonut extends StatelessWidget {
  const _RingkasanDonut({required this.hasil});

  final AllocationResult hasil;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Pemetaan kategori §20.
    final bagian = <(String, int, Color)>[
      (l10n.kategoriKebutuhan, hasil.totalPengeluaranWajib,
          FinaraColors.bankJago),
      (l10n.kategoriKasPegangan, hasil.kasPeganganBrimo,
          FinaraColors.brimo),
      (l10n.kategoriTabungan, hasil.subAlokasiJago.danaDarurat,
          FinaraColors.success),
      (l10n.kategoriInvestasi, hasil.totalAlokasiInvestasi,
          FinaraColors.stockbit),
      (l10n.kategoriUangJajan, hasil.alokasiDana, FinaraColors.dana),
      (
        l10n.kategoriOperasional,
        hasil.subAlokasiJago.kebutuhanLangganan +
            hasil.subAlokasiJago.danaOperasional,
        theme.colorScheme.tertiary
      ),
    ].where((b) => b.$2 > 0).toList();

    return FinaraCard(
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 44,
                sections: [
                  for (final b in bagian)
                    PieChartSectionData(
                      value: b.$2.toDouble(),
                      color: b.$3,
                      showTitle: false,
                      radius: 32,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: FinaraSpacing.md),
          Wrap(
            spacing: FinaraSpacing.md,
            runSpacing: FinaraSpacing.xs,
            children: [
              for (final b in bagian)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: b.$3, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: FinaraSpacing.xs),
                    Text('${b.$1} ${formatRupiah(b.$2)}',
                        style: theme.textTheme.bodySmall),
                  ],
                ),
            ],
          ),
          const Divider(height: FinaraSpacing.xl),
          _BarisNominal(l10n.totalPendapatan, hasil.totalPendapatan),
          _BarisNominal(l10n.totalPengeluaranWajib,
              hasil.totalPengeluaranWajib),
          _BarisNominal(l10n.danaBersih, hasil.danaBersih),
          _BarisNominal(
              l10n.selisihBelumDialokasikan, hasil.selisihBelumDialokasikan),
        ],
      ),
    );
  }
}

class _CardBrimo extends StatelessWidget {
  const _CardBrimo({required this.hasil});

  final AllocationResult hasil;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final efektif = AllocationResult.persentaseEfektifBp(
        hasil.kasPeganganBrimo, hasil.totalPendapatan);
    return FinaraCard(
      accentColor: FinaraColors.brimo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _JudulCard(l10n.kartuBrimo, l10n.kasPeganganRencana,
              ikon: Icons.account_balance_rounded,
              warna: FinaraColors.brimo),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AmountText(hasil.kasPeganganBrimo),
              _TombolSalin(nominal: hasil.kasPeganganBrimo),
            ],
          ),
          if (efektif != null)
            Text(
              l10n.persenDariTotalPendapatan(formatBasisPoints(efektif)),
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}

class _CardJago extends StatelessWidget {
  const _CardJago({required this.hasil});

  final AllocationResult hasil;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sub = hasil.subAlokasiJago;
    return FinaraCard(
      accentColor: FinaraColors.bankJago,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _JudulCard(l10n.kartuJago, l10n.totalTransferAwalJago,
              ikon: Icons.savings_rounded, warna: FinaraColors.bankJago),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AmountText(hasil.totalDanaMasukJago),
              _TombolSalin(nominal: hasil.totalDanaMasukJago),
            ],
          ),
          const Divider(height: FinaraSpacing.xl),
          _BarisNominal(
              l10n.kantongPengeluaranWajib, hasil.totalPengeluaranWajib),
          _BarisNominal(
              l10n.alokasiJagoDariDanaBersih, hasil.alokasiJago),
          _BarisNominal(l10n.kantongLangganan, sub.kebutuhanLangganan),
          _BarisNominal(l10n.kantongDanaDarurat, sub.danaDarurat),
          _BarisNominal(l10n.kantongOperasional, sub.danaOperasional),
        ],
      ),
    );
  }
}

class _CardInvestasi extends StatelessWidget {
  const _CardInvestasi({required this.hasil});

  final AllocationResult hasil;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final dariBersih = AllocationResult.persentaseEfektifBp(
        hasil.totalAlokasiInvestasi, hasil.danaBersih);
    final bibitPersen = AllocationResult.persentaseEfektifBp(
        hasil.alokasiBibit, hasil.totalAlokasiInvestasi);
    final stockbitPersen = AllocationResult.persentaseEfektifBp(
        hasil.alokasiStockbit, hasil.totalAlokasiInvestasi);

    return FinaraCard(
      accentColor: FinaraColors.stockbit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _JudulCard(l10n.kartuInvestasi, l10n.totalAlokasiInvestasiRencana,
              ikon: Icons.trending_up_rounded,
              warna: FinaraColors.stockbit),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AmountText(hasil.totalAlokasiInvestasi),
              _TombolSalin(nominal: hasil.totalAlokasiInvestasi),
            ],
          ),
          if (dariBersih != null)
            Text(
              l10n.persenDariDanaBersih(formatBasisPoints(dariBersih)),
              style: theme.textTheme.bodySmall,
            ),
          if (hasil.totalAlokasiInvestasi > 0) ...[
            const SizedBox(height: FinaraSpacing.md),
            if (hasil.alokasiBibit > 0)
              _SubCardInvestasi(
                warna: FinaraColors.bibit,
                judul: l10n.alokasiBibitRencana,
                nominal: hasil.alokasiBibit,
                keterangan: bibitPersen == null
                    ? null
                    : l10n.persenDariInvestasi(
                        formatBasisPoints(bibitPersen)),
              ),
            if (hasil.alokasiStockbit > 0) ...[
              const SizedBox(height: FinaraSpacing.sm),
              _SubCardInvestasi(
                warna: FinaraColors.stockbit,
                judul: l10n.alokasiStockbitRencana,
                nominal: hasil.alokasiStockbit,
                keterangan: stockbitPersen == null
                    ? null
                    : '${l10n.persenDariInvestasi(formatBasisPoints(stockbitPersen))} · ${l10n.targetTransferRdn}',
              ),
            ],
          ],
          const SizedBox(height: FinaraSpacing.md),
          Text(
            l10n.peringatanRisikoInvestasi,
            style: theme.textTheme.bodySmall!
                .copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _SubCardInvestasi extends StatelessWidget {
  const _SubCardInvestasi({
    required this.warna,
    required this.judul,
    required this.nominal,
    this.keterangan,
  });

  final Color warna;
  final String judul;
  final int nominal;
  final String? keterangan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(FinaraSpacing.md),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(FinaraRadius.md),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(judul, style: theme.textTheme.bodyMedium),
                AmountText(nominal, style: theme.textTheme.titleLarge),
                if (keterangan != null)
                  Text(keterangan!, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          _TombolSalin(nominal: nominal),
        ],
      ),
    );
  }
}

class _CardDana extends ConsumerWidget {
  const _CardDana({required this.hasil});

  final AllocationResult hasil;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final jadwal = hasil.jadwalDana;
    // Pembagian DANA+ target bulanan (§92) bila dikonfigurasi aktif.
    final config = ref.watch(danaPlusConfigProvider).value;
    DanaSplitResult? split;
    if (config != null &&
        config.availability == DanaPlusAvailability.menggunakan &&
        hasil.alokasiDana > 0) {
      split = const DanaSplitService().hitung(DanaSplitInput(
        danaDasarPembagian: hasil.alokasiDana,
        mode: config.defaultSplitMode,
        persenBiasaBp: config.persenBiasaBp,
        nominalBufferBiasa: config.bufferBiasa,
        targetNominalPlus: config.targetPlus,
        sisaAnggaranAktual: hasil.alokasiDana,
        // Target bulanan penuh: horizon Smart Liquidity 7 dari 30 hari.
        hariTersisaPeriode: 30,
        batasDanaPlus: config.batasPlus,
      ));
    }
    return FinaraCard(
      accentColor: FinaraColors.dana,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _JudulCard(l10n.kartuDana, l10n.totalAlokasiDanaRencana,
              ikon: Icons.qr_code_scanner_rounded,
              warna: FinaraColors.dana),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AmountText(hasil.alokasiDana),
              _TombolSalin(nominal: hasil.alokasiDana),
            ],
          ),
          const Divider(height: FinaraSpacing.xl),
          if (split != null) ...[
            _BarisNominal(l10n.saldoDanaBiasa, split.saldoBiasa),
            _BarisNominal(l10n.saldoDanaPlus, split.saldoPlus),
            const Divider(height: FinaraSpacing.xl),
          ],
          _BarisNominal(
              l10n.anggaranHarianDasar, jadwal.uangJajanHarianDasar),
          if (jadwal.jadwalTopUp.isNotEmpty)
            _BarisNominal(
                l10n.anggaranPerTopUp, jadwal.jadwalTopUp.first.nominal),
          const SizedBox(height: FinaraSpacing.sm),
          Text(l10n.jadwalTopUp,
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: FinaraSpacing.xs),
          Wrap(
            spacing: FinaraSpacing.sm,
            runSpacing: FinaraSpacing.xs,
            children: [
              for (final e in jadwal.jadwalTopUp.take(8))
                Chip(
                  label: Text(
                    '${DateFormat('d MMM', 'id_ID').format(e.tanggal)} · ${formatRupiah(e.nominal)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              if (jadwal.jadwalTopUp.length > 8)
                Chip(
                  label: Text('+${jadwal.jadwalTopUp.length - 8}'),
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _JudulCard extends StatelessWidget {
  const _JudulCard(this.platform, this.subjudul,
      {required this.ikon, required this.warna});

  final String platform;
  final String subjudul;
  final IconData ikon;
  final Color warna;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: FinaraSpacing.sm),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: warna.withValues(alpha: 0.14),
            child: Icon(ikon, size: 18, color: warna),
          ),
          const SizedBox(width: FinaraSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(platform, style: theme.textTheme.titleMedium),
                Text(subjudul,
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BarisNominal extends StatelessWidget {
  const _BarisNominal(this.label, this.nominal);

  final String label;
  final int nominal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FinaraSpacing.xs / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(label, style: theme.textTheme.bodyMedium)),
          AmountText(nominal, style: theme.textTheme.titleSmall),
        ],
      ),
    );
  }
}

class _TombolSalin extends StatelessWidget {
  const _TombolSalin({required this.nominal});

  final int nominal;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return IconButton(
      icon: const Icon(Icons.copy_rounded, size: 20),
      tooltip: l10n.salinNominal,
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: '$nominal'));
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.nominalTersalin)));
      },
    );
  }
}
