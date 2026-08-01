/// Repository data aktual investasi manual (§116) — upsert per periode.
library;

import 'package:drift/drift.dart';

import '../../domain/models/finance_enums.dart';
import '../../domain/services/stockbit_reconciliation_service.dart';
import '../db/app_database.dart';

class InvestmentActualRepository {
  InvestmentActualRepository(this._db);

  final AppDatabase _db;

  Future<int> simpan({
    required InvestmentPlatform platform,
    required int tahun,
    required int bulan,
    int? depositEksternal,
    int? penarikan,
    int? pembelianBersih,
    int? penjualanBersih,
    int? saldoRdnAwal,
    int? saldoRdnAkhir,
    int? biaya,
    int? dividen,
    int? nilaiPortofolio,
    int? modalInvestasi,
    VerificationStatus verifikasi = VerificationStatus.belumDiverifikasi,
    String? catatan,
    DateTime? sekarang,
  }) {
    return _db.into(_db.investmentActuals).insert(
          InvestmentActualsCompanion.insert(
            platform: platform,
            tahun: tahun,
            bulan: bulan,
            depositEksternal: Value(depositEksternal),
            penarikan: Value(penarikan),
            pembelianBersih: Value(pembelianBersih),
            penjualanBersih: Value(penjualanBersih),
            saldoRdnAwal: Value(saldoRdnAwal),
            saldoRdnAkhir: Value(saldoRdnAkhir),
            biaya: Value(biaya),
            dividen: Value(dividen),
            nilaiPortofolio: Value(nilaiPortofolio),
            modalInvestasi: Value(modalInvestasi),
            verifikasi: verifikasi,
            catatan: Value(catatan),
            diperbaruiPada: sekarang ?? DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<InvestmentActual?> periode(
      InvestmentPlatform platform, int tahun, int bulan) {
    return (_db.select(_db.investmentActuals)
          ..where((t) =>
              t.platform.equalsValue(platform) &
              t.tahun.equals(tahun) &
              t.bulan.equals(bulan)))
        .getSingleOrNull();
  }

  /// Riwayat periode terbaru dulu utk satu platform.
  Future<List<InvestmentActual>> riwayat(InvestmentPlatform platform,
      {int batas = 12}) {
    return (_db.select(_db.investmentActuals)
          ..where((t) => t.platform.equalsValue(platform))
          ..orderBy([
            (t) => OrderingTerm.desc(t.tahun),
            (t) => OrderingTerm.desc(t.bulan),
          ])
          ..limit(batas))
        .get();
  }
}

/// Konversi baris DB ke input domain (§112).
InvestmentActualInput aktualDariRow(InvestmentActual row) {
  return InvestmentActualInput(
    depositEksternal: row.depositEksternal,
    penarikan: row.penarikan,
    pembelianBersih: row.pembelianBersih,
    penjualanBersih: row.penjualanBersih,
    saldoRdnAwal: row.saldoRdnAwal,
    saldoRdnAkhir: row.saldoRdnAkhir,
    biaya: row.biaya,
    dividen: row.dividen,
    nilaiPortofolio: row.nilaiPortofolio,
    modalInvestasi: row.modalInvestasi,
    terverifikasi: row.verifikasi == VerificationStatus.terverifikasi,
  );
}
