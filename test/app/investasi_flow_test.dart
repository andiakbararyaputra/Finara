import 'package:drift/native.dart';
import 'package:finara/app/app.dart';
import 'package:finara/app/providers.dart';
import 'package:finara/data/db/app_database.dart';
import 'package:finara/data/repositories/allocation_repository.dart';
import 'package:finara/data/repositories/investment_actual_repository.dart';
import 'package:finara/data/repositories/settings_repository.dart';
import 'package:finara/data/services/pin_manager.dart';
import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/models/finance_enums.dart';
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

    final kini = DateTime.now();
    // Investasi 30% dari bersih 9,7 jt = 2.910.000; Stockbit 30% = 873.000.
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

  testWidgets(
      'dashboard investasi gabungan: deposit ≠ pembelian, status rekonsiliasi',
      (tester) async {
    final db = await pumpApp(tester);
    final kini = DateTime.now();
    final repo = InvestmentActualRepository(db);
    // Deposit 873rb (tepat target) + pembelian 800rb (penggunaan dana).
    await repo.simpan(
      platform: InvestmentPlatform.stockbit,
      tahun: kini.year,
      bulan: kini.month,
      depositEksternal: 873000,
      pembelianBersih: 800000,
      verifikasi: VerificationStatus.terverifikasi,
    );
    await repo.simpan(
      platform: InvestmentPlatform.bibit,
      tahun: kini.year,
      bulan: kini.month,
      pembelianBersih: 2037000,
      verifikasi: VerificationStatus.terverifikasi,
    );

    await tester.tap(find.text('Progres'));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(find.text('Investasi Gabungan'),
        find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();

    // Gabungan = pembelian Bibit + deposit Stockbit (TANPA pembelian
    // Stockbit — anti double counting §113).
    expect(find.text('Rp2.910.000'), findsWidgets);
    expect(find.text('Rp873.000'), findsWidgets);
    expect(find.text('Rp800.000'), findsOneWidget);
    expect(find.text('Sesuai target'), findsOneWidget);
  });

  testWidgets('form input aktual menyimpan dan status di dashboard berubah',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Progres'));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(find.text('Investasi Gabungan'),
        find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(find.text('Tidak dapat dibandingkan'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.edit_note_rounded));
    await tester.pumpAndSettle();

    // Isi deposit 500rb (57% target → Belum tercapai) + verifikasi.
    await tester.enterText(
        find.widgetWithText(TextField, 'Deposit eksternal ke RDN'),
        '500000');
    await tester.dragUntilVisible(find.text('Tandai terverifikasi'),
        find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tandai terverifikasi'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Simpan'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(find.text('Investasi Gabungan'),
        find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(find.text('Belum tercapai'), findsOneWidget);
    expect(find.text('Rp500.000'), findsWidgets);
  });
}
