import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/data_providers.dart';
import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/money.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/amount_text.dart';
import '../../design_system/widgets/empty_state.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../domain/models/allocation_input.dart';
import '../../domain/models/finance_enums.dart';
import '../../domain/services/dana_schedule_service.dart';
import '../../l10n/app_localizations.dart';
import '../hitung/hitung_controller.dart';
import 'riwayat_page.dart';

/// Detail satu revisi: ringkasan nominal + checklist transfer interaktif.
class RiwayatDetailPage extends ConsumerWidget {
  const RiwayatDetailPage({super.key, required this.revisiId});

  final int revisiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final detail = ref.watch(revisiDetailProvider(revisiId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navRiwayat),
        actions: [
          if (detail.value != null)
            _MenuAksi(detail: detail.value!, revisiId: revisiId),
        ],
      ),
      body: detail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => EmptyState(
          icon: Icons.error_outline_rounded,
          title: l10n.terjadiKesalahan,
          message: l10n.cobaLagi,
        ),
        data: (d) {
          if (d == null) {
            return EmptyState(
              icon: Icons.history_outlined,
              title: l10n.riwayatKosongJudul,
              message: l10n.riwayatKosongPesan,
            );
          }
          return _DetailBody(detail: d, revisiId: revisiId);
        },
      ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody({required this.detail, required this.revisiId});

  final RevisiDetail detail;
  final int revisiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final revisi = detail.revisi;
    final labelBulan = DateFormat('MMMM yyyy', 'id_ID')
        .format(DateTime(detail.bulan.tahun, detail.bulan.bulan));
    final checklist =
        ref.watch(checklistProvider(revisiId)).value ?? const [];
    final selesai = checklist.where((c) => c.selesai).length;

