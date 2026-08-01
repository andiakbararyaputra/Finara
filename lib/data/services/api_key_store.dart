/// Penyimpanan API key provider AI di secure storage (§45):
/// tidak pernah di database, log, ekspor, atau backup.
library;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiKeyStore {
  ApiKeyStore({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  String _kunci(int providerId) => 'ai_api_key_$providerId';

  Future<void> simpan(int providerId, String apiKey) =>
      _storage.write(key: _kunci(providerId), value: apiKey);

  Future<String?> baca(int providerId) =>
      _storage.read(key: _kunci(providerId));

  Future<void> hapus(int providerId) =>
      _storage.delete(key: _kunci(providerId));

  /// Tampilan tersamarkan utk UI (§45): 4 karakter terakhir saja.
  static String samarkan(String apiKey) {
    if (apiKey.length <= 4) return '••••';
    return '••••${apiKey.substring(apiKey.length - 4)}';
  }
}
