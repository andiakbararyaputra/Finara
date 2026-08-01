import 'package:finara/domain/ai/ai_models.dart';
import 'package:finara/domain/ai/model_policy.dart';
import 'package:finara/domain/models/ai_enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const allowed = AllowedModelsService();
  const fallback = FallbackService();
  const cost = CostEstimator();

  group('AllowedModelsService (§34)', () {
    test('aturan 1: model diblokir selalu ditolak di semua mode', () {
      const m = ModelPolicyInfo(
          modelId: 'x', diblokir: true, favorit: true, diizinkan: true);
      for (final mode in AllowedModelsMode.values) {
        expect(allowed.bolehDipakai(mode, m), isFalse, reason: mode.name);
      }
    });

    test('aturan 2: mode hanyaTertentu butuh allowlist', () {
      const masuk = ModelPolicyInfo(modelId: 'a', diizinkan: true);
      const tidak = ModelPolicyInfo(modelId: 'b');
      expect(
          allowed.bolehDipakai(AllowedModelsMode.hanyaTertentu, masuk), isTrue);
      expect(allowed.bolehDipakai(AllowedModelsMode.hanyaTertentu, tidak),
          isFalse);
    });

    test('aturan 3: mode hanyaFavorit butuh favorit dan tidak diblokir', () {
      const fav = ModelPolicyInfo(modelId: 'a', favorit: true);
      const bukan = ModelPolicyInfo(modelId: 'b');
      expect(
          allowed.bolehDipakai(AllowedModelsMode.hanyaFavorit, fav), isTrue);
      expect(allowed.bolehDipakai(AllowedModelsMode.hanyaFavorit, bukan),
          isFalse);
    });

    test('aturan 4: pemilihan otomatis hanya model chat VERIFIED', () {
      const kandidat = [
        ModelPolicyInfo(modelId: 'unknown'),
        ModelPolicyInfo(
            modelId: 'claimed', statusChat: CapabilityStatus.claimed),
        ModelPolicyInfo(
            modelId: 'verified', statusChat: CapabilityStatus.verified),
      ];
      expect(
        allowed.pilihOtomatis(AllowedModelsMode.izinkanSemua, kandidat),
        'verified',
      );
    });

    test('pemilihan otomatis butuh streaming verified saat diminta', () {
      const kandidat = [
        ModelPolicyInfo(
            modelId: 'chat-saja', statusChat: CapabilityStatus.verified),
        ModelPolicyInfo(
            modelId: 'lengkap',
            statusChat: CapabilityStatus.verified,
            statusStreaming: CapabilityStatus.verified),
      ];
      expect(
        allowed.pilihOtomatis(AllowedModelsMode.izinkanSemua, kandidat,
            butuhStreaming: true),
        'lengkap',
      );
    });

    test('pemilihan otomatis null jika tidak ada yang verified (§36)', () {
      const kandidat = [ModelPolicyInfo(modelId: 'unknown')];
      expect(
        allowed.pilihOtomatis(AllowedModelsMode.izinkanSemua, kandidat),
        isNull,
      );
    });
  });

  group('FallbackService (§37)', () {
    const daftar = [
      ModelPolicyInfo(modelId: 'utama'),
      ModelPolicyInfo(modelId: 'cadangan1'),
      ModelPolicyInfo(modelId: 'cadangan2'),
    ];

    test('error layak → cadangan1; cadangan1 gagal → cadangan2', () {
      expect(
        fallback.modelBerikutnya(
          modelGagal: 'utama',
          error: AIErrorKind.rateLimit,
          fallback1: 'cadangan1',
          fallback2: 'cadangan2',
          mode: AllowedModelsMode.izinkanSemua,
          daftarModel: daftar,
        ),
        'cadangan1',
      );
      expect(
        fallback.modelBerikutnya(
          modelGagal: 'cadangan1',
          error: AIErrorKind.modelOverload,
          fallback1: 'cadangan1',
          fallback2: 'cadangan2',
          mode: AllowedModelsMode.izinkanSemua,
          daftarModel: daftar,
        ),
        'cadangan2',
      );
    });

    test('API key ditolak TIDAK memicu fallback (§37)', () {
      expect(
        fallback.modelBerikutnya(
          modelGagal: 'utama',
          error: AIErrorKind.apiKeyDitolak,
          fallback1: 'cadangan1',
          fallback2: 'cadangan2',
          mode: AllowedModelsMode.izinkanSemua,
          daftarModel: daftar,
        ),
        isNull,
      );
    });

    test('cadangan yang diblokir dilewati (§34 tetap berlaku)', () {
      const daftarBlokir = [
        ModelPolicyInfo(modelId: 'cadangan1', diblokir: true),
        ModelPolicyInfo(modelId: 'cadangan2'),
      ];
      expect(
        fallback.modelBerikutnya(
          modelGagal: 'utama',
          error: AIErrorKind.timeout,
          fallback1: 'cadangan1',
          fallback2: 'cadangan2',
          mode: AllowedModelsMode.izinkanSemua,
          daftarModel: daftarBlokir,
        ),
        'cadangan2',
      );
    });

    test('rantai habis → null', () {
      expect(
        fallback.modelBerikutnya(
          modelGagal: 'cadangan2',
          error: AIErrorKind.timeout,
          fallback1: null,
          fallback2: 'cadangan2',
          mode: AllowedModelsMode.izinkanSemua,
          daftarModel: daftar,
        ),
        isNull,
      );
    });
  });

  group('CostEstimator (§39)', () {
    test('estimasi token ~4 karakter, pembulatan ke atas', () {
      expect(cost.estimasiToken(''), 0);
      expect(cost.estimasiToken('abcd'), 1);
      expect(cost.estimasiToken('abcde'), 2);
    });

    test('harga tidak tersedia → null, bukan estimasi palsu', () {
      expect(
        cost.estimasiBiaya(
            tokenInput: 100,
            tokenOutput: 100,
            hargaInputPerJuta: null,
            hargaOutputPerJuta: 5000),
        isNull,
      );
    });

    test('perhitungan biaya per juta token', () {
      // 500rb token input @Rp3.000/jt + 100rb output @Rp15.000/jt
      expect(
        cost.estimasiBiaya(
            tokenInput: 500000,
            tokenOutput: 100000,
            hargaInputPerJuta: 3000,
            hargaOutputPerJuta: 15000),
        3000, // 1500 + 1500
      );
    });
  });
}
