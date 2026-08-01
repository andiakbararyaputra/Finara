/// Repository langganan (§15): CRUD + ledger cadangan tahunan append-only.
library;

import 'package:drift/drift.dart';

import '../../domain/models/allocation_input.dart';
import '../db/app_database.dart';

class SubscriptionRepository {
  SubscriptionRepository(this._db);

  final AppDatabase _db;

  Future<int> tambah({
    required String nama,
    required SubscriptionCycle siklus,
    required int nominal,
    int bulanTagihan = 1,
    int? tanggalTagihan,
    AnnualFundingMethod metodeTahunan = AnnualFundingMethod.cadanganBulanan,
    SubscriptionFundingSource sumberAnggaran =
        SubscriptionFundingSource.kantongLanggananJago,
    int saldoCadangan = 0,
    bool aktif = true,
    bool pengingatAktif = false,
  }) {
    return _db.into(_db.subscriptions).insert(
          SubscriptionsCompanion.insert(
            nama: nama,
            siklus: siklus,
            nominal: nominal,
            bulanTagihan: bulanTagihan,
            tanggalTagihan: Value(tanggalTagihan),
            metodeTahunan: metodeTahunan,
            sumberAnggaran: sumberAnggaran,
            saldoCadangan: saldoCadangan,
            aktif: aktif,
            pengingatAktif: pengingatAktif,
          ),
        );
  }

  Future<List<Subscription>> semua({bool hanyaAktif = false}) {
    final q = _db.select(_db.subscriptions)
      ..orderBy([(t) => OrderingTerm.asc(t.nama)]);
    if (hanyaAktif) q.where((t) => t.aktif.equals(true));
    return q.get();
  }

  Future<void> perbarui(int id, SubscriptionsCompanion perubahan) async {
    await (_db.update(_db.subscriptions)..where((t) => t.id.equals(id)))
        .write(perubahan);
  }

  Future<void> hapus(int id) async {
    await _db.transaction(() async {
      await (_db.delete(_db.subscriptionReserveLedgers)
            ..where((t) => t.subscriptionId.equals(id)))
          .go();
      await (_db.delete(_db.subscriptions)..where((t) => t.id.equals(id)))
          .go();
    });
  }

  /// Catat mutasi cadangan satu periode dan sinkronkan saldo berjalan.
  /// Unik per (langganan, tahun, bulan) — duplikat periode ditolak DB.
  Future<int> catatLedger({
    required int subscriptionId,
    required int tahun,
    required int bulan,
    required int saldoAwal,
    required int kontribusi,
    required int pembayaran,
    DateTime? sekarang,
  }) {
    final saldoAkhir = saldoAwal + kontribusi - pembayaran;
    return _db.transaction(() async {
      final id = await _db.into(_db.subscriptionReserveLedgers).insert(
            SubscriptionReserveLedgersCompanion.insert(
              subscriptionId: subscriptionId,
              tahun: tahun,
              bulan: bulan,
              saldoAwal: saldoAwal,
              kontribusi: kontribusi,
              pembayaran: pembayaran,
              saldoAkhir: saldoAkhir,
              dibuatPada: sekarang ?? DateTime.now(),
            ),
          );
      await (_db.update(_db.subscriptions)
            ..where((t) => t.id.equals(subscriptionId)))
          .write(SubscriptionsCompanion(saldoCadangan: Value(saldoAkhir)));
      return id;
    });
  }

  Future<List<SubscriptionReserveLedger>> ledger(int subscriptionId) {
    return (_db.select(_db.subscriptionReserveLedgers)
          ..where((t) => t.subscriptionId.equals(subscriptionId))
          ..orderBy([
            (t) => OrderingTerm.asc(t.tahun),
            (t) => OrderingTerm.asc(t.bulan),
          ]))
        .get();
  }
}
