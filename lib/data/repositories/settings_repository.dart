/// Pengaturan aplikasi key-value bertipe (tema, pembulatan default).
/// Kredensial TIDAK disimpan di sini — gunakan flutter_secure_storage (§45).
library;

import 'package:drift/drift.dart';

import '../db/app_database.dart';

abstract final class SettingKeys {
  static const temaMode = 'temaMode'; // system | light | dark
  static const pembulatanDefault = 'pembulatanDefault'; // nama RoundingOption
  static const onboardingSelesai = 'onboardingSelesai'; // true | false
  static const biometrikAktif = 'biometrikAktif'; // true | false
  static const retensiChatHari = 'retensiChatHari'; // '0' = selamanya
}

class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  Future<String?> baca(String kunci) async {
    final row = await (_db.select(_db.appSettings)
          ..where((t) => t.kunci.equals(kunci)))
        .getSingleOrNull();
    return row?.nilai;
  }

  Future<void> tulis(String kunci, String nilai) async {
    await _db.into(_db.appSettings).insert(
          AppSettingsCompanion.insert(kunci: kunci, nilai: nilai),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> hapus(String kunci) async {
    await (_db.delete(_db.appSettings)..where((t) => t.kunci.equals(kunci)))
        .go();
  }
}
