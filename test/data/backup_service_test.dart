import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:finara/data/db/app_database.dart';
import 'package:finara/data/repositories/allocation_repository.dart';
import 'package:finara/data/repositories/settings_repository.dart';
import 'package:finara/data/services/backup_service.dart';
import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/services/allocation_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<AppDatabase> dbIsi() async {
    final db = AppDatabase(NativeDatabase.memory());
    const input = AllocationInput(
      tahun: 2026,
      bulan: 8,
      penghasilanUtama: 10000000,
      jagoBp: 4000,
      investasiBp: 3000,
      danaBp: 3000,
      bibitBp: 7000,
      stockbitBp: 3000,
    );
    await AllocationRepository(db).simpanRevisi(
        input: input, hasil: const AllocationEngine().hitung(input));
    await SettingsRepository(db).tulis(SettingKeys.temaMode, 'dark');
    return db;
  }

  test('roundtrip backup terenkripsi §51: data kembali identik', () async {
    final sumber = await dbIsi();
    addTearDown(sumber.close);
    final bytes =
        await BackupService(sumber, iterasiPbkdf2: 1000).buatCadangan('rahasia-uji');

    final tujuan = AppDatabase(NativeDatabase.memory());
    addTearDown(tujuan.close);
    await BackupService(tujuan, iterasiPbkdf2: 1000)
        .pulihkan(bytes, 'rahasia-uji');

    final revisi = await (tujuan.select(tujuan.monthlyAllocationRevisions))
        .getSingle();
    expect(revisi.totalPendapatan, 10000000);
    expect(revisi.alokasiBibit, greaterThan(0));
    final tema = await SettingsRepository(tujuan).baca(SettingKeys.temaMode);
    expect(tema, 'dark');
    final checklist = await tujuan.select(tujuan.checklistItems).get();
    expect(checklist, isNotEmpty);
  });

  test('frasa sandi salah → gagal tanpa mengubah data', () async {
    final sumber = await dbIsi();
    addTearDown(sumber.close);
    final bytes = await BackupService(sumber, iterasiPbkdf2: 1000)
        .buatCadangan('benar');

    final tujuan = await dbIsi();
    addTearDown(tujuan.close);
    await expectLater(
        BackupService(tujuan, iterasiPbkdf2: 1000).pulihkan(bytes, 'salah'),
        throwsA(anything));
    // Data lama utuh.
    expect(await tujuan.select(tujuan.monthlyAllocations).get(),
        hasLength(1));
  });

  test('file bukan cadangan Finara → FormatException', () async {
    final db = await dbIsi();
    addTearDown(db.close);
    await expectLater(
        BackupService(db, iterasiPbkdf2: 1000)
            .pulihkan(Uint8List.fromList(List.filled(64, 7)), 'apa saja'),
        throwsFormatException);
  });

  test('isi cadangan tidak memuat kata kunci API key', () async {
    final db = await dbIsi();
    addTearDown(db.close);
    final snapshot = await BackupService(db).snapshot();
    expect(snapshot.toString().toLowerCase(), isNot(contains('apikey')));
    expect(snapshot['tabel'], isNot(contains('kredensial')));
  });
}
