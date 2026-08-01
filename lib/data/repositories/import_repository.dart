/// Repository impor laporan (§73, §80): fingerprint anti-duplikat +
/// penyimpanan hasil terkonfirmasi ke InvestmentActuals (§72).
library;

import 'package:drift/drift.dart';

import '../../domain/models/finance_enums.dart';
import '../db/app_database.dart';
import 'investment_actual_repository.dart';

class ImportRepository {
  ImportRepository(this._db);

  final AppDatabase _db;

  /// True jika hash file sudah pernah diimpor (§73).
  Future<bool> sudahPernahDiimpor(String fileHash) async {
    final ada = await (_db.select(_db.importedReports)
          ..where((t) => t.fileHash.equals(fileHash))
          ..limit(1))
        .getSingleOrNull();
    return ada != null;
  }

  /// Simpan hasil impor terkonfirmasi (§65 langkah 11–12): catat riwayat
  /// impor + upsert data aktual Bibit periode tsb sebagai terverifikasi.
  Future<int> konfirmasiImporBibit({
    required String fileHash,
    required String namaFile,
    required int tahun,
    required int bulan,
    int? nilaiPortofolio,
    int? modalInvestasi,
    int? totalPembelian,
    int? totalPenjualan,
    DateTime? sekarang,
  }) {
    return _db.transaction(() async {
      final id = await _db.into(_db.importedReports).insert(
            ImportedReportsCompanion.insert(
              platform: InvestmentPlatform.bibit,
              jenis: 'statementBibit',
              tahun: Value(tahun),
              bulan: Value(bulan),
              fileHash: fileHash,
              namaFile: namaFile,
              diimporPada: sekarang ?? DateTime.now(),
            ),
          );
      await InvestmentActualRepository(_db).simpan(
        platform: InvestmentPlatform.bibit,
        tahun: tahun,
        bulan: bulan,
        pembelianBersih: totalPembelian,
        penjualanBersih: totalPenjualan,
        nilaiPortofolio: nilaiPortofolio,
        modalInvestasi: modalInvestasi,
        verifikasi: VerificationStatus.terverifikasi,
        catatan: 'Impor: $namaFile',
        sekarang: sekarang,
      );
      return id;
    });
  }

  Future<List<ImportedReport>> riwayatImpor() {
    return (_db.select(_db.importedReports)
          ..orderBy([(t) => OrderingTerm.desc(t.diimporPada)]))
        .get();
  }

  /// Hapus catatan impor (§78) — data aktual hasil impor tetap dipertahankan
  /// kecuali pengguna menghapusnya terpisah.
  Future<void> hapusCatatan(int id) async {
    await (_db.delete(_db.importedReports)..where((t) => t.id.equals(id)))
        .go();
  }
}
