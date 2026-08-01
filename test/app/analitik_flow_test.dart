import 'package:drift/native.dart';
import 'package:finara/app/app.dart';
import 'package:finara/app/providers.dart';
import 'package:finara/data/db/app_database.dart';
import 'package:finara/data/repositories/allocation_repository.dart';
import 'package:finara/data/repositories/emergency_fund_repository.dart';
import 'package:finara/data/repositories/settings_repository.dart';
import 'package:finara/data/services/pin_manager.dart';
import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/services/allocation_engine.dart';
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

    // Seed alokasi bulan aktif + target dana darurat.
    final kini = DateTime.now();
    final input = AllocationInput(
      tahun: kini.year,
      bulan: kini.month,
      penghasilanUtama: 10000000,
      pengeluaranWajib: const [
        MandatoryExpenseInput(nama: 'Kos', nominal: 3000000),
        MandatoryExpenseInput(nama: 'Cicilan motor', nominal: 500000),
      ],
      jagoBp: 4000,
      investasiBp: 3000,
      danaBp: 3000,
      bibitBp: 7000,
      stockbitBp: 3000,
    );
    await AllocationRepository(db).simpanRevisi(
        input: input, hasil: const AllocationEngine().hitung(input));
    await EmergencyFundRepository(db).simpanTarget(
      targetJumlahBulan: 6,
      pengeluaranPokokManual: 3000000,
      saldoSaatIni: 9000000, // 50% dari target 18 jt
    );

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

  testWidgets('Progres menampilkan Financial Health Score dgn data parsial',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Progres'));
    await tester.pumpAndSettle();

    expect(find.text('Financial Health Score'), findsOneWidget);
    // darurat 50% → 18/30; wajib 35% → 20/20; cicilan 5% → 15/15;
    // uang jajan 1.860.000/10jt = 18,6% → 10/10; checklist 0 → 0/10;
    // investasi tidak tersedia. Total 63 dari 85 → skor 74.
    expect(find.text('74'), findsOneWidget);
    expect(find.textContaining('Cukup sehat'), findsOneWidget);
    expect(find.text('Kelengkapan data 85%'), findsOneWidget);
    // Komponen investasi tidak diberi nol, ditandai tidak tersedia.
    expect(find.text('Konsistensi investasi'), findsOneWidget);
    expect(find.text('Tidak tersedia'), findsWidgets);

    // Savings Rate rencana tampil (darurat 50% dr jago + investasi).
    await tester.scrollUntilVisible(
        find.text('Savings Rate — Rencana'), 300);
    await tester.pumpAndSettle();
    expect(find.text('Savings Rate — Rencana'), findsOneWidget);
  });

  testWidgets('Simulasi Bagaimana Jika memuat baseline dan tidak mengubah data',
      (tester) async {
    final db = await pumpApp(tester);

    await tester.tap(find.text('Progres'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.science_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Bagaimana Jika'), findsOneWidget);
    expect(find.text('Dimuat dari alokasi bulan aktif'), findsOneWidget);
    await tester.dragUntilVisible(find.text('Sebelum → Sesudah'),
        find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(find.text('Sebelum → Sesudah'), findsOneWidget);

    // Geser slider investasi tidak menambah revisi di DB (§25 sandbox).
    final sebelum =
        await db.select(db.monthlyAllocationRevisions).get();
    await tester.drag(find.byType(Slider).at(1), const Offset(60, 0));
    await tester.pumpAndSettle();
    final sesudah =
        await db.select(db.monthlyAllocationRevisions).get();
    expect(sesudah.length, sebelum.length);
  });
}
