import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/data_providers.dart';
import '../../app/router.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/amount_text.dart';
import '../../design_system/widgets/empty_state.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../l10n/app_localizations.dart';

/// Beranda: maksimal 4 informasi utama (§9) dari revisi aktif bulan ini.
class BerandaPage extends ConsumerWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final bulanAktif = DateFormat('MMMM yyyy', 'id_ID').format(DateTime.now());
    final revisi = ref.watch(revisiBulanAktifProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.appName),
            Text(
              bulanAktif,
              style: theme.textTheme.bodySmall!.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.pengaturan,
            onPressed: () => context.push(FinaraRoutes.pengaturan),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
          child: revisi.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => EmptyState(
              icon: Icons.error_outline_rounded,
              title: l10n.terjadiKesalahan,
              message: l10n.cobaLagi,
              actionLabel: l10n.cobaLagi,
              onAction: () => ref.invalidate(revisiBulanAktifProvider),
            ),
            data: (r) {
              if (r == null) {
                return EmptyState(
                  icon: Icons.account_balance_wallet_outlined,
                  title: l10n.berandaKosongJudul,
                  message: l10n.berandaKosongPesan,
                  actionLabel: l10n.hitungAlokasi,
                  onAction: () => context.go(FinaraRoutes.hitung),
                );
              }
              return _BerandaIsi(revisiId: r.id);
            },
          ),
        ),
      ),
    );
  }
}

class _BerandaIsi extends ConsumerWidget {
  const _BerandaIsi({required this.revisiId});

  final int revisiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final revisi = ref.watch(revisiBulanAktifProvider).value;
    if (revisi == null) return const SizedBox.shrink();
    final checklist =
        ref.watch(checklistProvider(revisiId)).value ?? const [];
    final selesai = checklist.where((c) => c.selesai).length;

    return ListView(
      padding: const EdgeInsets.all(FinaraSpacing.lg),
      children: [
        FinaraCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.totalPendapatan,
                  style: theme.textTheme.bodyMedium),
              AmountText(revisi.totalPendapatan,
                  style: theme.textTheme.headlineMedium),
            ],
          ),
        ),
        const SizedBox(height: FinaraSpacing.md),
        Row(
          children: [
            Expanded(
              child: FinaraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.totalPengeluaranWajib,
                        style: theme.textTheme.bodySmall),
                    AmountText(revisi.totalPengeluaranWajib,
                        style: theme.textTheme.titleLarge),
                  ],
                ),
              ),
            ),
            const SizedBox(width: FinaraSpacing.md),
            Expanded(
              child: FinaraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${l10n.kartuInvestasi} — ${l10n.rencana}',
                        style: theme.textTheme.bodySmall),
                    AmountText(revisi.totalAlokasiInvestasi,
                        style: theme.textTheme.titleLarge),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: FinaraSpacing.md),
        FinaraCard(
          onTap: () => context.go('${FinaraRoutes.riwayat}/$revisiId'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.progresChecklist, style: theme.textTheme.bodyMedium),
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
        ),
        const SizedBox(height: FinaraSpacing.xl),
        FilledButton.icon(
          onPressed: () => context.go(FinaraRoutes.hitung),
          icon: const Icon(Icons.calculate_outlined),
          label: Text(l10n.hitungAlokasi),
        ),
      ],
    );
  }
}
