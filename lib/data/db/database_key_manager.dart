/// Kunci enkripsi database: dibuat acak sekali, disimpan HANYA di
/// flutter_secure_storage (Android Keystore). Tidak pernah di-log,
/// diekspor, atau ikut backup (§45, §51).
library;

import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DatabaseKeyManager {
  DatabaseKeyManager({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _kunciStorage = 'finara_db_key_v1';
  final FlutterSecureStorage _storage;

  /// Ambil kunci; buat baru (256-bit hex) jika belum ada.
  Future<String> ambilAtauBuat() async {
    final ada = await _storage.read(key: _kunciStorage);
    if (ada != null && ada.isNotEmpty) return ada;
    final baru = _buatKunciHex();
    await _storage.write(key: _kunciStorage, value: baru);
    return baru;
  }

  Future<void> hapus() => _storage.delete(key: _kunciStorage);

  static String _buatKunciHex() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
