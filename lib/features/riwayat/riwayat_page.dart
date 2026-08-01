import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/data_providers.dart';
import '../../app/router.dart';
import '../../data/services/export_service.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/amount_text.dart';
import '../../design_system/widgets/empty_state.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../domain/models/finance_enums.dart';
import '../../l10n/app_localizations.dart';

/// Riwayat alokasi berversi (§22): daftar bulan + revisi terbaru.
class RiwayatPage extends ConsumerStatefulWidget {
  const RiwayatPage({super.key});

  @override
  ConsumerState<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends ConsumerState<RiwayatPage> {
  int? _filterTahun;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final riwayat = ref.watch(daftarRiwayatProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navRiwayat),
        actions: [
          IconButton(
            icon: const Icon(Icons.table_view_outlined),
            tooltip: l10n.eksporCsv,
            onPressed: () => _eksporCsv(context),
          ),
        ],
      ),
      body: riwayat.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => EmptyState(
          icon: Icons.error_outline_rounded,
          title: l10n.terjadiKesalahan,
          message: l10n.cobaLagi,
          actionLabel: l10n.cobaLagi,
          onAction: () => ref.invalidate(daftarRiwayatProvider),
        ),
        data: (entries) {
          if (entries.isEmpty) {
            return EmptyState(
              icon: Icons.history_outlined,
              title: l10n.riwayatKosongJudul,
              message: l10n.riwayatKosongPesan,
            );
          }
          final tahunTersedia =
              entries.map((e) => e.bulan.tahun).toSet().toList()..sort();
          final tersaring = _filterTahun == null
              ? entries
              : entries
                  .where((e) => e.bulan.tahun == _filterTahun)
                  .toList();
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxWidth: FinaraSpacing.maxContentWidth),
              child: Column(
                children: [
                  if (tahunTersedia.length > 1)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(FinaraSpacing.lg,
                          FinaraSpacing.md, FinaraSpacing.lg, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int?>(
                              initialValue: _filterTahun,
                              decoration: InputDecoration(
                                  labelText: l10n.filterTahun,
                                  isDense: true),
                              items: [
                                DropdownMenuItem(
                                    value: null,
                                    child: Text(l10n.semuaTahun)),
                                for (final t in tahunTersedia)
                                  DropdownMenuItem(
                                      value: t, child: Text('$t')),
                              ],
                              onChanged: (v) =>
                                  setState(() => _filterTahun = v),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(FinaraSpacing.lg),
                      itemCount: tersaring.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: FinaraSpacing.md),
                      itemBuilder: (context, i) =>
                          _RiwayatTile(entry: tersaring[i]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Future<void> _eksporCsv(BuildContext context) async {
    final entries = ref.read(daftarRiwayatProvider).value ?? const [];
    if (entries.isEmpty) return;
    const service = ExportService();
    final csv = service.buatCsv(
        [for (final e in entries) (e.bulan, e.revisi)]);
    try {
      final path = await service.simpanSementara(
          'finara-riwayat.csv', utf8.encode(csv));
      await SharePlus.instance.share(ShareParams(files: [XFile(path)]));
    } catch (_) {
      // Plugin share tidak tersedia (mis. test) — abaikan.
    }
  }
}

class _RiwayatTile extends StatelessWidget {
  const _RiwayatTile({required this.entry});

  final RiwayatEntry entry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final e = entry;
    final label = DateFormat('MMMM yyyy', 'id_ID')
        .format(DateTime(e.bulan.tahun, e.bulan.bulan));
    return FinaraCard(
      onTap: () => context.go('${FinaraRoutes.riwayat}/${e.revisi.id}'),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
            child: Text(
              DateFormat('MMM', 'id_ID')
                  .format(DateTime(e.bulan.tahun, e.bulan.bulan)),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: FinaraSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: FinaraSpacing.xs),
                Row(
                  children: [
                    StatusChip(status: e.revisi.status),
                    const SizedBox(width: FinaraSpacing.sm),
                    Text(
                      l10n.revisiKe(e.revisi.nomorRevisi),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(l10n.totalPendapatan,
                  style: Theme.of(context).textTheme.bodySmall),
              AmountText(e.revisi.totalPendapatan,
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final RevisionStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final (label, warna) = switch (status) {
      RevisionStatus.draf => (l10n.statusDraf, scheme.tertiary),
      RevisionStatus.dikonfirmasi => (l10n.statusDikonfirmasi, scheme.primary),
      RevisionStatus.dikunci => (l10n.statusDikunci, scheme.outline),
      RevisionStatus.direvisi => (l10n.statusDirevisi, scheme.outline),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: FinaraSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(FinaraRadius.sm),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: warna, fontWeight: FontWeight.w600),
      ),
    );
  }
}
