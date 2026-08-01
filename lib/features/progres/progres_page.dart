import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/data_providers.dart';
import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/basis_points.dart';
import '../../core/money.dart';
import '../../data/db/app_database.dart';
import '../../design_system/tokens/finara_colors.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/empty_state.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../domain/models/finance_enums.dart';
import '../../domain/services/financial_health_score_service.dart';
import '../../domain/services/stockbit_reconciliation_service.dart';
import '../../l10n/app_localizations.dart';

/// Progres (§23–§24): dana darurat, skor kesehatan, savings rate,
/// checklist, dan perbandingan bulanan.
class ProgresPage extends ConsumerWidget {
  const ProgresPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final revisi = ref.watch(revisiBulanAktifProvider).value;
    final target = ref.watch(targetDanaDaruratProvider).value;

    final adaData = revisi != null || target != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navProgres),
        actions: [
          IconButton(
            icon: const Icon(Icons.science_outlined),
            tooltip: l10n.bagaimanaJika,
            onPressed: () => context.push(FinaraRoutes.simulasi),
          ),
        ],
      ),
      body: !adaData
          ? EmptyState(
              icon: Icons.insights_outlined,
              title: l10n.progresKosongJudul,
              message: l10n.progresKosongPesan,
              actionLabel: l10n.aturTargetDanaDarurat,
              onAction: () => _dialogTarget(context, ref),
            )
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: FinaraSpacing.maxContentWidth),
                child: ListView(
                  padding: const EdgeInsets.all(FinaraSpacing.lg),
                  children: [
                    const _CardSkor(),
                    const SizedBox(height: FinaraSpacing.md),
                    _CardDanaDarurat(
                      target: target,
                      kontribusiBulanIni: revisi?.subJagoDanaDarurat,
                      onAturTarget: () => _dialogTarget(context, ref),
                    ),
                    const SizedBox(height: FinaraSpacing.md),
                    const _CardSavingsRate(),
                    const SizedBox(height: FinaraSpacing.md),
                    const _CardInvestasiGabungan(),
                    const SizedBox(height: FinaraSpacing.md),
                    if (revisi != null) _CardChecklist(revisiId: revisi.id),
                    const SizedBox(height: FinaraSpacing.md),
                    const _CardPerbandingan(),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _dialogTarget(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final bulanCtrl = TextEditingController(text: '6');
    final pokokCtrl = TextEditingController();
    final saldoCtrl = TextEditingController();

    final simpan = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.aturTargetDanaDarurat),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: bulanCtrl,
              decoration:
                  InputDecoration(labelText: l10n.jumlahBulanTarget),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: FinaraSpacing.md),
            TextField(
              controller: pokokCtrl,
              decoration: InputDecoration(
                  labelText: l10n.totalPengeluaranWajib, prefixText: 'Rp'),
              keyboardType: TextInputType.number,
              inputFormatters: const [RupiahInputFormatter()],
            ),
            const SizedBox(height: FinaraSpacing.md),
            TextField(
              controller: saldoCtrl,
              decoration: InputDecoration(
                  labelText: l10n.saldoSaatIni, prefixText: 'Rp'),
              keyboardType: TextInputType.number,
              inputFormatters: const [RupiahInputFormatter()],
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

    if (simpan == true) {
      final bulan = int.tryParse(bulanCtrl.text) ?? 0;
      if (bulan > 0) {
        await ref.read(emergencyFundRepositoryProvider).simpanTarget(
              targetJumlahBulan: bulan,
              pengeluaranPokokManual: parseRupiah(pokokCtrl.text),
              saldoSaatIni: parseRupiah(saldoCtrl.text) ?? 0,
            );
        ref
          ..invalidate(targetDanaDaruratProvider)
          ..invalidate(skorKesehatanProvider);
      }
    }
  }
}

class _CardSkor extends ConsumerWidget {
  const _CardSkor();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final skor = ref.watch(skorKesehatanProvider).value;
    if (skor == null) return const SizedBox.shrink();

