import 'package:drift/native.dart';
import 'package:finara/app/app.dart';
import 'package:finara/app/providers.dart';
import 'package:finara/data/db/app_database.dart';
import 'package:finara/data/repositories/ai_provider_repository.dart';
import 'package:finara/data/repositories/settings_repository.dart';
import 'package:finara/data/services/api_key_store.dart';
import 'package:finara/data/services/pin_manager.dart';
import 'package:finara/domain/ai/ai_models.dart';
import 'package:finara/domain/ai/mock_ai_adapter.dart';
import 'package:finara/domain/models/ai_enums.dart';
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

  Future<AppDatabase> pumpApp(
    WidgetTester tester, {
    MockAIAdapter? mock,
    bool denganProvider = false,
  }) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await SettingsRepository(db).tulis(SettingKeys.onboardingSelesai, 'true');
    final storage = FakeSecureStorage();

    if (denganProvider) {
      final repo = AIProviderRepository(db);
      final id = await repo.tambahProvider(
        nama: 'Provider Uji',
        baseUrl: 'https://api.uji.test/v1',
        izinData: AIDataScope.bulanAktif,
      );
      await ApiKeyStore(storage: storage).simpan(id, 'sk-test-abcdef');
      await repo.setModelDefault(id, 'mock-mini');
    }

    await tester.pumpWidget(ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        pinManagerProvider
            .overrideWithValue(PinManager(storage: FakeSecureStorage())),
        apiKeyStoreProvider
            .overrideWithValue(ApiKeyStore(storage: storage)),
        if (mock != null)
          aiAdapterFactoryProvider.overrideWithValue((_) => mock),
      ],
      child: const FinaraApp(),
    ));
    await tester.pumpAndSettle();
    return db;
  }

  testWidgets('tab AI tanpa konfigurasi menampilkan ajakan setup',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Finara AI'));
    await tester.pumpAndSettle();

    expect(find.text('Finara AI belum dikonfigurasi'), findsOneWidget);
    expect(find.text('Penyedia dan Model'), findsOneWidget);
  });

  testWidgets('konfigurasi provider: simpan lalu ambil daftar model (§29)',
      (tester) async {
    final mock = MockAIAdapter();
    await pumpApp(tester, mock: mock);

    await tester.tap(find.text('Finara AI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Penyedia dan Model'));
    await tester.pumpAndSettle();

    // Tambah provider via dialog (§38 multi-provider).
    await tester.tap(find.text('Tambah penyedia'));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.widgetWithText(TextField, 'Nama konfigurasi'), 'OpenAI Uji');
    await tester.enterText(find.widgetWithText(TextField, 'Base URL'),
        'https://api.uji.test/v1');
    await tester.enterText(
        find.widgetWithText(TextField, 'API key'), 'sk-test-abcdef');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // Provider tampil di daftar; buka detail.
    expect(find.text('OpenAI Uji'), findsOneWidget);
    await tester.tap(find.text('OpenAI Uji'));
    await tester.pumpAndSettle();

    // API key tersamarkan (§45).
    expect(find.textContaining('••••cdef'), findsOneWidget);
    expect(find.text('sk-test-abcdef'), findsNothing);

    await tester.tap(find.text('Ambil Daftar Model'));
    await tester.pumpAndSettle();
    expect(find.text('2 model ditemukan'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Mock Mini'), 300);
    expect(find.text('Mock Mini'), findsOneWidget);

    // Jadikan default via menu model.
    await tester.tap(find.byType(PopupMenuButton<String>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Jadikan default'));
    await tester.pumpAndSettle();

    // Tes model → status chat Terverifikasi (§35).
    await tester.tap(find.byType(PopupMenuButton<String>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tes Model'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Terverifikasi'), findsWidgets);
  });

  testWidgets('chat streaming dengan MockAIAdapter tersimpan di riwayat',
      (tester) async {
    final mock = MockAIAdapter(jawaban: 'Halo, ini jawaban uji dari mock.');
    await pumpApp(tester, mock: mock, denganProvider: true);

    await tester.tap(find.text('Finara AI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Percakapan Baru'));
    await tester.pumpAndSettle();

    // Suggestion chips tampil pada percakapan kosong (§42).
    expect(find.text('Analisis alokasi bulan ini'), findsOneWidget);

    await tester.enterText(
        find.widgetWithText(TextField, 'Tulis pertanyaan…'),
        'Apakah alokasi saya sehat?');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    expect(find.textContaining('Halo, ini jawaban uji'), findsOneWidget);
    expect(mock.requestLog, hasLength(1));
    // System prompt §46 ikut terkirim.
    expect(mock.requestLog.single.messages.first.content,
        contains('Anda adalah Finara AI'));

    // Kembali: percakapan tersimpan dengan judul dari pesan pertama.
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Apakah alokasi saya sehat?'), findsOneWidget);
  });

  testWidgets('error provider dipetakan ke pesan Indonesia (§48)',
      (tester) async {
    final mock = MockAIAdapter(errorKind: AIErrorKind.rateLimit);
    await pumpApp(tester, mock: mock, denganProvider: true);

    await tester.tap(find.text('Finara AI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Percakapan Baru'));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.widgetWithText(TextField, 'Tulis pertanyaan…'), 'Halo');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Terlalu banyak permintaan — coba lagi nanti'),
        findsOneWidget);
  });

  testWidgets('satu klik hentikan langsung menghentikan streaming',
      (tester) async {
    // Jeda antarchunk lama agar stop teruji di tengah streaming.
    final mock = MockAIAdapter(
      jawaban: 'satu dua tiga empat lima enam tujuh delapan',
      jedaChunk: const Duration(milliseconds: 200),
    );
    await pumpApp(tester, mock: mock, denganProvider: true);

    await tester.tap(find.text('Finara AI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Percakapan Baru'));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.widgetWithText(TextField, 'Tulis pertanyaan…'), 'Halo');
    await tester.tap(find.byIcon(Icons.send_rounded));

    // Biarkan 2 chunk tiba, lalu hentikan SEKALI.
    await tester.pump(const Duration(milliseconds: 450));
    expect(find.byIcon(Icons.stop_rounded), findsOneWidget);
    await tester.tap(find.byIcon(Icons.stop_rounded));
    await tester.pump();

    // Tanpa klik kedua: tombol kirim kembali seketika.
    expect(find.byIcon(Icons.stop_rounded), findsNothing);
    expect(find.byIcon(Icons.send_rounded), findsOneWidget);

    await tester.pumpAndSettle();
    // Jawaban parsial tersimpan (bukan jawaban penuh).
    expect(find.textContaining('satu'), findsOneWidget);
    expect(find.textContaining('delapan'), findsNothing);
  });

  testWidgets('regenerasi §42: jawaban lama diganti jawaban baru',
      (tester) async {
    final mock = MockAIAdapter(jawaban: 'Jawaban pertama dari mock.');
    await pumpApp(tester, mock: mock, denganProvider: true);

    await tester.tap(find.text('Finara AI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Percakapan Baru'));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.widgetWithText(TextField, 'Tulis pertanyaan…'), 'Halo');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();
    expect(find.textContaining('Jawaban pertama'), findsOneWidget);

    mock.jawaban = 'Jawaban kedua setelah regenerasi.';
    await tester.tap(find.text('Regenerasi'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Jawaban kedua'), findsOneWidget);
    expect(find.textContaining('Jawaban pertama'), findsNothing);
    // Pesan user tidak terduplikasi.
    expect(mock.requestLog.last.messages.where((m) => m.role == AIRole.user),
        hasLength(1));
  });

  testWidgets('ganti model §33: percakapan memakai model baru',
      (tester) async {
    final mock = MockAIAdapter(jawaban: 'Oke.');
    final db = await pumpApp(tester, mock: mock, denganProvider: true);

    // Daftarkan model kedua agar picker punya pilihan.
    final provider =
        (await AIProviderRepository(db).semuaProvider()).single;
    await AIProviderRepository(db).tambahModelManual(
        providerId: provider.id, modelId: 'mock-besar');

    await tester.tap(find.text('Finara AI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Percakapan Baru'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.swap_horiz_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('mock-besar'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Model percakapan diganti'), findsOneWidget);
    // Tunggu snackbar hilang agar tidak menutupi tombol kirim.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.widgetWithText(TextField, 'Tulis pertanyaan…'), 'Halo');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();
    expect(mock.requestLog.last.model, 'mock-besar');
  });

  testWidgets('fallback nonaktif §37: error langsung tampil tanpa beralih',
      (tester) async {
    final mock = MockAIAdapter(errorKind: AIErrorKind.rateLimit);
    final db = await pumpApp(tester, mock: mock, denganProvider: true);
    final repo = AIProviderRepository(db);
    final provider = (await repo.semuaProvider()).single;
    await repo.tambahModelManual(
        providerId: provider.id, modelId: 'mock-cadangan');
    await repo.setFallback(provider.id,
        model1: 'mock-cadangan', model2: null);
    await repo.setFallbackMode(provider.id, FallbackMode.nonaktif);

    await tester.tap(find.text('Finara AI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Percakapan Baru'));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.widgetWithText(TextField, 'Tulis pertanyaan…'), 'Halo');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Terlalu banyak permintaan — coba lagi nanti'),
        findsOneWidget);
    // Tidak ada percobaan ke model cadangan.
    expect(mock.requestLog.every((r) => r.model != 'mock-cadangan'), isTrue);
  });

  testWidgets('fallback konfirmasi §37: dialog tampilkan model & provider',
      (tester) async {
    final mock = MockAIAdapter(errorKind: AIErrorKind.rateLimit);
    final db = await pumpApp(tester, mock: mock, denganProvider: true);
    final repo = AIProviderRepository(db);
    final provider = (await repo.semuaProvider()).single;
    await repo.tambahModelManual(
        providerId: provider.id, modelId: 'mock-cadangan');
    await repo.setFallback(provider.id,
        model1: 'mock-cadangan', model2: null);
    await repo.setFallbackMode(provider.id, FallbackMode.konfirmasi);

    await tester.tap(find.text('Finara AI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Percakapan Baru'));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.widgetWithText(TextField, 'Tulis pertanyaan…'), 'Halo');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    // Dialog §37: provider & model tujuan disebutkan.
    expect(find.text('Gunakan model cadangan?'), findsOneWidget);
    expect(find.textContaining('mock-cadangan'), findsOneWidget);
    expect(find.textContaining('Provider Uji'), findsOneWidget);

    // Batal → error asli ditampilkan.
    await tester.tap(find.widgetWithText(TextButton, 'Batal'));
    await tester.pumpAndSettle();
    expect(find.text('Terlalu banyak permintaan — coba lagi nanti'),
        findsOneWidget);
  });
}
