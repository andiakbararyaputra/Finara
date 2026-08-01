import 'package:drift/native.dart';
import 'package:finara/app/app.dart';
import 'package:finara/app/providers.dart';
import 'package:finara/data/db/app_database.dart';
import 'package:finara/data/repositories/allocation_repository.dart';
import 'package:finara/data/repositories/settings_repository.dart';
import 'package:finara/data/services/pin_manager.dart';
import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/models/finance_enums.dart';
import 'package:finara/domain/services/allocation_engine.dart';
import 'package:finara/features/investasi/impor_bibit_page.dart';
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

  final kini = DateTime.now();
  final teksContoh = '''
Bibit — Statement of Account
Periode: 01/${kini.month.toString().padLeft(2, '0')}/${kini.year} - 28/${kini.month.toString().padLeft(2, '0')}/${kini.year}
Total Nilai Investasi Rp12.345.678
Total Modal Investasi Rp10.000.000
Total Pembelian Rp2.910.000
Total Penjualan Rp0
''';

  Future<AppDatabase> pumpApp(WidgetTester tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await SettingsRepository(db).tulis(SettingKeys.onboardingSelesai, 'true');
    final input = AllocationInput(
      tahun: kini.year,
      bulan: kini.month,
      penghasilanUtama: 10000000,
      jagoBp: 4000,
      investasiBp: 3000,
      danaBp: 3000,
      bibitBp: 10000,
      stockbitBp: 0,
    );
    await AllocationRepository(db).simpanRevisi(
        input: input, hasil: const AllocationEngine().hitung(input));

    await tester.pumpWidget(ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        pinManagerProvider
            .overrideWithValue(PinManager(storage: FakeSecureStorage())),
        // Lewati file picker + PDF asli: langsung teks contoh (§65 uji).
        pilihDanEkstrakPdfProvider.overrideWithValue(() async =>
            (teks: teksContoh, nama: 'statement-bibit.pdf', hash: 'hash-1')),
      ],
      child: const FinaraApp(),
    ));
    await tester.pumpAndSettle();
    return db;
  }

  Future<void> keImpor(WidgetTester tester) async {
    await tester.tap(find.text('Progres').last);
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(find.text('Investasi Gabungan'),
        find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.upload_file_outlined));
    await tester.pumpAndSettle();
  }

  testWidgets(
      'impor: pratinjau terisi dari parser lalu konfirmasi menyimpan aktual',
      (tester) async {
    final db = await pumpApp(tester);
    await keImpor(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Pilih PDF'));
    await tester.pumpAndSettle();

    // Pratinjau terisi + confidence tinggi.
    expect(find.text('12.345.678'), findsOneWidget);
    expect(find.text('2.910.000'), findsOneWidget);
    expect(find.text('Terbaca dengan baik'), findsWidgets);

    await tester.dragUntilVisible(find.text('Konfirmasi Impor'),
        find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Konfirmasi Impor'));
    await tester.pumpAndSettle();

    // Tersimpan sebagai aktual Bibit terverifikasi (§72).
    final aktual = await (db.select(db.investmentActuals)
          ..where((t) =>
              t.platform.equalsValue(InvestmentPlatform.bibit)))
        .getSingle();
    expect(aktual.pembelianBersih, 2910000);
    expect(aktual.nilaiPortofolio, 12345678);
    expect(aktual.verifikasi, VerificationStatus.terverifikasi);

    // Dashboard: kontribusi gabungan tampil + status Sesuai target.
    await tester.dragUntilVisible(find.text('Investasi Gabungan'),
        find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(find.text('Rp2.910.000'), findsWidgets);
  });

  testWidgets('impor file yang sama kedua kali terdeteksi duplikat (§73)',
      (tester) async {
    await pumpApp(tester);
    await keImpor(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Pilih PDF'));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(find.text('Konfirmasi Impor'),
        find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Konfirmasi Impor'));
    await tester.pumpAndSettle();

    // Impor ulang file dgn hash sama.
    await keImpor(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Pilih PDF'));
    await tester.pumpAndSettle();
    expect(
        find.text('Laporan atau transaksi serupa sudah pernah diimpor.'),
        findsOneWidget);
    expect(find.text('Konfirmasi Impor'), findsNothing);
  });
}