    return Center(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(labelBulan, style: theme.textTheme.titleMedium),
                      StatusChip(status: revisi.status),
                    ],
                  ),
                  Text(l10n.revisiKe(revisi.nomorRevisi),
                      style: theme.textTheme.bodySmall),
                  const Divider(height: FinaraSpacing.xl),
                  _Baris(l10n.totalPendapatan, revisi.totalPendapatan),
                  _Baris(l10n.totalPengeluaranWajib,
                      revisi.totalPengeluaranWajib),
                  _Baris(l10n.danaBersih, revisi.danaBersih),
                  _Baris(l10n.kasPeganganBrimo, revisi.kasPeganganBrimo),
                  _Baris(l10n.totalTransferAwalJago,
                      revisi.totalDanaMasukJago),
                  _Baris(l10n.totalAlokasiInvestasiRencana,
                      revisi.totalAlokasiInvestasi),
                  _Baris(l10n.bagianBibit, revisi.alokasiBibit),
                  _Baris(l10n.bagianStockbit, revisi.alokasiStockbit),
                  _Baris(l10n.totalAlokasiDanaRencana, revisi.alokasiDana),
                  if (revisi.status == RevisionStatus.draf) ...[
                    const SizedBox(height: FinaraSpacing.md),
                    FilledButton.tonalIcon(
                      onPressed: () => _konfirmasi(context, ref),
                      icon: const Icon(Icons.check_rounded),
                      label: Text(l10n.konfirmasiAlokasi),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: FinaraSpacing.lg),
            _SectionPerbandingan(detail: detail),
            const SizedBox(height: FinaraSpacing.lg),
            Text(l10n.checklistTransfer, style: theme.textTheme.titleMedium),
            Text(
              l10n.checklistSelesaiDari(selesai, checklist.length),
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: FinaraSpacing.sm),
            FinaraCard(
              padding: const EdgeInsets.symmetric(
                  vertical: FinaraSpacing.sm, horizontal: FinaraSpacing.xs),
              child: Column(
                children: [
                  for (final item in checklist)
                    CheckboxListTile(
                      value: item.selesai,
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(_labelChecklist(l10n, item.kode,
                          item.detail ?? '')),
                      subtitle: item.nominal == null
                          ? null
                          : AmountText(item.nominal!,
                              style: theme.textTheme.bodySmall),
                      onChanged: (v) async {
                        await ref
                            .read(allocationRepositoryProvider)
                            .setChecklistSelesai(item.id,
                                selesai: v ?? false);
                        ref.invalidate(checklistProvider(revisiId));
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: FinaraSpacing.lg),
            _SectionRealisasi(revisiId: revisiId, alokasiDana: revisi.alokasiDana),
            const SizedBox(height: FinaraSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Future<void> _konfirmasi(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    await ref
        .read(allocationRepositoryProvider)
        .ubahStatus(revisiId, RevisionStatus.dikonfirmasi);
    // Pengingat top-up DANA utk jadwal mendatang (§49).
    final jadwal = const DanaScheduleService().hitung(
      totalAlokasiDana: detail.revisi.alokasiDana,
      tahun: detail.bulan.tahun,
      bulan: detail.bulan.bulan,
      frekuensi: detail.revisi.frekuensiTopUpDana,
      hariTopUpMingguan: detail.revisi.hariTopUpMingguan,
    );
    await ref.read(notificationServiceProvider).jadwalkanTopUpDana(
          jadwal: jadwal.jadwalTopUp,
          judul: l10n.notifTopUpDanaJudul,
          isi: (nominal) => l10n.notifTopUpDanaIsi(formatRupiah(nominal)),
        );
    ref
      ..invalidate(revisiDetailProvider(revisiId))
      ..invalidate(daftarRiwayatProvider)
      ..invalidate(revisiBulanAktifProvider);
  }
}

class _Baris extends StatelessWidget {
  const _Baris(this.label, this.nominal);

  final String label;
  final int nominal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child:
                  Text(label, style: Theme.of(context).textTheme.bodyMedium)),
          AmountText(nominal, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}

class _MenuAksi extends ConsumerWidget {
  const _MenuAksi({required this.detail, required this.revisiId});

  final RevisiDetail detail;
  final int revisiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final draf = detail.revisi.status == RevisionStatus.draf;
    return PopupMenuButton<String>(
      onSelected: (aksi) => switch (aksi) {
        'edit' || 'duplikasi' => _keHitung(context, ref),
        _ => _konfirmasiHapus(context, ref),
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: draf ? 'edit' : 'duplikasi',
          child: Text(draf ? l10n.editDraf : l10n.duplikasiKeHitung),
        ),
        PopupMenuItem(value: 'hapus', child: Text(l10n.hapusBulanIni)),
      ],
    );
  }

  Future<void> _keHitung(BuildContext context, WidgetRef ref) async {
    final data = await ref
        .read(allocationRepositoryProvider)
        .muatUntukPrefill(revisiId);
    if (data == null || !context.mounted) return;
    final (revisi, pendapatan, wajib) = data;
    ref.read(hitungControllerProvider.notifier).prefill(
          penghasilanUtama: revisi.penghasilanUtama,
          kasPeganganBrimo: revisi.kasPeganganBrimo,
          penghasilanTambahan: [
            for (final s in pendapatan)
              IncomeSourceInput(
                nama: s.nama,
                nominal: s.nominal,
                rutin: s.rutin,
                disertakanBulanAktif: s.disertakanBulanAktif,
              ),
          ],
          pengeluaranWajib: [
            for (final e in wajib)
              MandatoryExpenseInput(
                nama: e.nama,
                nominal: e.nominal,
                kanalPembayaran: e.kanalPembayaran,
                kebutuhanPokok: e.kebutuhanPokok,
                dihitungDasarDanaDarurat: e.dihitungDasarDanaDarurat,
              ),
          ],
          namaPreset: revisi.preset,
          jagoBp: revisi.jagoBp,
          investasiBp: revisi.investasiBp,
          danaBp: revisi.danaBp,
          bibitBp: revisi.bibitBp,
          stockbitBp: revisi.stockbitBp,
          pembulatan: revisi.pembulatan,
          metodeSubJago: revisi.metodeSubJago,
          frekuensiTopUpDana: revisi.frekuensiTopUpDana,
        );
    context.go(FinaraRoutes.hitung);
  }

  Future<void> _konfirmasiHapus(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.hapusRiwayatJudul),
        content: Text(l10n.hapusRiwayatPesan),
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
        .read(allocationRepositoryProvider)
        .hapusBulan(detail.bulan.id);
    ref
      ..invalidate(daftarRiwayatProvider)
      ..invalidate(revisiBulanAktifProvider);
    if (!context.mounted) return;
    context.go(FinaraRoutes.riwayat);
  }
}

class _SectionPerbandingan extends ConsumerWidget {
  const _SectionPerbandingan({required this.detail});

  final RevisiDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final lalu = ref
        .watch(revisiBulanSebelumnyaProvider(
            (tahun: detail.bulan.tahun, bulan: detail.bulan.bulan)))
        .value;

    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.dibandingBulanLalu, style: theme.textTheme.titleSmall),
          const SizedBox(height: FinaraSpacing.sm),
          if (lalu == null)
            Text(l10n.tidakAdaBulanSebelumnya,
                style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onSurfaceVariant))
          else ...[
            _BarisDelta(l10n.totalPendapatan,
                detail.revisi.totalPendapatan - lalu.totalPendapatan),
            _BarisDelta(
                l10n.totalPengeluaranWajib,
                detail.revisi.totalPengeluaranWajib -
                    lalu.totalPengeluaranWajib),
            _BarisDelta(
                l10n.totalAlokasiInvestasiRencana,
                detail.revisi.totalAlokasiInvestasi -
                    lalu.totalAlokasiInvestasi),
            _BarisDelta(l10n.totalAlokasiDanaRencana,
                detail.revisi.alokasiDana - lalu.alokasiDana),
          ],
        ],
      ),
    );
  }
}

