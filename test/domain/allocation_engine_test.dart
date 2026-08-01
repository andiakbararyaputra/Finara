import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/models/allocation_preset.dart';
import 'package:finara/domain/models/allocation_result.dart';
import 'package:finara/domain/models/allocation_violation.dart';
import 'package:finara/domain/services/allocation_engine.dart';
import 'package:finara/domain/services/allocation_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const engine = AllocationEngine();
  const validator = AllocationValidator();

  AllocationInput inputDasar({
    int penghasilanUtama = 10000000,
    List<IncomeSourceInput> tambahan = const [],
    int kas = 300000,
    List<MandatoryExpenseInput> wajib = const [
      MandatoryExpenseInput(nama: 'Kos', nominal: 1500000),
    ],
    int jagoBp = 4000,
    int investasiBp = 3000,
    int danaBp = 3000,
    int bibitBp = 7000,
    int stockbitBp = 3000,
    RoundingOption pembulatan = RoundingOption.tanpa,
    JagoSubAllocationMethod metodeSubJago =
        JagoSubAllocationMethod.persentaseTetap,
    List<SubscriptionInput> langganan = const [],
  }) {
    return AllocationInput(
      tahun: 2026,
      bulan: 8,
      penghasilanUtama: penghasilanUtama,
      penghasilanTambahan: tambahan,
      kasPeganganBrimo: kas,
      pengeluaranWajib: wajib,
      jagoBp: jagoBp,
      investasiBp: investasiBp,
      danaBp: danaBp,
      bibitBp: bibitBp,
      stockbitBp: stockbitBp,
      pembulatan: pembulatan,
      metodeSubJago: metodeSubJago,
      langganan: langganan,
    );
  }

  group('Tahap 0-1: Total Pendapatan dan Dana Bersih', () {
    test('penghasilan tambahan hanya masuk jika disertakan bulan aktif', () {
      final hasil = engine.hitung(inputDasar(tambahan: const [
        IncomeSourceInput(
            nama: 'Bonus', nominal: 2000000, disertakanBulanAktif: true),
        IncomeSourceInput(nama: 'Freelance', nominal: 999999),
      ]));
      expect(hasil.totalPendapatan, 12000000);
    });

    test('pengeluaran wajib dikurangi sebelum pembagian persentase', () {
      final hasil = engine.hitung(inputDasar());
      expect(hasil.danaBersih, 10000000 - 300000 - 1500000);
      // 40% dari Dana Bersih, bukan dari Total Pendapatan.
      expect(hasil.alokasiJago, (8200000 * 4000) ~/ 10000);
    });

    test('Total Dana Masuk Jago = wajib + alokasi Jago', () {
      final hasil = engine.hitung(inputDasar());
      expect(hasil.totalDanaMasukJago,
          hasil.totalPengeluaranWajib + hasil.alokasiJago);
    });
  });

  group('Preset (§13)', () {
    test('semua preset valid 100% di kedua tingkat', () {
      for (final p in AllocationPreset.values) {
        expect(p.jagoBp + p.investasiBp + p.danaBp, 10000, reason: p.name);
        expect(p.bibitBp + p.stockbitBp, 10000, reason: p.name);
      }
    });

    test('Standard Hybrid membagi 40/30/30 dan 70/30', () {
      final hasil = engine.hitung(inputDasar());
      expect(hasil.totalAlokasiInvestasi, (8200000 * 3000) ~/ 10000);
      expect(hasil.alokasiStockbit,
          (hasil.totalAlokasiInvestasi * 3000) ~/ 10000);
      expect(hasil.alokasiBibit,
          hasil.totalAlokasiInvestasi - hasil.alokasiStockbit);
    });
  });

  group('Pembagian internal investasi (§12 Tahap 3)', () {
    test('Stockbit nonaktif: Bibit 100%, Stockbit 0', () {
      final hasil =
          engine.hitung(inputDasar(bibitBp: 10000, stockbitBp: 0));
      expect(hasil.alokasiStockbit, 0);
      expect(hasil.alokasiBibit, hasil.totalAlokasiInvestasi);
    });

    test('Bibit nonaktif: Stockbit 100%', () {
      final hasil =
          engine.hitung(inputDasar(bibitBp: 0, stockbitBp: 10000));
      expect(hasil.alokasiBibit, 0);
      expect(hasil.alokasiStockbit, hasil.totalAlokasiInvestasi);
    });

    test('investasi 0%: Bibit dan Stockbit nol', () {
      final hasil = engine.hitung(inputDasar(
          jagoBp: 7000, investasiBp: 0, danaBp: 3000));
      expect(hasil.totalAlokasiInvestasi, 0);
      expect(hasil.alokasiBibit, 0);
      expect(hasil.alokasiStockbit, 0);
    });
  });

  group('Pembulatan floor + residual (§18)', () {
    test('kelipatan 10rb: Investasi & DANA floor, Jago residual', () {
      final hasil = engine.hitung(inputDasar(
        penghasilanUtama: 10001234,
        pembulatan: RoundingOption.sepuluhRibu,
      ));
      expect(hasil.totalAlokasiInvestasi % 10000, 0);
      expect(hasil.alokasiDana % 10000, 0);
      expect(
          hasil.alokasiJago,
          hasil.danaBersih -
              hasil.totalAlokasiInvestasi -
              hasil.alokasiDana);
      expect(validator.validasiHasil(
          inputDasar(
            penghasilanUtama: 10001234,
            pembulatan: RoundingOption.sepuluhRibu,
          ),
          hasil), isEmpty);
    });

    test('internal investasi: Stockbit floor, Bibit residual', () {
      final hasil = engine.hitung(inputDasar(
        penghasilanUtama: 9876543,
        pembulatan: RoundingOption.limaRibu,
      ));
      expect(hasil.alokasiStockbit % 5000, 0);
      expect(hasil.alokasiBibit + hasil.alokasiStockbit,
          hasil.totalAlokasiInvestasi);
    });

    test('persentase efektif dihitung dari nominal final', () {
      expect(AllocationResult.persentaseEfektifBp(3000000, 10000000), 3000);
      expect(AllocationResult.persentaseEfektifBp(1, 0), isNull);
    });
  });

  group('Sub-alokasi Bank Jago (§14)', () {
    test('persentase tetap 10/50/40, operasional residual', () {
      final hasil = engine.hitung(inputDasar());
      final sub = hasil.subAlokasiJago;
      expect(sub.kebutuhanLangganan, (hasil.alokasiJago * 1000) ~/ 10000);
      expect(sub.danaDarurat, (hasil.alokasiJago * 5000) ~/ 10000);
      expect(sub.danaOperasional,
          hasil.alokasiJago - sub.kebutuhanLangganan - sub.danaDarurat);
      expect(sub.total, hasil.alokasiJago);
    });

    test('berdasarkan langganan aktual: rasio sisa 5:4', () {
      final input = inputDasar(
        metodeSubJago: JagoSubAllocationMethod.berdasarkanLangganan,
        langganan: const [
          SubscriptionInput(
            id: 's1',
            nama: 'Streaming',
            siklus: SubscriptionCycle.bulanan,
            nominal: 100000,
          ),
        ],
      );
      final hasil = engine.hitung(input);
      final sub = hasil.subAlokasiJago;
      expect(sub.kebutuhanLangganan, 100000);
      final sisa = hasil.alokasiJago - 100000;
      expect(sub.danaDarurat, (sisa * 5) ~/ 9);
      expect(sub.danaOperasional, sisa - sub.danaDarurat);
      expect(validator.validasiHasil(input, hasil), isEmpty);
    });

    test('langganan melebihi alokasi Jago: hasil diblokir validator', () {
      final input = inputDasar(
        penghasilanUtama: 2000000,
        kas: 0,
        wajib: const [],
        metodeSubJago: JagoSubAllocationMethod.berdasarkanLangganan,
        langganan: const [
          SubscriptionInput(
            id: 's1',
            nama: 'Mahal',
            siklus: SubscriptionCycle.bulanan,
            nominal: 900000,
          ),
        ],
      );
      final hasil = engine.hitung(input);
      expect(hasil.subAlokasiJago.sisaSetelahLangganan, isNegative);
      final pelanggaran = validator.validasiHasil(input, hasil);
      expect(
        pelanggaran.map((p) => p.code),
        contains(
            AllocationViolationCode.kebutuhanLanggananMelebihiAlokasiJago),
      );
    });
  });

  group('Validasi input (§53)', () {
    test('penghasilan utama nol ditolak', () {
      expect(
        () => engine.hitung(inputDasar(penghasilanUtama: 0)),
        throwsStateError,
      );
    });

    test('kas pegangan melebihi pendapatan ditolak', () {
      final v = validator.validasiInput(
          inputDasar(penghasilanUtama: 100000, kas: 200000, wajib: const []));
      expect(v, isNotEmpty);
    });

    test('dana bersih negatif ditolak', () {
      final v = validator.validasiInput(inputDasar(
        penghasilanUtama: 1000000,
        kas: 300000,
        wajib: const [
          MandatoryExpenseInput(nama: 'Kos', nominal: 900000),
        ],
      ));
      expect(v, isNotEmpty);
    });

    test('persentase utama tidak 100% ditolak', () {
      final v = validator
          .validasiInput(inputDasar(jagoBp: 4000, investasiBp: 3000, danaBp: 2000));
      expect(v, isNotEmpty);
    });

    test('persentase internal investasi tidak 100% ditolak saat investasi > 0',
        () {
      final v =
          validator.validasiInput(inputDasar(bibitBp: 7000, stockbitBp: 2000));
      expect(v, isNotEmpty);
    });
  });
}
