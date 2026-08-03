import 'package:drift/native.dart';
import 'package:finara/data/db/app_database.dart';
import 'package:finara/data/repositories/allocation_repository.dart';
import 'package:finara/data/services/export_service.dart';
import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/services/allocation_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('buatGambar §50 menghasilkan PNG valid', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
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
    final revisi =
        await db.select(db.monthlyAllocationRevisions).getSingle();

    final bytes = await tester.runAsync(() => const ExportService()
        .buatGambar(judulBulan: 'Agustus 2026', revisi: revisi));

    // Tanda tangan PNG.
    expect(bytes!.length, greaterThan(1000));
    expect(bytes.sublist(0, 8),
        [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]);
  });
}
