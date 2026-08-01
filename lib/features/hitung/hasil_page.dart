import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/data_providers.dart';
import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/basis_points.dart';
import '../../core/money.dart';
import '../../design_system/tokens/finara_colors.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/amount_text.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../design_system/widgets/layout_widgets.dart';
import '../../domain/models/allocation_result.dart';
import '../../l10n/app_localizations.dart';
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
          _JudulCard(l10n.kartuBrimo, l10n.kasPeganganRencana),
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
          _JudulCard(l10n.kartuJago, l10n.totalTransferAwalJago),
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
          _JudulCard(l10n.kartuInvestasi, l10n.totalAlokasiInvestasiRencana),
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

class _CardDana extends StatelessWidget {
  const _CardDana({required this.hasil});

  final AllocationResult hasil;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final jadwal = hasil.jadwalDana;
    return FinaraCard(
      accentColor: FinaraColors.dana,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _JudulCard(l10n.kartuDana, l10n.totalAlokasiDanaRencana),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AmountText(hasil.alokasiDana),
              _TombolSalin(nominal: hasil.alokasiDana),
            ],
          ),
          const Divider(height: FinaraSpacing.xl),
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
  const _JudulCard(this.platform, this.subjudul);

  final String platform;
  final String subjudul;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: FinaraSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(platform, style: theme.textTheme.titleMedium),
          Text(subjudul,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onSurfaceVariant)),
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
