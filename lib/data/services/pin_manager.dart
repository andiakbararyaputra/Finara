/// PIN aplikasi (§51): disimpan sebagai hash SHA-256 + salt acak di
/// secure storage. PIN mentah tidak pernah disimpan atau di-log.
library;

import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinManager {
  PinManager({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _kunciHash = 'finara_pin_hash_v1';
  static const _kunciSalt = 'finara_pin_salt_v1';
  final FlutterSecureStorage _storage;

  Future<bool> adaPin() async {
    final hash = await _storage.read(key: _kunciHash);
    return hash != null && hash.isNotEmpty;
  }

  Future<void> setPin(String pin) async {
    final salt = _saltAcak();
    await _storage.write(key: _kunciSalt, value: salt);
    await _storage.write(key: _kunciHash, value: _hash(pin, salt));
  }

  Future<bool> verifikasi(String pin) async {
    final hash = await _storage.read(key: _kunciHash);
    final salt = await _storage.read(key: _kunciSalt);
    if (hash == null || salt == null) return false;
    return _hash(pin, salt) == hash;
  }

  Future<void> hapusPin() async {
    await _storage.delete(key: _kunciHash);
    await _storage.delete(key: _kunciSalt);
  }

  static String _hash(String pin, String salt) =>
      sha256.convert(utf8.encode('$salt:$pin')).toString();

  static String _saltAcak() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64Encode(bytes);
  }
}
