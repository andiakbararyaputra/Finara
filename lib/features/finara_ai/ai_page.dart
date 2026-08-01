import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../data/db/app_database.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/empty_state.dart';
import '../../l10n/app_localizations.dart';
import 'ai_providers.dart';

/// Tab Finara AI (§26): daftar percakapan atau ajakan konfigurasi.
class AiPage extends ConsumerWidget {
  const AiPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final providers =
        ref.watch(daftarProviderAiProvider).value ?? const [];
    final percakapan = ref.watch(daftarPercakapanProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navFinaraAi),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            tooltip: l10n.penyediaDanModel,
            onPressed: () => context.push(FinaraRoutes.aiPengaturan),
          ),
        ],
      ),
      floatingActionButton: providers.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _pilihProviderLaluBuat(context, ref, providers),
              icon: const Icon(Icons.add_comment_outlined),
              label: Text(l10n.percakapanBaru),
            ),
      body: providers.isEmpty
          ? EmptyState(
              icon: Icons.smart_toy_outlined,
              title: l10n.aiBelumDikonfigurasi,
              message: l10n.aiBelumDikonfigurasiPesan,
              actionLabel: l10n.penyediaDanModel,
              onAction: () => context.push(FinaraRoutes.aiPengaturan),
            )
          : percakapan.isEmpty
              ? EmptyState(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: l10n.belumAdaPercakapan,
                  message: l10n.disclaimerAi,
                )
              : Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        maxWidth: FinaraSpacing.maxContentWidth),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(FinaraSpacing.lg),
                      itemCount: percakapan.length,
                      itemBuilder: (context, i) {
                        final c = percakapan[i];
                        return ListTile(
                          leading:
                              const Icon(Icons.chat_bubble_outline_rounded),
                          title: Text(c.judul,
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          subtitle: Text(
                            '${c.modelId} · ${DateFormat('d MMM yyyy', 'id_ID').format(c.diperbaruiPada)}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline_rounded),
                            tooltip: l10n.hapusPercakapan,
                            onPressed: () async {
                              await ref
                                  .read(chatRepositoryProvider)
                                  .hapusPercakapan(c.id);
                              ref.invalidate(daftarPercakapanProvider);
                            },
                          ),
                          onTap: () => context
                              .push('${FinaraRoutes.aiChat}/${c.id}'),
                        );
                      },
                    ),
                  ),
                ),
    );
  }

  /// Multi-provider (§38): satu provider langsung; lebih dari satu → pilih.
  Future<void> _pilihProviderLaluBuat(
    BuildContext context,
    WidgetRef ref,
    List<AiProviderConfiguration> providers,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    var terpilih = providers.first;
    if (providers.length > 1) {
      final hasil = await showModalBottomSheet<AiProviderConfiguration>(
        context: context,
        builder: (sheetContext) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(l10n.pilihProvider,
                    style: Theme.of(sheetContext).textTheme.titleMedium),
              ),
              for (final p in providers)
                ListTile(
                  leading: const Icon(Icons.cloud_outlined),
                  title: Text(p.nama),
                  subtitle: Text(p.modelDefault ?? p.baseUrl),
                  onTap: () => Navigator.pop(sheetContext, p),
                ),
            ],
          ),
        ),
      );
      if (hasil == null) return;
      terpilih = hasil;
    }
    if (!context.mounted) return;
    await _percakapanBaru(context, ref, terpilih.id, terpilih.modelDefault);
  }

  Future<void> _percakapanBaru(
    BuildContext context,
    WidgetRef ref,
    int providerId,
    String? modelDefault,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    if (modelDefault == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errModelTidakTersedia)));
      return;
    }
    final id = await ref.read(chatRepositoryProvider).buatPercakapan(
          judul: l10n.percakapanBaru,
          providerId: providerId,
          modelId: modelDefault,
        );
    ref.invalidate(daftarPercakapanProvider);
    if (!context.mounted) return;
    await context.push('${FinaraRoutes.aiChat}/$id');
  }
}
