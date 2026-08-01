/// Repository konfigurasi & ledger DANA+ (§88, §94).
library;

import 'package:drift/drift.dart';

import '../../domain/services/dana_split_service.dart';
import '../db/app_database.dart';

class DanaPlusRepository {
  DanaPlusRepository(this._db);

  final AppDatabase _db;

  Future<int> simpanKonfigurasi({
    required DanaPlusAvailability availability,
    required DanaSplitMode mode,
    required DanaExecutionStrategy strategi,
    int persenBiasaBp = 5000,
    int bufferBiasa = 0,
    int targetPlus = 0,
    int? batasPlus,
    int? tingkatRewardBp,
    RewardRatePeriod periodeReward = RewardRatePeriod.perTahun,
    DateTime? sekarang,
  }) {
    return _db.into(_db.danaPlusConfigurations).insert(
          DanaPlusConfigurationsCompanion.insert(
            availability: availability,
            defaultSplitMode: mode,
            executionStrategy: strategi,
            persenBiasaBp: Value(persenBiasaBp),
            bufferBiasa: Value(bufferBiasa),
            targetPlus: Value(targetPlus),
            batasPlus: Value(batasPlus),
            tingkatRewardBp: Value(tingkatRewardBp),
            periodeReward: Value(periodeReward),
            diperbaruiPada: sekarang ?? DateTime.now(),
          ),
        );
  }

  /// Baris terbaru menang; null = belum pernah dikonfigurasi.
  Future<DanaPlusConfiguration?> konfigurasiAktif() {
    return (_db.select(_db.danaPlusConfigurations)
          ..orderBy([(t) => OrderingTerm.desc(t.id)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Catat ledger periode (§94); saldo akhir dihitung DanaLedgerService.
  Future<int> catatLedger({
    required int tahun,
    required int bulan,
    required int saldoAwalBiasa,
    required int saldoAwalPlus,
    required int topUpKeBiasa,
    required int pindahKePlus,
    required int pindahDariPlus,
    required int pengeluaranBiasa,
    required int pengeluaranPlus,
    required int rewardAktual,
    DateTime? sekarang,
  }) {
    final hasil = const DanaLedgerService().hitung(
      saldoAwalBiasa: saldoAwalBiasa,
      saldoAwalPlus: saldoAwalPlus,
      topUpKeBiasa: topUpKeBiasa,
      pindahKePlus: pindahKePlus,
      pindahDariPlus: pindahDariPlus,
      pengeluaranBiasa: pengeluaranBiasa,
      pengeluaranPlus: pengeluaranPlus,
      rewardAktual: rewardAktual,
    );
    return _db.into(_db.danaBalanceLedgers).insert(
          DanaBalanceLedgersCompanion.insert(
            tahun: tahun,
            bulan: bulan,
            saldoAwalBiasa: saldoAwalBiasa,
            saldoAwalPlus: saldoAwalPlus,
            topUpKeBiasa: topUpKeBiasa,
            pindahKePlus: pindahKePlus,
            pindahDariPlus: pindahDariPlus,
            pengeluaranBiasa: pengeluaranBiasa,
            pengeluaranPlus: pengeluaranPlus,
            rewardAktual: rewardAktual,
            saldoAkhirBiasa: hasil.saldoAkhirBiasa,
            saldoAkhirPlus: hasil.saldoAkhirPlus,
            dibuatPada: sekarang ?? DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<DanaBalanceLedger?> ledgerPeriode(int tahun, int bulan) {
    return (_db.select(_db.danaBalanceLedgers)
          ..where((t) => t.tahun.equals(tahun) & t.bulan.equals(bulan)))
        .getSingleOrNull();
  }

  Future<List<DanaBalanceLedger>> semuaLedger() {
    return (_db.select(_db.danaBalanceLedgers)
          ..orderBy([
            (t) => OrderingTerm.desc(t.tahun),
            (t) => OrderingTerm.desc(t.bulan),
          ]))
        .get();
  }
}