class _BarisDelta extends StatelessWidget {
  const _BarisDelta(this.label, this.delta);

  final String label;
  final int delta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final warna = delta > 0
        ? theme.colorScheme.primary
        : delta < 0
            ? theme.colorScheme.error
            : theme.colorScheme.onSurfaceVariant;
    final tanda = delta > 0 ? '+' : '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child:
                  Text(label, style: theme.textTheme.bodyMedium)),
          Text('$tanda${formatRupiah(delta)}',
              style: theme.textTheme.titleSmall!.copyWith(color: warna)),
        ],
      ),
    );
  }
}

class _SectionRealisasi extends ConsumerWidget {
  const _SectionRealisasi({required this.revisiId, required this.alokasiDana});

  final int revisiId;
  final int alokasiDana;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final realisasi =
        ref.watch(realisasiPerRevisiProvider(revisiId)).value ?? const [];
    final sisaDana = ref
        .watch(sisaAnggaranDanaProvider(
            (revisiId: revisiId, alokasiDana: alokasiDana)))
        .value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(l10n.realisasiPengeluaran,
                  style: theme.textTheme.titleMedium),
            ),
            TextButton.icon(
              onPressed: () => _dialogCatat(context, ref),
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.catatPengeluaran),
            ),
          ],
        ),
        const SizedBox(height: FinaraSpacing.sm),
        FinaraCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.sisaAnggaranDana,
                      style: theme.textTheme.bodyMedium),
                  Text(
                    sisaDana == null
                        ? l10n.tidakTersedia
                        : formatRupiah(sisaDana),
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              if (realisasi.isNotEmpty) ...[
                const Divider(height: FinaraSpacing.xl),
                for (final r in realisasi)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                        DateFormat('d MMM yyyy', 'id_ID')
                            .format(r.transactionDate),
                        style: theme.textTheme.bodyMedium),
                    subtitle: Text(_labelSumber(l10n, r.fundingSource)),
                    trailing: AmountText(r.amount,
                        style: theme.textTheme.titleSmall),
                  ),
              ] else ...[
                const SizedBox(height: FinaraSpacing.sm),
                Text(l10n.belumAdaRealisasi,
                    style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.onSurfaceVariant)),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _dialogCatat(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final nominalCtrl = TextEditingController();
    final catatanCtrl = TextEditingController();
    var sumber = BudgetSource.alokasiDana;
    var kanal = PaymentChannel.dana;
    var tanggal = DateTime.now();

    final simpan = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.catatPengeluaran),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nominalCtrl,
                  decoration: InputDecoration(
                      labelText: l10n.nominal, prefixText: 'Rp'),
                  keyboardType: TextInputType.number,
                  inputFormatters: const [RupiahInputFormatter()],
                ),
                const SizedBox(height: FinaraSpacing.md),
                DropdownButtonFormField<BudgetSource>(
                  initialValue: sumber,
                  decoration:
                      InputDecoration(labelText: l10n.sumberAnggaran),
                  items: [
                    for (final s in BudgetSource.values)
                      DropdownMenuItem(
                          value: s, child: Text(_labelSumber(l10n, s))),
                  ],
                  onChanged: (v) =>
                      setState(() => sumber = v ?? BudgetSource.alokasiDana),
                ),
                const SizedBox(height: FinaraSpacing.md),
                DropdownButtonFormField<PaymentChannel>(
                  initialValue: kanal,
                  decoration:
                      InputDecoration(labelText: l10n.kanalPembayaran),
                  items: [
                    DropdownMenuItem(
                        value: PaymentChannel.bankJago,
                        child: Text(l10n.kanalBankJago)),
                    DropdownMenuItem(
                        value: PaymentChannel.dana,
                        child: Text(l10n.kanalDana)),
                    DropdownMenuItem(
                        value: PaymentChannel.tunai,
                        child: Text(l10n.kanalTunai)),
                    DropdownMenuItem(
                        value: PaymentChannel.transferBankLain,
                        child: Text(l10n.kanalBankLain)),
                    DropdownMenuItem(
                        value: PaymentChannel.lainnya,
                        child: Text(l10n.kanalLainnya)),
                  ],
                  onChanged: (v) =>
                      setState(() => kanal = v ?? PaymentChannel.dana),
                ),
                const SizedBox(height: FinaraSpacing.md),
                OutlinedButton.icon(
                  icon: const Icon(Icons.calendar_today_outlined, size: 18),
                  label: Text(
                      DateFormat('d MMM yyyy', 'id_ID').format(tanggal)),
                  onPressed: () async {
                    final pilih = await showDatePicker(
                      context: context,
                      initialDate: tanggal,
                      firstDate: DateTime(tanggal.year - 1),
                      lastDate: DateTime(tanggal.year + 1),
                    );
                    if (pilih != null) setState(() => tanggal = pilih);
                  },
                ),
                const SizedBox(height: FinaraSpacing.md),
                TextField(
                  controller: catatanCtrl,
                  decoration:
                      InputDecoration(labelText: l10n.catatanOpsional),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
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
      ),
    );

    if (simpan == true) {
      final nominal = parseRupiah(nominalCtrl.text) ?? 0;
      if (nominal > 0) {
        await ref.read(expenseRealizationRepositoryProvider).catat(
              tanggal: tanggal,
              nominal: nominal,
              sumberAnggaran: sumber,
              kanalPembayaran: kanal,
              revisiId: revisiId,
              catatan: catatanCtrl.text.trim().isEmpty
                  ? null
                  : catatanCtrl.text.trim(),
            );
        ref.invalidate(realisasiPerRevisiProvider(revisiId));
      }
    }
  }
}

