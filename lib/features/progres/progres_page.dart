import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/data_providers.dart';
import '../../app/providers.dart';
import '../../core/money.dart';
import '../../data/db/app_database.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/empty_state.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../l10n/app_localizations.dart';

final _targetDanaDaruratProvider =
    FutureProvider<EmergencyFundTarget?>((ref) {
  return ref.watch(emergencyFundRepositoryProvider).targetAktif();
});

/// Progres Fase 1 (§23 dasar): dana darurat + checklist bulan aktif.
class ProgresPage extends ConsumerWidget {
  const ProgresPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final revisi = ref.watch(revisiBulanAktifProvider).value;
    final target = ref.watch(_targetDanaDaruratProvider).value;

    final adaData = revisi != null || target != null;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProgres)),
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
                    _CardDanaDarurat(
                      target: target,
                      kontribusiBulanIni: revisi?.subJagoDanaDarurat,
                      onAturTarget: () => _dialogTarget(context, ref),
                    ),
                    const SizedBox(height: FinaraSpacing.md),
                    if (revisi != null) _CardChecklist(revisiId: revisi.id),
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
        ref.invalidate(_targetDanaDaruratProvider);
      }
    }
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
