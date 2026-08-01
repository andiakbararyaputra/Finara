import 'package:finara/domain/services/financial_health_score_service.dart';
import 'package:finara/domain/services/savings_rate_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = FinancialHealthScoreService();

  group('FinancialHealthScore — data lengkap (§24)', () {
    test('semua komponen maksimal = 100 Sangat sehat', () {
      final hasil = service.hitung(const HealthScoreInput(
        saldoDanaDarurat: 12000000,
        targetDanaDarurat: 12000000,
        totalPendapatan: 10000000,
        totalPengeluaranWajib: 4000000, // 40% ≤50 → 20
        totalCicilan: 500000, // 5% ≤10 → 15
        bulanInvestasiTercapai: 3,
        bulanInvestasiTersedia: 3, // semua → 15
        uangJajan: 1500000, // 15% ≤20 → 10
        checklistSelesai: 10,
        checklistTotal: 10, // 100% → 10
      ));
      expect(hasil.skor, 100);
      expect(hasil.kategori, HealthScoreCategory.sangatSehat);
      expect(hasil.kelengkapanBp, 10000);
      expect(hasil.versiAmbang, versiAmbangSkor);
    });

    test('ambang batas tepat: dana darurat 75% = 24, wajib 60% = 15', () {
      final hasil = service.hitung(const HealthScoreInput(
        saldoDanaDarurat: 7500000,
        targetDanaDarurat: 10000000,
        totalPendapatan: 10000000,
        totalPengeluaranWajib: 6000000,
        totalCicilan: 2000000, // tepat 20% → 12
        bulanInvestasiTercapai: 2,
        bulanInvestasiTersedia: 3, // 66,67% <67 → 5
        uangJajan: 3000000, // tepat 30% → 7
        checklistSelesai: 3,
        checklistTotal: 4, // 75% → 7
      ));
      final poin = {
        for (final k in hasil.komponen) k.id: k.poin,
      };
      expect(poin[HealthComponentId.danaDarurat], 24);
      expect(poin[HealthComponentId.rasioWajib], 15);
      expect(poin[HealthComponentId.rasioCicilan], 12);
      expect(poin[HealthComponentId.konsistensiInvestasi], 5);
      expect(poin[HealthComponentId.rasioUangJajan], 7);
      expect(poin[HealthComponentId.checklist], 7);
      // 24+15+12+5+7+7 = 70 dari 100.
      expect(hasil.skor, 70);
      expect(hasil.kategori, HealthScoreCategory.cukupSehat);
    });

    test('kondisi buruk semua nol poin → Perlu perhatian', () {
      final hasil = service.hitung(const HealthScoreInput(
        saldoDanaDarurat: 0,
        targetDanaDarurat: 10000000,
        totalPendapatan: 10000000,
        totalPengeluaranWajib: 8000000, // >70%
        totalCicilan: 4000000, // >30%
        bulanInvestasiTercapai: 0,
        bulanInvestasiTersedia: 3,
        uangJajan: 5000000, // >40%
        checklistSelesai: 0,
        checklistTotal: 10,
      ));
      expect(hasil.skor, 0);
      expect(hasil.kategori, HealthScoreCategory.perluPerhatian);
    });
  });

  group('FinancialHealthScore — data parsial (§24)', () {
    test('komponen tanpa data tidak diberi nol; skor dinormalkan', () {
      // Hanya wajib (20) + uang jajan (10) tersedia, keduanya maksimal.
      final hasil = service.hitung(const HealthScoreInput(
        totalPendapatan: 10000000,
        totalPengeluaranWajib: 4000000,
        totalCicilan: null,
        uangJajan: 1000000,
      ));
      final tersedia =
          hasil.komponen.where((k) => k.tersedia).map((k) => k.id).toSet();
      expect(tersedia, {
        HealthComponentId.rasioWajib,
        HealthComponentId.rasioUangJajan,
      });
      // 30 poin dari 30 bobot tersedia → 100, kelengkapan 30%.
      expect(hasil.skor, 100);
      expect(hasil.kelengkapanBp, 3000);
    });

    test('tanpa data sama sekali: skor null, kategori null', () {
      final hasil = service.hitung(const HealthScoreInput());
      expect(hasil.skor, isNull);
      expect(hasil.kategori, isNull);
      expect(hasil.kelengkapanBp, 0);
    });

    test('konsistensi investasi tanpa bulan tersedia = tidak tersedia', () {
      final hasil = service.hitung(const HealthScoreInput(
        bulanInvestasiTercapai: 0,
        bulanInvestasiTersedia: 0,
      ));
      final k = hasil.komponen.singleWhere(
          (k) => k.id == HealthComponentId.konsistensiInvestasi);
      expect(k.tersedia, isFalse);
    });

    test('basis aktual vs rencana ditandai pada uang jajan', () {
      final rencana = service.hitung(const HealthScoreInput(
          totalPendapatan: 1000, uangJajan: 100));
      final aktual = service.hitung(const HealthScoreInput(
          totalPendapatan: 1000, uangJajan: 100, uangJajanAktual: true));
      bool basis(FinancialHealthScore s) => s.komponen
          .singleWhere((k) => k.id == HealthComponentId.rasioUangJajan)
          .basisAktual;
      expect(basis(rencana), isFalse);
      expect(basis(aktual), isTrue);
    });
  });

  group('SavingsRateService (§23)', () {
    const rate = SavingsRateService();

    test('rencana: (darurat + investasi + lain) / pendapatan', () {
      expect(
        rate.rencanaBp(
          totalPendapatan: 10000000,
          kontribusiDanaDaruratRencana: 1000000,
          totalAlokasiInvestasi: 2000000,
          tabunganLainRencana: 500000,
        ),
        3500,
      );
    });

    test('pendapatan nol/null → null, bukan 0', () {
      expect(
        rate.rencanaBp(
            totalPendapatan: null,
            kontribusiDanaDaruratRencana: 1,
            totalAlokasiInvestasi: 1),
        isNull,
      );
      expect(
        rate.rencanaBp(
            totalPendapatan: 0,
            kontribusiDanaDaruratRencana: 1,
            totalAlokasiInvestasi: 1),
        isNull,
      );
    });

    test('aktual: null jika tidak ada satu pun data aktual', () {
      expect(
        rate.aktualBp(
          totalPendapatanAktual: 10000000,
          kontribusiDanaDaruratAktual: null,
          realisasiKontribusiBibit: null,
          realisasiPendanaanStockbit: null,
        ),
        isNull,
      );
    });

    test('aktual terpisah dari rencana; deposit RDN dihitung sekali', () {
      expect(
        rate.aktualBp(
          totalPendapatanAktual: 10000000,
          kontribusiDanaDaruratAktual: 900000,
          realisasiKontribusiBibit: 1500000,
          realisasiPendanaanStockbit: 600000,
        ),
        3000,
      );
    });
  });
}
