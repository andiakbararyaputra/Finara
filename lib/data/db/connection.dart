/// Pembuka koneksi database produksi: file di direktori dokumen aplikasi,
/// terenkripsi sqlite3mc via PRAGMA key sebelum skema dibuka.
library;

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'database_key_manager.dart';

QueryExecutor openEncryptedConnection(DatabaseKeyManager keyManager) {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'finara.db'));
    final kunci = await keyManager.ambilAtauBuat();
    return NativeDatabase.createInBackground(
      file,
      setup: (db) {
        // sqlite3mc membaca PRAGMA key sebelum akses halaman pertama.
        db.execute("PRAGMA key = '$kunci'");
        _verifikasiTerenkripsi(db);
      },
    );
  });
}

/// Gagal cepat jika cipher tidak aktif (mis. sqlite3 vanilla ter-bundle).
void _verifikasiTerenkripsi(Database db) {
  final hasil = db.select('PRAGMA cipher');
  if (hasil.isEmpty) {
    throw StateError(
      'sqlite3mc tidak aktif: database tidak akan terenkripsi. '
      'Periksa blok hooks di pubspec.yaml.',
    );
  }
}
