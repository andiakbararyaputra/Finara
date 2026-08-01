import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../data/repositories/settings_repository.dart';
import '../../design_system/tokens/finara_colors.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../l10n/app_localizations.dart';

/// Splash (§7): logo + tagline, lalu arahkan ke onboarding atau beranda.
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _arahkan();
  }

  Future<void> _arahkan() async {
    final settings = ref.read(settingsRepositoryProvider);
    final selesai = await settings.baca(SettingKeys.onboardingSelesai);
    final adaPin = await ref.read(pinManagerProvider).adaPin();
    // Retensi riwayat chat (§47) dijalankan saat aplikasi dibuka.
    final retensi =
        int.tryParse(await settings.baca(SettingKeys.retensiChatHari) ?? '0');
    if (retensi != null && retensi > 0) {
      await ref.read(chatRepositoryProvider).hapusLebihTuaDari(retensi);
    }
    if (!mounted) return;
    if (selesai != 'true') {
      context.go(FinaraRoutes.onboarding);
    } else if (adaPin) {
      context.go(FinaraRoutes.kunci);
    } else {
      context.go(FinaraRoutes.beranda);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(FinaraSpacing.xl),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [FinaraColors.emerald, FinaraColors.emeraldDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(Icons.account_balance_wallet_rounded,
                  size: 56, color: Colors.white),
            ),
            const SizedBox(height: FinaraSpacing.lg),
            Text(l10n.appName, style: theme.textTheme.headlineMedium),
            const SizedBox(height: FinaraSpacing.xs),
            Text(
              l10n.appTagline,
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
