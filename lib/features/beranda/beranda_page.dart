import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/data_providers.dart';
import '../../app/router.dart';
import '../../design_system/tokens/finara_colors.dart';
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
        // Hero pendapatan: satu-satunya blok bergradien di halaman (§4).
        Container(
          padding: const EdgeInsets.all(FinaraSpacing.xl),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [FinaraColors.emerald, FinaraColors.emeraldDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(FinaraRadius.lg),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${l10n.totalPendapatan} — ${l10n.rencana}',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: FinaraSpacing.xs),
                    AmountText(
                      revisi.totalPendapatan,
                      style: theme.textTheme.headlineMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.account_balance_wallet_rounded,
                  size: 44, color: Colors.white38),
            ],
          ),
        ),
        const SizedBox(height: FinaraSpacing.md),
        Row(
          children: [
            Expanded(
              child: _InfoMini(
                ikon: Icons.receipt_long_outlined,
                warna: FinaraColors.bankJago,
                label: l10n.totalPengeluaranWajib,
                nominal: revisi.totalPengeluaranWajib,
              ),
            ),
            const SizedBox(width: FinaraSpacing.md),
            Expanded(
              child: _InfoMini(
                ikon: Icons.trending_up_rounded,
                warna: FinaraColors.stockbit,
                label: '${l10n.kartuInvestasi} — ${l10n.rencana}',
                nominal: revisi.totalAlokasiInvestasi,
              ),
            ),
          ],
        ),
        const SizedBox(height: FinaraSpacing.md),
        const _CardPengeluaranBulanIni(),
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

class _CardPengeluaranBulanIni extends ConsumerWidget {
  const _CardPengeluaranBulanIni();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final realisasi = ref.watch(realisasiBulanIniProvider).value ?? const [];
    final total = realisasi.fold<int>(0, (a, r) => a + r.amount);
    final terbaru = realisasi.take(3).toList();

    return FinaraCard(
      onTap: () => context.push(FinaraRoutes.catatPengeluaran),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: FinaraColors.dana.withValues(alpha: 0.14),
                child: const Icon(Icons.payments_outlined,
                    size: 16, color: FinaraColors.dana),
              ),
              const SizedBox(width: FinaraSpacing.sm),
              Expanded(
                child: Text(l10n.pengeluaranBulanIni,
                    style: theme.textTheme.bodyMedium),
              ),
              AmountText(total, style: theme.textTheme.titleMedium),
            ],
          ),
          if (terbaru.isNotEmpty) ...[
            const SizedBox(height: FinaraSpacing.sm),
            for (final r in terbaru)
              Padding(
                padding: const EdgeInsets.only(top: FinaraSpacing.xs),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${DateFormat('d MMM', 'id_ID').format(r.transactionDate)}'
                        '${r.userNotes?.isNotEmpty == true ? ' · ${r.userNotes}' : ''}',
                        style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AmountText(r.amount, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
          ] else ...[
            const SizedBox(height: FinaraSpacing.xs),
            Text(l10n.belumAdaRealisasi,
                style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onSurfaceVariant)),
          ],
          const SizedBox(height: FinaraSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => context.push(FinaraRoutes.catatPengeluaran),
              icon: const Icon(Icons.add_rounded, size: 18),
              label: Text(l10n.catatPengeluaran),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoMini extends StatelessWidget {
  const _InfoMini({
    required this.ikon,
    required this.warna,
    required this.label,
    required this.nominal,
  });

  final IconData ikon;
  final Color warna;
  final String label;
  final int nominal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: warna.withValues(alpha: 0.14),
            child: Icon(ikon, size: 16, color: warna),
          ),
          const SizedBox(height: FinaraSpacing.sm),
          Text(label,
              style: theme.textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          AmountText(nominal, style: theme.textTheme.titleLarge),
        ],
      ),
    );
  }
}
