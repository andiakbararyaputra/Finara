import 'package:drift/native.dart';
import 'package:finara/data/db/app_database.dart';
import 'package:finara/data/repositories/allocation_repository.dart';
import 'package:finara/data/repositories/expense_realization_repository.dart';
import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/models/finance_enums.dart';
import 'package:finara/domain/services/allocation_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late AllocationRepository repo;
  const engine = AllocationEngine();

  const input = AllocationInput(
    tahun: 2026,
    bulan: 8,
    penghasilanUtama: 10000000,
    penghasilanTambahan: [
      IncomeSourceInput(
          nama: 'Bonus', nominal: 1000000, disertakanBulanAktif: true),
    ],
    pengeluaranWajib: [
      MandatoryExpenseInput(nama: 'Kos', nominal: 1500000),
      MandatoryExpenseInput(
          nama: 'Listrik', nominal: 300000, kanalPembayaran: PaymentChannel.dana),
    ],
    jagoBp: 4000,
    investasiBp: 3000,
    danaBp: 3000,
    bibitBp: 7000,
    stockbitBp: 3000,
  );

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = AllocationRepository(db);
  });

  tearDown(() => db.close());

  test('simpan revisi pertama: snapshot lengkap + relasi anak', () async {
    final hasil = engine.hitung(input);
    final revisiId = await repo.simpanRevisi(
      input: input,
      hasil: hasil,
      namaPreset: 'standardHybrid',
      sekarang: DateTime(2026, 8, 1),
    );

    final revisi = await repo.revisiAktifBulan(2026, 8);
    expect(revisi, isNotNull);
    expect(revisi!.id, revisiId);
    expect(revisi.nomorRevisi, 1);
    expect(revisi.status, RevisionStatus.draf);
    expect(revisi.totalPendapatan, hasil.totalPendapatan);
    expect(revisi.alokasiBibit + revisi.alokasiStockbit,
        revisi.totalAlokasiInvestasi);

    final investasi = await repo.alokasiInvestasiRevisi(revisiId);
    expect(investasi, hasLength(2));
    expect(
        investasi.fold<int>(0, (sum, a) => sum + a.roundedAmount),
        hasil.totalAlokasiInvestasi);

    final checklist = await repo.checklistRevisi(revisiId);
    expect(checklist, isNotEmpty);
    // Item dinamis kanal DANA untuk Listrik (§21).
    expect(checklist.map((c) => c.kode), contains('pindahkanWajibKeDana'));
    expect(checklist.every((c) => !c.selesai), isTrue);
  });

  test('revisi kedua: nomor bertambah, revisi lama ditandai direvisi (§22)',
      () async {
    final hasil = engine.hitung(input);
    final pertama = await repo.simpanRevisi(input: input, hasil: hasil);
    await repo.ubahStatus(pertama, RevisionStatus.dikonfirmasi);

    final kedua = await repo.simpanRevisi(
      input: input,
      hasil: hasil,
      alasanPerubahan: 'Koreksi pengeluaran wajib',
    );

    final bulan = (await repo.daftarBulan()).single;
    final riwayat = await repo.riwayatRevisi(bulan.id);
    expect(riwayat, hasLength(2));
    expect(riwayat.first.id, kedua);
    expect(riwayat.first.nomorRevisi, 2);
    expect(riwayat.first.alasanPerubahan, 'Koreksi pengeluaran wajib');
    // Audit trail: revisi lama tetap ada dengan snapshot utuh.
    expect(riwayat.last.id, pertama);
    expect(riwayat.last.status, RevisionStatus.direvisi);
    expect(riwayat.last.totalPendapatan, hasil.totalPendapatan);
  });

  test('sumber anggaran wajib = Kantong Pengeluaran Wajib, kanal terpisah',
      () async {
    final hasil = engine.hitung(input);
    final revisiId = await repo.simpanRevisi(input: input, hasil: hasil);

    final assignments =
        await db.select(db.budgetFundingAssignments).get();
    expect(assignments, hasLength(2));
    expect(
        assignments
            .every((a) => a.fundingSource == BudgetSource.kantongPengeluaranWajib),
        isTrue);
    expect(assignments.map((a) => a.paymentChannel),
        containsAll([PaymentChannel.bankJago, PaymentChannel.dana]));
    expect(assignments.every((a) => a.revisionId == revisiId), isTrue);
  });

  test('checklist dapat ditandai selesai tanpa mengubah nominal revisi',
      () async {
    final hasil = engine.hitung(input);
    final revisiId = await repo.simpanRevisi(input: input, hasil: hasil);
    final item = (await repo.checklistRevisi(revisiId)).first;

    await repo.setChecklistSelesai(item.id, selesai: true);

    final sesudah = (await repo.checklistRevisi(revisiId)).first;
    expect(sesudah.selesai, isTrue);
    final revisi = await repo.revisiAktifBulan(2026, 8);
    expect(revisi!.totalPendapatan, hasil.totalPendapatan);
  });

  test('realisasi: sisa anggaran DANA null tanpa realisasi, lalu terhitung',
      () async {
    final hasil = engine.hitung(input);
    final revisiId = await repo.simpanRevisi(input: input, hasil: hasil);
    final realisasiRepo = ExpenseRealizationRepository(db);

    // Belum ada realisasi → null, bukan 0 (§53 null vs 0).
    expect(
      await realisasiRepo.sisaAnggaranDana(
          revisiId: revisiId, alokasiDana: hasil.alokasiDana),
      isNull,
    );

    await realisasiRepo.catat(
      tanggal: DateTime(2026, 8, 5),
      nominal: 50000,
      sumberAnggaran: BudgetSource.alokasiDana,
      kanalPembayaran: PaymentChannel.dana,
      revisiId: revisiId,
    );
    // Pengeluaran wajib via DANA TIDAK mengurangi uang jajan (§22A).
    await realisasiRepo.catat(
      tanggal: DateTime(2026, 8, 6),
      nominal: 300000,
      sumberAnggaran: BudgetSource.kantongPengeluaranWajib,
      kanalPembayaran: PaymentChannel.dana,
      revisiId: revisiId,
    );

    expect(
      await realisasiRepo.sisaAnggaranDana(
          revisiId: revisiId, alokasiDana: hasil.alokasiDana),
      hasil.alokasiDana - 50000,
    );
  });

  test('realisasi nominal negatif ditolak', () async {
    final realisasiRepo = ExpenseRealizationRepository(db);
    expect(
      () => realisasiRepo.catat(
        tanggal: DateTime(2026, 8, 5),
        nominal: -1,
        sumberAnggaran: BudgetSource.alokasiDana,
        kanalPembayaran: PaymentChannel.dana,
      ),
      throwsArgumentError,
    );
  });
}