String _labelSumber(AppLocalizations l10n, BudgetSource sumber) {
  return switch (sumber) {
    BudgetSource.kantongPengeluaranWajib => l10n.sumberKantongWajib,
    BudgetSource.kantongLanggananJago => l10n.sumberKantongLangganan,
    BudgetSource.alokasiJago => l10n.sumberAlokasiJago,
    BudgetSource.alokasiDana => l10n.sumberAlokasiDana,
  };
}

String _labelChecklist(AppLocalizations l10n, String kode, String detail) {
  return switch (kode) {
    'sisakanKasPegangan' => l10n.ckSisakanKasPegangan,
    'transferDanaMasukJago' => l10n.ckTransferDanaMasukJago,
    'pisahkanKantongWajib' => l10n.ckPisahkanKantongWajib,
    'pisahkanAlokasiJago' => l10n.ckPisahkanAlokasiJago,
    'isiKantongLangganan' => l10n.ckIsiKantongLangganan,
    'isiKantongDanaDarurat' => l10n.ckIsiKantongDanaDarurat,
    'isiKantongOperasional' => l10n.ckIsiKantongOperasional,
    'topUpBibit' => l10n.ckTopUpBibit,
    'transferRdnStockbit' => l10n.ckTransferRdnStockbit,
    'verifikasiRdnCatatTerpisah' => l10n.ckVerifikasiRdnCatatTerpisah,
    'topUpDana' => l10n.ckTopUpDana,
    'pindahkanWajibKeDana' => l10n.ckPindahkanWajibKeDana(detail),
    'tarikWajibTunai' => l10n.ckTarikWajibTunai(detail),
    'pindahkanWajibKeBankLain' => l10n.ckPindahkanWajibKeBankLain(detail),
    'periksaSatuSumberAnggaran' => l10n.ckPeriksaSatuSumberAnggaran,
    'periksaPemindahanBukanPengeluaran' =>
      l10n.ckPeriksaPemindahanBukanPengeluaran,
    _ => kode,
  };
}
