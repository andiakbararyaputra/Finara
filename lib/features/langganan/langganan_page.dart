import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/data_providers.dart';
import '../../app/providers.dart';
import '../../core/money.dart';
import '../../data/db/app_database.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/amount_text.dart';
import '../../design_system/widgets/empty_state.dart';
import '../../domain/models/allocation_input.dart';
import '../../l10n/app_localizations.dart';

/// Kelola langganan digital (§15): satu sumber anggaran aktif per langganan.
class LanggananPage extends ConsumerWidget {
  const LanggananPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final daftar = ref.watch(daftarLanggananProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.kelolaLangganan)),
      floatingActionButton: FloatingActionButton(
        tooltip: l10n.tambahLangganan,
        onPressed: () => _dialogLangganan(context, ref),
        child: const Icon(Icons.add_rounded),
      ),
      body: daftar.isEmpty
          ? EmptyState(
              icon: Icons.subscriptions_outlined,
              title: l10n.langgananKosong,
              message: l10n.tambahLangganan,
            )
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: FinaraSpacing.maxContentWidth),
                child: ListView.builder(
                  padding: const EdgeInsets.all(FinaraSpacing.lg),
                  itemCount: daftar.length,
                  itemBuilder: (context, i) {
                    final s = daftar[i];
                    return ListTile(
                      title: Text(s.nama),
                      subtitle: Text(
                        '${s.siklus == SubscriptionCycle.bulanan ? l10n.siklusBulanan : l10n.siklusTahunan}'
                        ' · ${s.sumberAnggaran == SubscriptionFundingSource.kantongPengeluaranWajib ? l10n.sumberKantongWajib : l10n.sumberKantongLangganan}'
                        '${s.aktif ? '' : ' · ${l10n.belumTersedia}'}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AmountText(s.nominal,
                              style:
                                  Theme.of(context).textTheme.titleMedium),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded),
                            tooltip: l10n.hapus,
                            onPressed: () async {
                              await ref
                                  .read(subscriptionRepositoryProvider)
                                  .hapus(s.id);
                              ref.invalidate(daftarLanggananProvider);
                            },
                          ),
                        ],
                      ),
                      onTap: () => _dialogLangganan(context, ref, ada: s),
                    );
                  },
                ),
              ),
            ),
    );
  }

  Future<void> _dialogLangganan(
    BuildContext context,
    WidgetRef ref, {
    Subscription? ada,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final namaCtrl = TextEditingController(text: ada?.nama ?? '');
    final nominalCtrl = TextEditingController(
        text: ada == null ? '' : formatRupiah(ada.nominal).substring(2));
    final bulanCtrl =
        TextEditingController(text: '${ada?.bulanTagihan ?? 1}');
    var siklus = ada?.siklus ?? SubscriptionCycle.bulanan;
    var metode = ada?.metodeTahunan ?? AnnualFundingMethod.cadanganBulanan;
    var sumber =
        ada?.sumberAnggaran ?? SubscriptionFundingSource.kantongLanggananJago;
    var aktif = ada?.aktif ?? true;

    final simpan = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(ada == null ? l10n.tambahLangganan : l10n.kelolaLangganan),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaCtrl,
                  decoration: InputDecoration(labelText: l10n.namaItem),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: FinaraSpacing.md),
                TextField(
                  controller: nominalCtrl,
                  decoration: InputDecoration(
                      labelText: l10n.nominal, prefixText: 'Rp'),
                  keyboardType: TextInputType.number,
                  inputFormatters: const [RupiahInputFormatter()],
                ),
                const SizedBox(height: FinaraSpacing.md),
                DropdownButtonFormField<SubscriptionCycle>(
                  initialValue: siklus,
                  decoration: InputDecoration(labelText: l10n.siklus),
                  items: [
                    DropdownMenuItem(
                        value: SubscriptionCycle.bulanan,
                        child: Text(l10n.siklusBulanan)),
                    DropdownMenuItem(
                        value: SubscriptionCycle.tahunan,
                        child: Text(l10n.siklusTahunan)),
                  ],
                  onChanged: (v) => setState(
                      () => siklus = v ?? SubscriptionCycle.bulanan),
                ),
                if (siklus == SubscriptionCycle.tahunan) ...[
                  const SizedBox(height: FinaraSpacing.md),
                  TextField(
                    controller: bulanCtrl,
                    decoration:
                        InputDecoration(labelText: l10n.bulanTagihan),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: FinaraSpacing.md),
                  DropdownButtonFormField<AnnualFundingMethod>(
                    initialValue: metode,
                    decoration:
                        InputDecoration(labelText: l10n.metodeTahunan),
                    items: [
                      DropdownMenuItem(
                          value: AnnualFundingMethod.cadanganBulanan,
                          child: Text(l10n.metodeCadanganBulanan)),
                      DropdownMenuItem(
                          value: AnnualFundingMethod.bayarSaatJatuhTempo,
                          child: Text(l10n.metodeBayarJatuhTempo)),
                    ],
                    onChanged: (v) => setState(() =>
                        metode = v ?? AnnualFundingMethod.cadanganBulanan),
                  ),
                ],
                const SizedBox(height: FinaraSpacing.md),
                DropdownButtonFormField<SubscriptionFundingSource>(
                  initialValue: sumber,
                  decoration:
                      InputDecoration(labelText: l10n.sumberAnggaran),
                  items: [
                    DropdownMenuItem(
                        value:
                            SubscriptionFundingSource.kantongLanggananJago,
                        child: Text(l10n.sumberKantongLangganan)),
                    DropdownMenuItem(
                        value: SubscriptionFundingSource
                            .kantongPengeluaranWajib,
                        child: Text(l10n.sumberKantongWajib)),
                  ],
                  onChanged: (v) => setState(() => sumber =
                      v ?? SubscriptionFundingSource.kantongLanggananJago),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.statusAktif),
                  value: aktif,
                  onChanged: (v) => setState(() => aktif = v),
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
      final bulanTagihan = (int.tryParse(bulanCtrl.text) ?? 1).clamp(1, 12);
      if (namaCtrl.text.trim().isNotEmpty && nominal > 0) {
        final repo = ref.read(subscriptionRepositoryProvider);
        if (ada == null) {
          await repo.tambah(
            nama: namaCtrl.text.trim(),
            siklus: siklus,
            nominal: nominal,
            bulanTagihan: bulanTagihan,
            metodeTahunan: metode,
            sumberAnggaran: sumber,
            aktif: aktif,
          );
        } else {
          await repo.perbarui(
            ada.id,
            SubscriptionsCompanion.insert(
              nama: namaCtrl.text.trim(),
              siklus: siklus,
              nominal: nominal,
              bulanTagihan: bulanTagihan,
              metodeTahunan: metode,
              sumberAnggaran: sumber,
              saldoCadangan: ada.saldoCadangan,
              aktif: aktif,
              pengingatAktif: ada.pengingatAktif,
            ),
          );
        }
        ref.invalidate(daftarLanggananProvider);
      }
    }
  }
}
