import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../data/repositories/settings_repository.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/empty_state.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../l10n/app_localizations.dart';
import 'ai_providers.dart';

/// Pengaturan Finara AI (§27, §38): daftar multi-provider + retensi chat.
class AiConfigPage extends ConsumerWidget {
  const AiConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final providers = ref.watch(daftarProviderAiProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.penyediaDanModel)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _dialogTambah(context, ref),
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.tambahProvider),
      ),
      body: providers.isEmpty
          ? EmptyState(
              icon: Icons.smart_toy_outlined,
              title: l10n.aiBelumDikonfigurasi,
              message: l10n.aiBelumDikonfigurasiPesan,
            )
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: FinaraSpacing.maxContentWidth),
                child: ListView(
                  padding: const EdgeInsets.all(FinaraSpacing.lg),
                  children: [
                    for (final p in providers) ...[
                      FinaraCard(
                        onTap: () => context
                            .push('${FinaraRoutes.aiProvider}/${p.id}'),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.nama,
                                style: theme.textTheme.titleMedium),
                            Text(p.baseUrl,
                                style: theme.textTheme.bodySmall),
                            if (p.modelDefault != null)
                              Text(
                                '${l10n.modelDefault}: ${p.modelDefault}',
                                style: theme.textTheme.bodySmall!.copyWith(
                                    color:
                                        theme.colorScheme.onSurfaceVariant),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: FinaraSpacing.md),
                    ],
                    const Divider(height: FinaraSpacing.xl),
                    const _PengaturanRetensi(),
                    const SizedBox(height: 80), // ruang utk FAB
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _dialogTambah(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final namaCtrl = TextEditingController();
    final urlCtrl = TextEditingController();
    final apiKeyCtrl = TextEditingController();

    final simpan = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.tambahProvider),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaCtrl,
                decoration:
                    InputDecoration(labelText: l10n.namaKonfigurasi),
              ),
              const SizedBox(height: FinaraSpacing.md),
              TextField(
                controller: urlCtrl,
                decoration: InputDecoration(
                  labelText: l10n.baseUrl,
                  hintText: 'https://api.openai.com/v1',
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: FinaraSpacing.md),
              TextField(
                controller: apiKeyCtrl,
                decoration: InputDecoration(labelText: l10n.apiKey),
                obscureText: true,
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
    );

    if (simpan == true) {
      final nama = namaCtrl.text.trim();
      final url = urlCtrl.text.trim().replaceAll(RegExp(r'/+$'), '');
      final apiKey = apiKeyCtrl.text.trim();
      final uri = Uri.tryParse(url);
      // Base URL wajib https (§53); http hanya utk server lokal.
      final urlValid = uri != null &&
          (uri.scheme == 'https' ||
              (uri.scheme == 'http' &&
                  (uri.host == 'localhost' || uri.host == '127.0.0.1')));
      if (nama.isEmpty || !urlValid || apiKey.isEmpty) return;
      final id = await ref
          .read(aiProviderRepositoryProvider)
          .tambahProvider(nama: nama, baseUrl: url);
      await ref.read(apiKeyStoreProvider).simpan(id, apiKey);
      ref.invalidate(daftarProviderAiProvider);
    }
  }
}

class _PengaturanRetensi extends ConsumerWidget {
  const _PengaturanRetensi();

  static final _retensiProvider = FutureProvider<int>((ref) async {
    final nilai = await ref
        .watch(settingsRepositoryProvider)
        .baca(SettingKeys.retensiChatHari);
    return int.tryParse(nilai ?? '0') ?? 0;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final retensi = ref.watch(_retensiProvider).value ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<int>(
          initialValue: retensi,
          isExpanded: true,
          decoration: InputDecoration(labelText: l10n.retensiChat),
          items: [
            DropdownMenuItem(value: 0, child: Text(l10n.retensiSelamanya)),
            DropdownMenuItem(value: 7, child: Text(l10n.retensiHari(7))),
            DropdownMenuItem(value: 30, child: Text(l10n.retensiHari(30))),
            DropdownMenuItem(value: 90, child: Text(l10n.retensiHari(90))),
          ],
          onChanged: (v) async {
            await ref
                .read(settingsRepositoryProvider)
                .tulis(SettingKeys.retensiChatHari, '${v ?? 0}');
            ref.invalidate(_retensiProvider);
          },
        ),
        const SizedBox(height: FinaraSpacing.sm),
        TextButton.icon(
          style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error),
          icon: const Icon(Icons.delete_sweep_outlined),
          label: Text(l10n.hapusSemuaPercakapan),
          onPressed: () async {
            await ref.read(chatRepositoryProvider).hapusSemua();
            ref.invalidate(daftarPercakapanProvider);
          },
        ),
      ],
    );
  }
}
