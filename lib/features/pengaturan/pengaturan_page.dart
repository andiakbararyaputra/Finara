import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/data_providers.dart';
import '../../app/providers.dart';
import '../../app/router.dart';
import '../../app/theme_mode_controller.dart';
import '../../data/repositories/settings_repository.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../l10n/app_localizations.dart';

/// Pengaturan Fase 1: tema persisten + tentang + disclaimer (§51 subset).
class PengaturanPage extends ConsumerWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final mode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.pengaturan)),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.all(FinaraSpacing.lg),
            children: [
              Text(l10n.tema, style: theme.textTheme.titleMedium),
              RadioGroup<ThemeMode>(
                groupValue: mode,
                onChanged: (v) {
                  if (v != null) {
                    ref.read(themeModeProvider.notifier).setMode(v);
                  }
                },
                child: Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      value: ThemeMode.system,
                      title: Text(l10n.temaSistem),
                    ),
                    RadioListTile<ThemeMode>(
                      value: ThemeMode.light,
                      title: Text(l10n.temaTerang),
                    ),
                    RadioListTile<ThemeMode>(
                      value: ThemeMode.dark,
                      title: Text(l10n.temaGelap),
                    ),
                  ],
                ),
              ),
              const Divider(height: FinaraSpacing.xxl),
              Text(l10n.keamanan, style: theme.textTheme.titleMedium),
              const _SectionKeamanan(),
              const Divider(height: FinaraSpacing.xxl),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.subscriptions_outlined),
                title: Text(l10n.kelolaLangganan),
                onTap: () => context.push(FinaraRoutes.langganan),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.account_balance_wallet_outlined),
                title: Text(l10n.danaPlusJudul),
                onTap: () => context.push(FinaraRoutes.danaPlus),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.slideshow_outlined),
                title: Text(l10n.lihatOnboarding),
                onTap: () => context.push(FinaraRoutes.onboarding),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.delete_forever_outlined,
                    color: theme.colorScheme.error),
                title: Text(l10n.hapusSemuaData,
                    style: TextStyle(color: theme.colorScheme.error)),
                onTap: () => _konfirmasiHapusData(context, ref),
              ),
              const Divider(height: FinaraSpacing.xxl),
              Text(l10n.tentang, style: theme.textTheme.titleMedium),
              const SizedBox(height: FinaraSpacing.sm),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.info_outline_rounded),
                title: Text(l10n.versiAplikasi),
                subtitle: const Text('0.1.0'),
              ),
              const SizedBox(height: FinaraSpacing.md),
              Text(
                l10n.disclaimerUtama,
                style: theme.textTheme.bodySmall!
                    .copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: FinaraSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _konfirmasiHapusData(
      BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.hapusSemuaData),
        content: Text(l10n.hapusSemuaDataPesan),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.batal),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.hapus),
          ),
        ],
      ),
    );
    if (yakin != true) return;
    await ref.read(databaseProvider).hapusSemuaData();
    await ref.read(pinManagerProvider).hapusPin();
    ref
      ..invalidate(revisiBulanAktifProvider)
      ..invalidate(daftarRiwayatProvider)
      ..invalidate(daftarLanggananProvider)
      ..invalidate(_statusPinProvider);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.dataTerhapus)));
    context.go(FinaraRoutes.beranda);
  }
}

final _statusPinProvider = FutureProvider<bool>(
    (ref) => ref.watch(pinManagerProvider).adaPin());

class _SectionKeamanan extends ConsumerWidget {
  const _SectionKeamanan();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final adaPin = ref.watch(_statusPinProvider).value ?? false;
    final biometrik = ref.watch(_biometrikProvider).value ?? false;

    return Column(
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.pin_outlined),
          title: Text(l10n.pinAplikasi),
          value: adaPin,
          onChanged: (aktifkan) async {
            if (aktifkan) {
              await _dialogAturPin(context, ref);
            } else {
              await ref.read(pinManagerProvider).hapusPin();
              await ref
                  .read(settingsRepositoryProvider)
                  .tulis(SettingKeys.biometrikAktif, 'false');
            }
            ref
              ..invalidate(_statusPinProvider)
              ..invalidate(_biometrikProvider);
          },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.fingerprint_rounded),
          title: Text(l10n.biometrik),
          value: biometrik && adaPin,
          onChanged: !adaPin
              ? null
              : (v) async {
                  await ref
                      .read(settingsRepositoryProvider)
                      .tulis(SettingKeys.biometrikAktif, '$v');
                  ref.invalidate(_biometrikProvider);
                },
        ),
      ],
    );
  }

  Future<void> _dialogAturPin(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final pin1Ctrl = TextEditingController();
    final pin2Ctrl = TextEditingController();
    String? error;

    final simpan = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.aturPin),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: pin1Ctrl,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                    labelText: l10n.masukkanPin, counterText: ''),
              ),
              const SizedBox(height: FinaraSpacing.md),
              TextField(
                controller: pin2Ctrl,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                    labelText: l10n.ulangiPin,
                    counterText: '',
                    errorText: error),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.batal),
            ),
            FilledButton(
              onPressed: () {
                if (pin1Ctrl.text.length < 4 ||
                    pin1Ctrl.text != pin2Ctrl.text) {
                  setState(() => error = l10n.pinTidakSama);
                  return;
                }
                Navigator.pop(dialogContext, true);
              },
              child: Text(l10n.simpan),
            ),
          ],
        ),
      ),
    );

    if (simpan == true) {
      await ref.read(pinManagerProvider).setPin(pin1Ctrl.text);
    }
  }
}

final _biometrikProvider = FutureProvider<bool>((ref) async {
  final nilai = await ref
      .watch(settingsRepositoryProvider)
      .baca(SettingKeys.biometrikAktif);
  return nilai == 'true';
});
