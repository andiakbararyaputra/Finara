/// Repository dana darurat (§16) dan Tabungan Lain (§23).
library;

import 'package:drift/drift.dart';

import '../../domain/models/finance_enums.dart';
import '../db/app_database.dart';

class EmergencyFundRepository {
  EmergencyFundRepository(this._db);

  final AppDatabase _db;

  /// Satu target aktif: baris terbaru menang.
  Future<int> simpanTarget({
    required int targetJumlahBulan,
    int? pengeluaranPokokManual,
    int saldoSaatIni = 0,
    DateTime? targetTanggalTercapai,
    DateTime? sekarang,
  }) {
    return _db.into(_db.emergencyFundTargets).insert(
          EmergencyFundTargetsCompanion.insert(
            targetJumlahBulan: targetJumlahBulan,
            pengeluaranPokokManual: Value(pengeluaranPokokManual),
            saldoSaatIni: saldoSaatIni,
            targetTanggalTercapai: Value(targetTanggalTercapai),
            diperbaruiPada: sekarang ?? DateTime.now(),
          ),
        );
  }

  Future<EmergencyFundTarget?> targetAktif() {
    return (_db.select(_db.emergencyFundTargets)
          ..orderBy([(t) => OrderingTerm.desc(t.id)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> perbaruiSaldo(int targetId, int saldoBaru) async {
    await (_db.update(_db.emergencyFundTargets)
          ..where((t) => t.id.equals(targetId)))
        .write(EmergencyFundTargetsCompanion(
      saldoSaatIni: Value(saldoBaru),
      diperbaruiPada: Value(DateTime.now()),
    ));
  }

  Future<int> catatKontribusi({
    required int tahun,
    required int bulan,
    required int nominal,
    required PlanActualStatus status,
    String? catatan,
    DateTime? sekarang,
  }) {
    return _db.into(_db.emergencyFundContributions).insert(
          EmergencyFundContributionsCompanion.insert(
            tahun: tahun,
            bulan: bulan,
            nominal: nominal,
            status: status,
            catatan: Value(catatan),
            dibuatPada: sekarang ?? DateTime.now(),
          ),
        );
  }

  Future<List<EmergencyFundContribution>> kontribusi({
    PlanActualStatus? status,
  }) {
    final q = _db.select(_db.emergencyFundContributions)
      ..orderBy([
        (t) => OrderingTerm.desc(t.tahun),
        (t) => OrderingTerm.desc(t.bulan),
      ]);
    if (status != null) q.where((t) => t.status.equalsValue(status));
    return q.get();
  }

  Future<int> catatTabunganLain({
    required String nama,
    required int nominal,
    required int tahun,
    required int bulan,
    required PlanActualStatus status,
  }) {
    return _db.into(_db.otherSavingsContributions).insert(
          OtherSavingsContributionsCompanion.insert(
            nama: nama,
            nominal: nominal,
            tahun: tahun,
            bulan: bulan,
            status: status,
          ),
        );
  }

  Future<List<OtherSavingsContribution>> tabunganLain(int tahun, int bulan) {
    return (_db.select(_db.otherSavingsContributions)
          ..where((t) => t.tahun.equals(tahun) & t.bulan.equals(bulan)))
        .get();
  }
}
