import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/settings_repository.dart';
import '../design_system/theme/finara_theme.dart';
import '../l10n/app_localizations.dart';
import 'providers.dart';
import 'router.dart';
import 'theme_mode_controller.dart';

class FinaraApp extends ConsumerStatefulWidget {
  const FinaraApp({super.key});

  @override
  ConsumerState<FinaraApp> createState() => _FinaraAppState();
}

class _FinaraAppState extends ConsumerState<FinaraApp>
    with WidgetsBindingObserver {
  static const _autoLockMenitDefault = 5;
  DateTime? _ditinggalPada;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _ditinggalPada = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      _cekAutoLock();
    }
  }

  Future<void> _cekAutoLock() async {
    final ditinggal = _ditinggalPada;
    _ditinggalPada = null;
    if (ditinggal == null) return;
    final nilai = await ref
        .read(settingsRepositoryProvider)
        .baca(SettingKeys.autoLockMenit);
    final batas =
        Duration(minutes: int.tryParse(nilai ?? '') ?? _autoLockMenitDefault);
    if (DateTime.now().difference(ditinggal) < batas) {
      return;
    }
    if (await ref.read(pinManagerProvider).adaPin()) {
      ref.read(routerProvider).go(FinaraRoutes.kunci);
    }
  }

  @override
  Widget build(BuildContext context) {
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
