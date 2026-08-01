import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:finara/data/db/app_database.dart';
import 'package:finara/data/repositories/emergency_fund_repository.dart';
import 'package:finara/data/repositories/settings_repository.dart';
import 'package:finara/data/repositories/subscription_repository.dart';
import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/models/finance_enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  group('SubscriptionRepository', () {
    test('ledger append-only sinkron dengan saldo cadangan (§15)', () async {
      final repo = SubscriptionRepository(db);
      final id = await repo.tambah(
        nama: 'Domain',
        siklus: SubscriptionCycle.tahunan,
        nominal: 1000000,
        bulanTagihan: 12,
      );

      await repo.catatLedger(
        subscriptionId: id,
        tahun: 2026,
        bulan: 1,
        saldoAwal: 0,
        kontribusi: 83333,
        pembayaran: 0,
      );
      await repo.catatLedger(
        subscriptionId: id,
        tahun: 2026,
        bulan: 2,
        saldoAwal: 83333,
        kontribusi: 83333,
        pembayaran: 0,
      );

      final ledger = await repo.ledger(id);
      expect(ledger, hasLength(2));
      expect(ledger.last.saldoAkhir, 166666);
      final sub = (await repo.semua()).single;
      expect(sub.saldoCadangan, 166666);
    });

    test('periode duplikat ditolak oleh constraint unik', () async {
      final repo = SubscriptionRepository(db);
      final id = await repo.tambah(
        nama: 'X',
        siklus: SubscriptionCycle.bulanan,
        nominal: 50000,
      );
      await repo.catatLedger(
          subscriptionId: id,
          tahun: 2026,
          bulan: 3,
          saldoAwal: 0,
          kontribusi: 50000,
          pembayaran: 0);
      expect(
        () => repo.catatLedger(
            subscriptionId: id,
            tahun: 2026,
            bulan: 3,
            saldoAwal: 50000,
            kontribusi: 50000,
            pembayaran: 0),
        throwsA(anything),
      );
    });

    test('hapus langganan ikut menghapus ledger-nya', () async {
      final repo = SubscriptionRepository(db);
      final id = await repo.tambah(
          nama: 'Y', siklus: SubscriptionCycle.bulanan, nominal: 10000);
      await repo.catatLedger(
          subscriptionId: id,
          tahun: 2026,
          bulan: 1,
          saldoAwal: 0,
          kontribusi: 10000,
          pembayaran: 0);
      await repo.hapus(id);
      expect(await repo.semua(), isEmpty);
      expect(await repo.ledger(id), isEmpty);
    });

    test('perbarui sebagian field via companion', () async {
      final repo = SubscriptionRepository(db);
      final id = await repo.tambah(
          nama: 'Z', siklus: SubscriptionCycle.bulanan, nominal: 25000);
      await repo.perbarui(
          id, const SubscriptionsCompanion(aktif: Value(false)));
      final sub = (await repo.semua()).single;
      expect(sub.aktif, isFalse);
      expect(sub.nominal, 25000);
    });
  });

  group('EmergencyFundRepository', () {
    test('target terbaru menang; kontribusi rencana vs aktual terpisah',
        () async {
      final repo = EmergencyFundRepository(db);
      await repo.simpanTarget(targetJumlahBulan: 3, saldoSaatIni: 0);
      final kedua = await repo.simpanTarget(
          targetJumlahBulan: 6, saldoSaatIni: 1000000);

      final aktif = await repo.targetAktif();
      expect(aktif!.id, kedua);
      expect(aktif.targetJumlahBulan, 6);
      expect(aktif.pengeluaranPokokManual, isNull);

      await repo.catatKontribusi(
          tahun: 2026,
          bulan: 8,
          nominal: 500000,
          status: PlanActualStatus.rencana);
      await repo.catatKontribusi(
          tahun: 2026,
          bulan: 8,
          nominal: 450000,
          status: PlanActualStatus.aktual);

      final rencana =
          await repo.kontribusi(status: PlanActualStatus.rencana);
      final aktual = await repo.kontribusi(status: PlanActualStatus.aktual);
      expect(rencana.single.nominal, 500000);
      expect(aktual.single.nominal, 450000);
    });

    test('tabungan lain per periode (§23)', () async {
      final repo = EmergencyFundRepository(db);
      await repo.catatTabunganLain(
          nama: 'Liburan',
          nominal: 200000,
          tahun: 2026,
          bulan: 8,
          status: PlanActualStatus.rencana);
      final daftar = await repo.tabunganLain(2026, 8);
      expect(daftar.single.nama, 'Liburan');
      expect(await repo.tabunganLain(2026, 9), isEmpty);
    });
  });

  group('SettingsRepository', () {
    test('tulis-baca-timpa-hapus', () async {
      final repo = SettingsRepository(db);
      expect(await repo.baca(SettingKeys.temaMode), isNull);
      await repo.tulis(SettingKeys.temaMode, 'dark');
      expect(await repo.baca(SettingKeys.temaMode), 'dark');
      await repo.tulis(SettingKeys.temaMode, 'light');
      expect(await repo.baca(SettingKeys.temaMode), 'light');
      await repo.hapus(SettingKeys.temaMode);
      expect(await repo.baca(SettingKeys.temaMode), isNull);
    });
  });
}
