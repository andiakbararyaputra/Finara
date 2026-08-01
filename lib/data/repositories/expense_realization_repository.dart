/// Repository realisasi pengeluaran (§22A). Pemindahan antarplatform bukan
/// pengeluaran; sisa anggaran uang jajan dihitung dari realisasi yang
/// sumber anggarannya Alokasi DANA.
library;

import 'package:drift/drift.dart';

import '../../domain/models/allocation_input.dart';
import '../../domain/models/finance_enums.dart';
import '../db/app_database.dart';

class ExpenseRealizationRepository {
  ExpenseRealizationRepository(this._db);

  final AppDatabase _db;

  Future<int> catat({
    required DateTime tanggal,
    required int nominal,
    required BudgetSource sumberAnggaran,
    required PaymentChannel kanalPembayaran,
    String? kategoriId,
    int? revisiId,
    String? referensiItemId,
    VerificationStatus verifikasi = VerificationStatus.belumDiverifikasi,
    String? catatan,
  }) {
    if (nominal < 0) {
      throw ArgumentError.value(nominal, 'nominal', 'tidak boleh negatif');
    }
    return _db.into(_db.expenseRealizations).insert(
          ExpenseRealizationsCompanion.insert(
            transactionDate: tanggal,
            amount: nominal,
            categoryId: Value(kategoriId),
            fundingSource: sumberAnggaran,
            paymentChannel: kanalPembayaran,
            monthlyAllocationRevisionId: Value(revisiId),
            referenceItemId: Value(referensiItemId),
            verificationStatus: verifikasi,
            userNotes: Value(catatan),
          ),
        );
  }

  Future<List<ExpenseRealization>> perRevisi(int revisiId) {
    return (_db.select(_db.expenseRealizations)
          ..where((t) => t.monthlyAllocationRevisionId.equals(revisiId))
          ..orderBy([(t) => OrderingTerm.desc(t.transactionDate)]))
        .get();
  }

  /// Semua realisasi dalam satu bulan kalender (berdasarkan tanggal
  /// transaksi), terbaru dulu.
  Future<List<ExpenseRealization>> perBulan(int tahun, int bulan) {
    final awal = DateTime(tahun, bulan);
    final akhir = DateTime(tahun, bulan + 1);
    return (_db.select(_db.expenseRealizations)
          ..where((t) =>
              t.transactionDate.isBiggerOrEqualValue(awal) &
              t.transactionDate.isSmallerThanValue(akhir))
          ..orderBy([
            (t) => OrderingTerm.desc(t.transactionDate),
            (t) => OrderingTerm.desc(t.id),
          ]))
        .get();
  }

  /// Total realisasi per sumber anggaran pada satu revisi.
  Future<int> totalPerSumber(int revisiId, BudgetSource sumber) async {
    final jumlah = _db.expenseRealizations.amount.sum();
    final query = _db.selectOnly(_db.expenseRealizations)
      ..addColumns([jumlah])
      ..where(_db.expenseRealizations.monthlyAllocationRevisionId
              .equals(revisiId) &
          _db.expenseRealizations.fundingSource
              .equalsValue(sumber));
    final row = await query.getSingle();
    return row.read(jumlah) ?? 0;
  }

  /// Sisa anggaran uang jajan (§22A): Alokasi DANA − realisasi bersumber
  /// Alokasi DANA. Null jika belum ada realisasi sama sekali (bukan 0).
  Future<int?> sisaAnggaranDana({
    required int revisiId,
    required int alokasiDana,
  }) async {
    final adaRealisasi = await (_db.select(_db.expenseRealizations)
          ..where((t) => t.monthlyAllocationRevisionId.equals(revisiId))
          ..limit(1))
        .getSingleOrNull();
    if (adaRealisasi == null) return null;
    final terpakai =
        await totalPerSumber(revisiId, BudgetSource.alokasiDana);
    return alokasiDana - terpakai;
  }

  Future<void> hapus(int id) async {
    await (_db.delete(_db.expenseRealizations)..where((t) => t.id.equals(id)))
        .go();
  }
}
