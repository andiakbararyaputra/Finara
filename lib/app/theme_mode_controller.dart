import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/settings_repository.dart';
import 'providers.dart';

/// Mode tema aplikasi, persisten via AppSettings (§51).
class ThemeModeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _muatTersimpan();
    return ThemeMode.system;
  }

  Future<void> _muatTersimpan() async {
    final nilai =
        await ref.read(settingsRepositoryProvider).baca(SettingKeys.temaMode);
    final tersimpan = switch (nilai) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => null,
    };
    if (tersimpan != null && tersimpan != state) state = tersimpan;
  }

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    await ref
        .read(settingsRepositoryProvider)
        .tulis(SettingKeys.temaMode, mode.name);
  }
}

final themeModeProvider =
    NotifierProvider<ThemeModeController, ThemeMode>(ThemeModeController.new);
