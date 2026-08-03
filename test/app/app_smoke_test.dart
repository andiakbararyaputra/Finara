import 'package:drift/native.dart';
import 'package:finara/app/app.dart';
import 'package:finara/app/providers.dart';
import 'package:finara/data/db/app_database.dart';
import 'package:finara/data/repositories/settings_repository.dart';
import 'package:finara/data/services/pin_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Secure storage in-memory untuk test (plugin asli tak tersedia).
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

  Future<(AppDatabase, PinManager)> pumpApp(
    WidgetTester tester, {
    bool onboardingSelesai = true,
    PinManager? pinManager,
  }) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final pin = pinManager ?? PinManager(storage: FakeSecureStorage());
    if (onboardingSelesai) {
      await SettingsRepository(db)
          .tulis(SettingKeys.onboardingSelesai, 'true');
    }
    await tester.pumpWidget(ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        pinManagerProvider.overrideWithValue(pin),
      ],
      child: const FinaraApp(),
    ));
    await tester.pumpAndSettle();
    return (db, pin);
  }

  testWidgets('pengguna baru diarahkan ke onboarding 4 halaman dengan AI',
      (tester) async {
    await pumpApp(tester, onboardingSelesai: false);

    expect(find.text('Atur penghasilan dengan lebih terarah'), findsOneWidget);

    await tester.tap(find.text('Berikutnya'));
    await tester.pumpAndSettle();
    expect(find.text('Bangun dana darurat'), findsOneWidget);

    await tester.tap(find.text('Berikutnya'));
    await tester.pumpAndSettle();
    expect(find.text('Dapatkan bantuan dari AI'), findsOneWidget);

    await tester.tap(find.text('Berikutnya'));
    await tester.pumpAndSettle();
    expect(find.text('Data tetap dalam kendali Anda'), findsOneWidget);

    await tester.tap(find.text('Mulai Gunakan Finara'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada alokasi bulan ini'), findsOneWidget);
  });

  testWidgets('menampilkan 5 menu navigasi Fase 2 termasuk Finara AI',
      (tester) async {
    await pumpApp(tester);

    expect(find.text('Beranda'), findsWidgets);
    expect(find.text('Hitung'), findsWidgets);
    expect(find.text('Finara AI'), findsWidgets);
    expect(find.text('Progres'), findsWidgets);
    expect(find.text('Riwayat'), findsWidgets);
  });

  testWidgets('beranda menampilkan empty state dan tombol Hitung Alokasi',
      (tester) async {
    await pumpApp(tester);

    expect(find.text('Finara'), findsWidgets);
    expect(find.text('Belum ada alokasi bulan ini'), findsOneWidget);
    expect(find.text('Hitung Alokasi'), findsOneWidget);
  });

  testWidgets('navigasi bawah berpindah antarhalaman', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Riwayat'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada riwayat'), findsOneWidget);

    await tester.tap(find.text('Progres'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada data progres'), findsOneWidget);
  });

  testWidgets('pengaturan tema mengganti mode gelap dan tersimpan',
      (tester) async {
    final (db, _) = await pumpApp(tester);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Tema'), findsOneWidget);

    await tester.tap(find.text('Gelap'));
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);
    expect(await SettingsRepository(db).baca(SettingKeys.temaMode), 'dark');
  });

  testWidgets('alur hitung end-to-end: input → hasil → simpan → riwayat',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Hitung Alokasi'));
    await tester.pumpAndSettle();

    // Langkah 1: penghasilan utama.
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Penghasilan Utama'), '10000000');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();

    // Langkah 2: tanpa pengeluaran wajib.
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();

    // Langkah 3: preset Standard Hybrid sudah aktif; hitung.
    expect(find.text('Standard Hybrid'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Hitung'));
    await tester.pumpAndSettle();

    // Hasil: 4 card + selisih Rp0.
    expect(find.textContaining('Hasil Alokasi'), findsOneWidget);
    expect(find.text('BRImo'), findsOneWidget);
    expect(find.text('Selisih Belum Dialokasikan'), findsOneWidget);
    expect(find.text('Rp0'), findsWidgets);

    // Simpan → detail riwayat: header dulu (atas), lalu scroll ke checklist.
    await tester.tap(find.text('Simpan ke Riwayat'));
    await tester.pumpAndSettle();
    expect(find.text('Revisi 1'), findsOneWidget);
    expect(find.text('Draf'), findsOneWidget);
    // Perbandingan bulan sebelumnya: tidak ada data (§22).
    await tester.scrollUntilVisible(
        find.text('Dibanding bulan sebelumnya'), 300);
    await tester.pumpAndSettle();
    expect(find.text('Tidak ada data bulan sebelumnya'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Checklist Transfer'), 300);
    await tester.pumpAndSettle();
    expect(find.text('Checklist Transfer'), findsOneWidget);

    // Kembali ke atas (ListView lazy: header harus dibangun ulang).
    await tester.drag(
        find.byType(Scrollable).first, const Offset(0, 1200));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Konfirmasi Alokasi'));
    await tester.pumpAndSettle();
    expect(find.text('Dikonfirmasi'), findsOneWidget);

    // Beranda kini menampilkan data.
    await tester.tap(find.text('Beranda'));
    await tester.pumpAndSettle();
    expect(find.text('Total Pendapatan — Rencana'), findsOneWidget);
    expect(find.text('Rp10.000.000'), findsOneWidget);
  });

  testWidgets('catat pengeluaran menghitung sisa anggaran DANA (§22A)',
      (tester) async {
    await pumpApp(tester);

    // Buat alokasi cepat.
    await tester.tap(find.text('Hitung Alokasi'));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Penghasilan Utama'), '10000000');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Hitung'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan ke Riwayat'));
    await tester.pumpAndSettle();

    // Belum ada realisasi → "Tidak tersedia" (bukan Rp0).
    await tester.scrollUntilVisible(find.text('Sisa Anggaran DANA'), 300);
    await tester.pumpAndSettle();
    expect(find.text('Sisa Anggaran DANA'), findsOneWidget);
    expect(find.text('Tidak tersedia'), findsOneWidget);

    // Catat pengeluaran dari Alokasi DANA.
    await tester.tap(find.text('Catat Pengeluaran'));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.widgetWithText(TextField, 'Nominal'), '50000');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // DANA 30% dari Dana Bersih 9.700.000 = 2.910.000 − 50rb realisasi.
    expect(find.text('Rp2.860.000'), findsOneWidget);
    expect(find.text('Tidak tersedia'), findsNothing);
  });

  testWidgets('kelola langganan: tambah dan tampil di daftar (§15)',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(find.text('Kelola Langganan'),
        find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kelola Langganan'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada langganan'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Nama'), 'Musik');
    await tester.enterText(
        find.widgetWithText(TextField, 'Nominal'), '54000');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Musik'), findsOneWidget);
    expect(find.text('Rp54.000'), findsOneWidget);
  });

  testWidgets('hapus seluruh data mengosongkan riwayat (§51)',
      (tester) async {
    final (db, _) = await pumpApp(tester);
    // Seed satu langganan langsung ke DB.
    await SettingsRepository(db).tulis('dummy', 'x');

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(find.text('Hapus seluruh data'),
        find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hapus seluruh data'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hapus'));
    await tester.pumpAndSettle();

    expect(find.text('Belum ada alokasi bulan ini'), findsOneWidget);
    expect(await SettingsRepository(db).baca('dummy'), isNull);
  });

  testWidgets('PIN aktif: splash menuju kunci, PIN benar membuka (§51)',
      (tester) async {
    final pin = PinManager(storage: FakeSecureStorage());
    await pin.setPin('123456');

    await pumpApp(tester, pinManager: pin);

    expect(find.text('Finara terkunci'), findsOneWidget);

    // PIN salah ditolak.
    await tester.enterText(find.byType(TextField), '000000');
    await tester.tap(find.text('Buka Kunci'));
    await tester.pumpAndSettle();
    expect(find.text('PIN salah'), findsOneWidget);

    // PIN benar membuka ke beranda.
    await tester.enterText(find.byType(TextField), '123456');
    await tester.tap(find.text('Buka Kunci'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada alokasi bulan ini'), findsOneWidget);
  });

  testWidgets('Stockbit dinonaktifkan: Bibit 100%, tanpa item RDN (§106)',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Hitung Alokasi'));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Penghasilan Utama'), '10000000');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();

    // Matikan alokasi Stockbit bulan ini.
    await tester.dragUntilVisible(
        find.text('Alokasikan ke Stockbit bulan ini'),
        find.byType(ListView),
        const Offset(0, -200));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Alokasikan ke Stockbit bulan ini'));
    await tester.pumpAndSettle();
    expect(find.text('Seluruh Total Alokasi Investasi masuk ke Bibit.'),
        findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Hitung'));
    await tester.pumpAndSettle();

    // Hasil: tanpa sub-card Stockbit; Bibit = seluruh investasi (2.910.000).
    await tester.dragUntilVisible(
        find.text('Total Alokasi Investasi — Rencana'),
        find.byType(ListView),
        const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(find.text('Alokasi Stockbit — Rencana'), findsNothing);
    expect(find.text('Rp2.910.000'), findsWidgets);
  });
}