    final labelKategori = switch (skor.kategori) {
      HealthScoreCategory.perluPerhatian => l10n.kategoriPerluPerhatian,
      HealthScoreCategory.cukupBerisiko => l10n.kategoriCukupBerisiko,
      HealthScoreCategory.cukupSehat => l10n.kategoriCukupSehat,
      HealthScoreCategory.sangatSehat => l10n.kategoriSangatSehat,
      null => null,
    };

    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.skorKesehatan, style: theme.textTheme.titleMedium),
          const SizedBox(height: FinaraSpacing.xs),
          Text(l10n.descSkorKesehatan,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: FinaraSpacing.sm),
          if (skor.skor == null)
            Text(l10n.skorTidakTersedia, style: theme.textTheme.bodySmall)
          else ...[
            Center(
              child: SizedBox(
                width: 132,
                height: 132,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: skor.skor! / 100,
                      strokeWidth: 10,
                      strokeCap: StrokeCap.round,
                      color: _warnaKategori(theme, skor.kategori),
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${skor.skor}',
                              style: theme.textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: _warnaKategori(
                                      theme, skor.kategori))),
                          Text('/100', style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: FinaraSpacing.sm),
            Center(
              child: Text(labelKategori ?? '',
                  style: theme.textTheme.titleSmall!.copyWith(
                      color: _warnaKategori(theme, skor.kategori))),
            ),
            Center(
              child: Text(
                l10n.kelengkapanData(
                    formatBasisPoints(skor.kelengkapanBp)),
                style: theme.textTheme.bodySmall,
              ),
            ),
            const Divider(height: FinaraSpacing.xl),
            for (final k in skor.komponen)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _labelKomponen(l10n, k.id) +
                            (k.id == HealthComponentId.rasioUangJajan
                                ? ' (${k.basisAktual ? l10n.basisAktual : l10n.basisRencana})'
                                : ''),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: k.tersedia
                              ? null
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Text(
                      k.tersedia
                          ? l10n.poinDariBobot(k.poin, k.bobot)
                          : l10n.tidakTersedia,
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: k.tersedia
                            ? null
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }

  String _labelKomponen(AppLocalizations l10n, HealthComponentId id) {
    return switch (id) {
      HealthComponentId.danaDarurat => l10n.kompDanaDarurat,
      HealthComponentId.rasioWajib => l10n.kompRasioWajib,
      HealthComponentId.rasioCicilan => l10n.kompRasioCicilan,
      HealthComponentId.konsistensiInvestasi =>
        l10n.kompKonsistensiInvestasi,
      HealthComponentId.rasioUangJajan => l10n.kompRasioUangJajan,
      HealthComponentId.checklist => l10n.kompChecklist,
    };
  }

  Color _warnaKategori(ThemeData theme, HealthScoreCategory? kategori) {
    return switch (kategori) {
      HealthScoreCategory.perluPerhatian => theme.colorScheme.error,
      HealthScoreCategory.cukupBerisiko => FinaraColors.warning,
      HealthScoreCategory.cukupSehat => FinaraColors.info,
      HealthScoreCategory.sangatSehat => FinaraColors.success,
      null => theme.colorScheme.onSurfaceVariant,
    };
  }
}

class _CardSavingsRate extends ConsumerWidget {
  const _CardSavingsRate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final rencanaBp = ref.watch(savingsRateRencanaProvider).value;

    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.descSavingsRate,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: FinaraSpacing.xs),
          _BarisNilai(
              l10n.savingsRateRencana,
              rencanaBp == null
                  ? l10n.tidakTersedia
                  : formatBasisPoints(rencanaBp)),
          // Aktual butuh realisasi kontribusi terverifikasi (§23).
          _BarisNilai(l10n.savingsRateAktual, l10n.tidakTersedia),
        ],
      ),
    );
  }
}

