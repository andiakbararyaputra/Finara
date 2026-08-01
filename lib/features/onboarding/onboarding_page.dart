import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../data/repositories/settings_repository.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../l10n/app_localizations.dart';

/// Onboarding Fase 1: 3 halaman tanpa halaman AI (§7).
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _pageController = PageController();
  int _halaman = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final halaman = [
      (Icons.pie_chart_outline_rounded, l10n.onboarding1Judul,
          l10n.onboarding1Isi),
      (Icons.savings_outlined, l10n.onboarding2Judul, l10n.onboarding2Isi),
      (Icons.lock_outline_rounded, l10n.onboarding3Judul, l10n.onboarding3Isi),
    ];
    final terakhir = _halaman == halaman.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(FinaraSpacing.md),
                    child: TextButton(
                      onPressed: _selesai,
                      child: Text(l10n.lewati),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: halaman.length,
                    onPageChanged: (i) => setState(() => _halaman = i),
                    itemBuilder: (context, i) {
                      final (icon, judul, isi) = halaman[i];
                      return Padding(
                        padding: const EdgeInsets.all(FinaraSpacing.xxl),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(icon,
                                size: 96,
                                color: theme.colorScheme.primary),
                            const SizedBox(height: FinaraSpacing.xxl),
                            Text(judul,
                                style: theme.textTheme.headlineSmall,
                                textAlign: TextAlign.center),
                            const SizedBox(height: FinaraSpacing.md),
                            Text(isi,
                                style: theme.textTheme.bodyLarge,
                                textAlign: TextAlign.center),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(FinaraSpacing.xl),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 0; i < halaman.length; i++)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: i == _halaman ? 24 : 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: FinaraSpacing.xs / 2),
                              decoration: BoxDecoration(
                                color: i == _halaman
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.outlineVariant,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: FinaraSpacing.lg),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: terakhir
                              ? _selesai
                              : () => _pageController.nextPage(
                                    duration:
                                        const Duration(milliseconds: 250),
                                    curve: Curves.easeOut,
                                  ),
                          child: Text(
                              terakhir ? l10n.mulaiGunakan : l10n.berikutnya),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selesai() async {
    await ref
        .read(settingsRepositoryProvider)
        .tulis(SettingKeys.onboardingSelesai, 'true');
    if (!mounted) return;
    context.go(FinaraRoutes.beranda);
  }
}
