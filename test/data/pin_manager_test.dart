import 'package:finara/data/services/pin_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSecureStorage extends Fake implements FlutterSecureStorage {
  final Map<String, String> _data = {};

  @override
  Future<String?> read(
          {required String key,
          AppleOptions? iOptions,
          AndroidOptions? aOptions,
          LinuxOptions? lOptions,
          WebOptions? webOptions,
          AppleOptions? mOptions,
          WindowsOptions? wOptions}) async =>
      _data[key];

  @override
  Future<void> write(
      {required String key,
      required String? value,
      AppleOptions? iOptions,
      AndroidOptions? aOptions,
      LinuxOptions? lOptions,
      WebOptions? webOptions,
      AppleOptions? mOptions,
      WindowsOptions? wOptions}) async {
    if (value == null) {
      _data.remove(key);
    } else {
      _data[key] = value;
    }
  }

  @override
  Future<void> delete(
      {required String key,
      AppleOptions? iOptions,
      AndroidOptions? aOptions,
      LinuxOptions? lOptions,
      WebOptions? webOptions,
      AppleOptions? mOptions,
      WindowsOptions? wOptions}) async {
    _data.remove(key);
  }

  Map<String, String> get isi => _data;
}

void main() {
  test('set → verifikasi benar/salah → hapus', () async {
    final storage = FakeSecureStorage();
    final pin = PinManager(storage: storage);

    expect(await pin.adaPin(), isFalse);

    await pin.setPin('123456');
    expect(await pin.adaPin(), isTrue);
    expect(await pin.verifikasi('123456'), isTrue);
    expect(await pin.verifikasi('654321'), isFalse);

    await pin.hapusPin();
    expect(await pin.adaPin(), isFalse);
    expect(await pin.verifikasi('123456'), isFalse);
  });

  test('PIN tidak disimpan plaintext; salt membuat hash unik', () async {
    final storage = FakeSecureStorage();
    await PinManager(storage: storage).setPin('123456');

    expect(storage.isi.values, isNot(contains('123456')));

    final storage2 = FakeSecureStorage();
    await PinManager(storage: storage2).setPin('123456');
    // Salt acak → hash berbeda antarinstal.
    expect(storage.isi['finara_pin_hash_v1'],
        isNot(storage2.isi['finara_pin_hash_v1']));
  });
}
