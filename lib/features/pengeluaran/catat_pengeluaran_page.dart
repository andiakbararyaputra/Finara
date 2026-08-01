import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/data_providers.dart';
import '../../app/providers.dart';
import '../../core/money.dart';
import '../../design_system/tokens/finara_colors.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/amount_text.dart';
import '../../design_system/widgets/empty_state.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../domain/models/allocation_input.dart';
import '../../domain/models/finance_enums.dart';
import '../../l10n/app_localizations.dart';

/// Halaman pencatatan pengeluaran bulan berjalan. Entri otomatis terhubung
/// ke revisi aktif (bila ada) sehingga sisa anggaran DANA ikut terhitung.
class CatatPengeluaranPage extends ConsumerWidget {
  const CatatPengeluaranPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final bulanAktif = DateFormat('MMMM yyyy', 'id_ID').format(DateTime.now());
    final realisasi = ref.watch(realisasiBulanIniProvider).value ?? const [];
    final revisi = ref.watch(revisiBulanAktifProvider).value;
    final total = realisasi.fold<int>(0, (a, r) => a + r.amount);
    final sisaDana = revisi == null
        ? null
        : ref
            .watch(sisaAnggaranDanaProvider(
                (revisiId: revisi.id, alokasiDana: revisi.alokasiDana)))
            .value;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.catatPengeluaran)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _dialogCatat(context, ref, revisi?.id),
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.catatPengeluaran),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(FinaraSpacing.lg,
                FinaraSpacing.lg, FinaraSpacing.lg, 96),
            children: [
              Text(l10n.catatPengeluaranDesc,
                  style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: FinaraSpacing.md),
              FinaraCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('${l10n.totalTercatat} — $bulanAktif',
                              style: theme.textTheme.bodyMedium),
                        ),
                        AmountText(total,
                            style: theme.textTheme.titleMedium),
                      ],
                    ),
                    const SizedBox(height: FinaraSpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l10n.sisaAnggaranDana,
                            style: theme.textTheme.bodyMedium),
                        Text(
                          sisaDana == null
                              ? l10n.tidakTersedia
                              : formatRupiah(sisaDana),
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: (sisaDana != null && sisaDana < 0)
                                ? theme.colorScheme.error
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: FinaraSpacing.lg),
              if (realisasi.isEmpty)
                EmptyState(
                  icon: Icons.receipt_long_outlined,
                  title: l10n.belumAdaRealisasi,
                  message: l10n.catatPengeluaranDesc,
                )
              else
                for (final r in realisasi)
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: FinaraSpacing.sm),
                    child: FinaraCard(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor:
                                FinaraColors.dana.withValues(alpha: 0.14),
                            child: const Icon(Icons.payments_outlined,
                                size: 18, color: FinaraColors.dana),
                          ),
                          const SizedBox(width: FinaraSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r.userNotes?.isNotEmpty == true
                                      ? r.userNotes!
                                      : labelSumberAnggaran(
                                          l10n, r.fundingSource),
                                  style: theme.textTheme.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${DateFormat('d MMM yyyy', 'id_ID').format(r.transactionDate)} · ${labelSumberAnggaran(l10n, r.fundingSource)}',
                                  style: theme.textTheme.bodySmall!.copyWith(
                                      color: theme
                                          .colorScheme.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),
                          AmountText(r.amount,
                              style: theme.textTheme.titleSmall),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded,
                                size: 20),
                            tooltip: l10n.hapus,
                            onPressed: () =>
                                _hapus(context, ref, r.id, revisi?.id),
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _hapus(
      BuildContext context, WidgetRef ref, int id, int? revisiId) async {
    final l10n = AppLocalizations.of(context)!;
    final yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.hapus),
        content: Text(l10n.hapusPengeluaranTanya),
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
    if (yakin == true) {
      await ref.read(expenseRealizationRepositoryProvider).hapus(id);
      _segarkan(ref, revisiId: revisiId);
    }
  }

  Future<void> _dialogCatat(
      BuildContext context, WidgetRef ref, int? revisiId) async {
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
                          value: s,
                          child: Text(labelSumberAnggaran(l10n, s))),
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
        _segarkan(ref, revisiId: revisiId);
      }
    }
  }

  void _segarkan(WidgetRef ref, {int? revisiId}) {
    ref.invalidate(realisasiBulanIniProvider);
    if (revisiId != null) {
      ref.invalidate(realisasiPerRevisiProvider(revisiId));
    }
    ref.invalidate(skorKesehatanProvider);
  }
}

/// Label sumber anggaran untuk dropdown & daftar realisasi.
String labelSumberAnggaran(AppLocalizations l10n, BudgetSource sumber) {
  return switch (sumber) {
    BudgetSource.kantongPengeluaranWajib => l10n.sumberKantongWajib,
    BudgetSource.kantongLanggananJago => l10n.sumberKantongLangganan,
    BudgetSource.alokasiJago => l10n.sumberAlokasiJago,
    BudgetSource.alokasiDana => l10n.sumberAlokasiDana,
  };
}
