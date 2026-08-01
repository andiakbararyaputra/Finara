import 'package:drift/native.dart';
import 'package:finara/app/app.dart';
import 'package:finara/app/providers.dart';
import 'package:finara/data/db/app_database.dart';
import 'package:finara/data/repositories/allocation_repository.dart';
import 'package:finara/data/repositories/dana_plus_repository.dart';
import 'package:finara/data/repositories/settings_repository.dart';
import 'package:finara/data/services/pin_manager.dart';
import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/services/allocation_engine.dart';
import 'package:finara/domain/services/dana_split_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

class FakeSecureStorage extends Fake implements FlutterSecureStorage {
  final Map<String, String> _data = {};

  @override
  Future<String?> read(
          {required String key,
          AppleOptions? iOptions,
          AndroidOptions? aOptions,
          LinuxOptions? lOptions,
          WebOptions? webOptions,
          AppleOptions? mOptions,
          WindowsOptions? wOptions}) async =>
      _data[key];

  @override
  Future<void> write(
      {required String key,
      required String? value,
      AppleOptions? iOptions,
      AndroidOptions? aOptions,
      LinuxOptions? lOptions,
      WebOptions? webOptions,
      AppleOptions? mOptions,
      WindowsOptions? wOptions}) async {
    if (value == null) {
      _data.remove(key);
    } else {
      _data[key] = value;
    }
  }

  @override
  Future<void> delete(
      {required String key,
      AppleOptions? iOptions,
      AndroidOptions? aOptions,
      LinuxOptions? lOptions,
      WebOptions? webOptions,
      AppleOptions? mOptions,
      WindowsOptions? wOptions}) async {
    _data.remove(key);
  }
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  Future<AppDatabase> pumpApp(WidgetTester tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await SettingsRepository(db).tulis(SettingKeys.onboardingSelesai, 'true');

    final kini = DateTime.now();
    final input = AllocationInput(
      tahun: kini.year,
      bulan: kini.month,
      penghasilanUtama: 10000000,
      jagoBp: 4000,
      investasiBp: 3000,
      danaBp: 3000,
      bibitBp: 7000,
      stockbitBp: 3000,
    );
    await AllocationRepository(db).simpanRevisi(
        input: input, hasil: const AllocationEngine().hitung(input));

    await tester.pumpWidget(ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        pinManagerProvider
            .overrideWithValue(PinManager(storage: FakeSecureStorage())),
      ],
      child: const FinaraApp(),
    ));
    await tester.pumpAndSettle();
    return db;
  }

  testWidgets('konfigurasi DANA+ persentase tampil sebagai pratinjau split',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('DANA dan DANA+'));
    await tester.pumpAndSettle();

    // Default nonaktif: seluruh dana ke Biasa.
    expect(
        find.text(
            'Seluruh dana DANA yang dieksekusi ditempatkan pada Saldo DANA Biasa.'),
        findsOneWidget);

    // Aktifkan DANA+, mode persentase 50/50.
    await tester.tap(find.text('Saya belum menggunakan DANA+'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Saya menggunakan DANA+').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Smart Liquidity (disarankan)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Persentase').last);
    await tester.pumpAndSettle();

    // Pratinjau: DANA bulanan 2.910.000 → 50/50 = 1.455.000.
    await tester.dragUntilVisible(find.text('Saldo DANA Biasa'),
        find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(find.text('Rp1.455.000'), findsNWidgets(2));

    // Simpan konfigurasi.
    await tester.dragUntilVisible(
        find.widgetWithText(FilledButton, 'Simpan'),
        find.byType(ListView),
        const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Simpan'));
    await tester.pumpAndSettle();
  });

  testWidgets('ledger DANA tersimpan dan realisasi = pemindahan ke DANA+',
      (tester) async {
    final db = await pumpApp(tester);
    final repo = DanaPlusRepository(db);
    await repo.simpanKonfigurasi(
      availability: DanaPlusAvailability.menggunakan,
      mode: DanaSplitMode.persentase,
      strategi: DanaExecutionStrategy.sekaligusLaluBagi,
    );

    final kini = DateTime.now();
    await repo.catatLedger(
      tahun: kini.year,
      bulan: kini.month,
      saldoAwalBiasa: 100000,
      saldoAwalPlus: 0,
      topUpKeBiasa: 500000,
      pindahKePlus: 200000,
      pindahDariPlus: 0,
      pengeluaranBiasa: 50000,
      pengeluaranPlus: 0,
      rewardAktual: 1000,
    );

    final ledger = await repo.ledgerPeriode(kini.year, kini.month);
    expect(ledger!.saldoAkhirBiasa, 350000);
    expect(ledger.saldoAkhirPlus, 201000);
    expect(ledger.pindahKePlus, 200000);
  });

  testWidgets('penarikan DANA+ → Biasa: tercatat di ledger, tolak saat '
      'melebihi saldo (§90)', (tester) async {
    final db = await pumpApp(tester);
    final repo = DanaPlusRepository(db);
    await repo.simpanKonfigurasi(
      availability: DanaPlusAvailability.menggunakan,
      mode: DanaSplitMode.persentase,
      strategi: DanaExecutionStrategy.sekaligusLaluBagi,
    );
    final kini = DateTime.now();
    // Saldo DANA+ tercatat 200rb (dari top-up Biasa yang dipindahkan).
    await repo.catatLedger(
      tahun: kini.year,
      bulan: kini.month,
      saldoAwalBiasa: 0,
      saldoAwalPlus: 0,
      topUpKeBiasa: 200000,
      pindahKePlus: 200000,
      pindahDariPlus: 0,
      pengeluaranBiasa: 0,
      pengeluaranPlus: 0,
      rewardAktual: 0,
    );

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('DANA dan DANA+'));
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
        find.text('Pindahkan dari DANA+ ke DANA Biasa'),
        find.byType(ListView),
        const Offset(0, -300));
    await tester.pumpAndSettle();

    // Melebihi saldo → ditolak.
    await tester.enterText(
        find.widgetWithText(TextField, 'Nominal').last, '500000');
    await tester.tap(find.widgetWithText(FilledButton, 'Catat'));
    await tester.pumpAndSettle();
    expect(find.textContaining('melebihi saldo DANA+'), findsOneWidget);

    // Nominal valid → ledger terbarui.
    await tester.enterText(
        find.widgetWithText(TextField, 'Nominal').last, '150000');
    await tester.tap(find.widgetWithText(FilledButton, 'Catat'));
    await tester.pumpAndSettle();

    final ledger = await repo.ledgerPeriode(kini.year, kini.month);
    expect(ledger!.pindahDariPlus, 150000);
    expect(ledger.saldoAkhirPlus, 50000);
    expect(ledger.saldoAkhirBiasa, 150000);
  });
}