class _CardPerbandingan extends ConsumerWidget {
  const _CardPerbandingan();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final entries =
        (ref.watch(daftarRiwayatProvider).value ?? const []).take(12).toList();
    if (entries.length < 2) return const SizedBox.shrink();
    final maksimal = entries
        .map((e) => e.revisi.totalPendapatan)
        .reduce((a, b) => a > b ? a : b);

    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.perbandinganBulanan, style: theme.textTheme.titleMedium),
          const SizedBox(height: FinaraSpacing.xs),
          Text(l10n.descPerbandingan,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: FinaraSpacing.sm),
          for (final e in entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  SizedBox(
                    width: 72,
                    child: Text(
                      DateFormat('MMM yy', 'id_ID')
                          .format(DateTime(e.bulan.tahun, e.bulan.bulan)),
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: maksimal == 0
                          ? 0
                          : e.revisi.totalPendapatan / maksimal,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: FinaraSpacing.sm),
                  Text(formatRupiah(e.revisi.totalPendapatan),
                      style: theme.textTheme.bodySmall),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _CardInvestasiGabungan extends ConsumerWidget {
  const _CardInvestasiGabungan();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final revisi = ref.watch(revisiBulanAktifProvider).value;
    final gabungan = ref.watch(kontribusiGabunganProvider).value;
    final rekon = ref.watch(rekonsiliasiStockbitProvider).value;
    final aktualBibit = ref
        .watch(aktualInvestasiBulanIniProvider(InvestmentPlatform.bibit))
        .value;

    String nilaiAtauTidakTersedia(int? v) =>
        v == null ? l10n.tidakTersedia : formatRupiah(v);

    final labelStatus = switch (rekon?.status) {
      FundingReconciliationStatus.belumTercapai => l10n.statusBelumTercapai,
      FundingReconciliationStatus.mendekatiTarget =>
        l10n.statusMendekatiTarget,
      FundingReconciliationStatus.sesuaiTarget => l10n.statusSesuaiTarget,
      FundingReconciliationStatus.melebihiTarget =>
        l10n.statusMelebihiTarget,
      _ => l10n.statusTidakDapatDibandingkan,
    };

    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(l10n.investasiGabungan,
                    style: theme.textTheme.titleMedium),
              ),
              IconButton(
                icon: const Icon(Icons.upload_file_outlined),
                tooltip: l10n.imporLaporanBibit,
                onPressed: () => context.push(FinaraRoutes.imporBibit),
              ),
              IconButton(
                icon: const Icon(Icons.edit_note_rounded),
                tooltip: l10n.catatInvestasiAktual,
                onPressed: () =>
                    context.push(FinaraRoutes.investasiAktual),
              ),
            ],
          ),
          Text(l10n.descInvestasiGabungan,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: FinaraSpacing.xs),
          if (revisi != null) ...[
            _BarisNilai('${l10n.bagianInvestasi} — ${l10n.rencana}',
                formatRupiah(revisi.totalAlokasiInvestasi)),
            _BarisNilai('${l10n.bagianBibit} — ${l10n.rencana}',
                formatRupiah(revisi.alokasiBibit)),
            _BarisNilai('${l10n.bagianStockbit} — ${l10n.rencana}',
                formatRupiah(revisi.alokasiStockbit)),
            const Divider(height: FinaraSpacing.xl),
          ],
          _BarisNilai(l10n.realisasiKontribusiGabungan,
              nilaiAtauTidakTersedia(gabungan)),
          _BarisNilai(
              l10n.realisasiKontribusiBibit,
              nilaiAtauTidakTersedia(aktualBibit?.verifikasi ==
                      VerificationStatus.terverifikasi
                  ? aktualBibit?.pembelianBersih
                  : null)),
          _BarisNilai(l10n.realisasiPendanaanStockbit,
              nilaiAtauTidakTersedia(rekon?.realisasiPendanaan)),
          // Penggunaan dana — ditampilkan terpisah, tidak dijumlahkan (§113).
          _BarisNilai(l10n.realisasiPembelianStockbit,
              nilaiAtauTidakTersedia(rekon?.realisasiPembelian)),
          const SizedBox(height: FinaraSpacing.xs),
          Row(
            children: [
              Icon(Icons.flag_outlined,
                  size: 16, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: FinaraSpacing.xs),
              Text(labelStatus, style: theme.textTheme.bodySmall),
              if (rekon?.persentaseRealisasiBp != null) ...[
                const SizedBox(width: FinaraSpacing.xs),
                Text('(${formatBasisPoints(rekon!.persentaseRealisasiBp!)})',
                    style: theme.textTheme.bodySmall),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _CardDanaDarurat extends StatelessWidget {
  const _CardDanaDarurat({
    required this.target,
    required this.kontribusiBulanIni,
    required this.onAturTarget,
  });

  final EmergencyFundTarget? target;
  final int? kontribusiBulanIni;
  final VoidCallback onAturTarget;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final pokok = target?.pengeluaranPokokManual;
    final targetNominal =
        (pokok != null && target != null) ? pokok * target!.targetJumlahBulan : null;
    final saldo = target?.saldoSaatIni;
    final kekurangan = (targetNominal != null && saldo != null)
        ? (targetNominal - saldo).clamp(0, targetNominal)
        : null;
    final progres = (targetNominal != null && targetNominal > 0 && saldo != null)
        ? (saldo / targetNominal).clamp(0.0, 1.0)
        : null;

    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.progresDanaDarurat,
                  style: theme.textTheme.titleMedium),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                tooltip: l10n.aturTargetDanaDarurat,
                onPressed: onAturTarget,
              ),
            ],
          ),
          Text(l10n.descDanaDarurat,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: FinaraSpacing.sm),
          if (progres != null) ...[
            LinearProgressIndicator(
              value: progres,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: FinaraSpacing.sm),
          ],
          _BarisNilai(l10n.targetDanaDarurat,
              targetNominal == null ? l10n.tidakTersedia : formatRupiah(targetNominal)),
          _BarisNilai(l10n.saldoSaatIni,
              saldo == null ? l10n.tidakTersedia : formatRupiah(saldo)),
          _BarisNilai(l10n.kekurangan,
              kekurangan == null ? l10n.tidakTersedia : formatRupiah(kekurangan)),
          _BarisNilai(
              '${l10n.kontribusiBulanIni} — ${l10n.rencana}',
              kontribusiBulanIni == null
                  ? l10n.tidakTersedia
                  : formatRupiah(kontribusiBulanIni!)),
        ],
      ),
    );
  }
}

class _CardChecklist extends ConsumerWidget {
  const _CardChecklist({required this.revisiId});

  final int revisiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final checklist =
        ref.watch(checklistProvider(revisiId)).value ?? const [];
    final selesai = checklist.where((c) => c.selesai).length;

    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.progresChecklist, style: theme.textTheme.titleMedium),
          const SizedBox(height: FinaraSpacing.xs),
          Text(l10n.descChecklistProgres,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: FinaraSpacing.sm),
          LinearProgressIndicator(
            value: checklist.isEmpty ? 0 : selesai / checklist.length,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: FinaraSpacing.xs),
          Text(
            l10n.checklistSelesaiDari(selesai, checklist.length),
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _BarisNilai extends StatelessWidget {
  const _BarisNilai(this.label, this.nilai);

  final String label;
  final String nilai;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(label, style: theme.textTheme.bodyMedium)),
          Text(nilai, style: theme.textTheme.titleSmall),
        ],
      ),
    );
  }
}
