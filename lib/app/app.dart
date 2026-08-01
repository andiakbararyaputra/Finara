import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../design_system/theme/finara_theme.dart';
import '../l10n/app_localizations.dart';
import 'router.dart';
import 'theme_mode_controller.dart';

class FinaraApp extends ConsumerWidget {
  const FinaraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Finara',
      debugShowCheckedModeBanner: false,
      theme: buildFinaraTheme(Brightness.light),
      darkTheme: buildFinaraTheme(Brightness.dark),
      themeMode: themeMode,
      locale: const Locale('id'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
