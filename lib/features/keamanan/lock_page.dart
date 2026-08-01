import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../data/repositories/settings_repository.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../l10n/app_localizations.dart';

/// Kunci aplikasi (§51): verifikasi PIN, opsional biometrik.
class LockPage extends ConsumerStatefulWidget {
  const LockPage({super.key});

  @override
  ConsumerState<LockPage> createState() => _LockPageState();
}

class _LockPageState extends ConsumerState<LockPage> {
  final _pinCtrl = TextEditingController();
  String? _error;
  bool _biometrikAktif = false;

  @override
  void initState() {
    super.initState();
    _siapkanBiometrik();
  }

  @override
  void dispose() {
    _pinCtrl.dispose();
    super.dispose();
  }

  Future<void> _siapkanBiometrik() async {
    final aktif = await ref
        .read(settingsRepositoryProvider)
        .baca(SettingKeys.biometrikAktif);
    if (!mounted || aktif != 'true') return;
    setState(() => _biometrikAktif = true);
    await _bukaDenganBiometrik();
  }

  Future<void> _bukaDenganBiometrik() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final auth = LocalAuthentication();
      final berhasil = await auth.authenticate(
        localizedReason: l10n.aplikasiTerkunci,
        persistAcrossBackgrounding: true,
      );
      if (berhasil && mounted) _masuk();
    } catch (_) {
      // Perangkat tanpa biometrik/emulator: tetap pakai PIN.
    }
  }

  Future<void> _verifikasiPin() async {
    final l10n = AppLocalizations.of(context)!;
    final cocok =
        await ref.read(pinManagerProvider).verifikasi(_pinCtrl.text);
    if (!mounted) return;
    if (cocok) {
      _masuk();
    } else {
      setState(() {
        _error = l10n.pinSalah;
        _pinCtrl.clear();
      });
    }
  }

  void _masuk() => context.go(FinaraRoutes.beranda);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Padding(
              padding: const EdgeInsets.all(FinaraSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline_rounded,
                      size: 56, color: theme.colorScheme.primary),
                  const SizedBox(height: FinaraSpacing.lg),
                  Text(l10n.aplikasiTerkunci,
                      style: theme.textTheme.titleLarge),
                  const SizedBox(height: FinaraSpacing.xl),
                  TextField(
                    controller: _pinCtrl,
                    autofocus: true,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: l10n.masukkanPin,
                      errorText: _error,
                      counterText: '',
                    ),
                    onSubmitted: (_) => _verifikasiPin(),
                  ),
                  const SizedBox(height: FinaraSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _verifikasiPin,
                      child: Text(l10n.bukaKunci),
                    ),
                  ),
                  if (_biometrikAktif) ...[
                    const SizedBox(height: FinaraSpacing.md),
                    TextButton.icon(
                      onPressed: _bukaDenganBiometrik,
                      icon: const Icon(Icons.fingerprint_rounded),
                      label: Text(l10n.biometrik),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
