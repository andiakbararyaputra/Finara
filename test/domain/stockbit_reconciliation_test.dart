import 'package:finara/domain/services/stockbit_reconciliation_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = StockbitReconciliationService();
  const kontribusi = InvestmentContributionService();

  group('Rekonsiliasi pendanaan Stockbit (§112)', () {
    StockbitReconciliation rekon(int? target, int? deposit,
        {bool verif = true, int? penarikan, int? pembelian}) {
      return service.rekonsiliasi(
        targetKontribusi: target,
        aktual: InvestmentActualInput(
          depositEksternal: deposit,
          penarikan: penarikan,
          pembelianBersih: pembelian,
          terverifikasi: verif,
        ),
      );
    }

    test('lima status sesuai ambang', () {
      expect(rekon(1000000, 700000).status,
          FundingReconciliationStatus.belumTercapai); // 70%
      expect(rekon(1000000, 800000).status,
          FundingReconciliationStatus.mendekatiTarget); // tepat 80%
      expect(rekon(1000000, 1000000).status,
          FundingReconciliationStatus.sesuaiTarget); // 100%
      expect(rekon(1000000, 1100000).status,
          FundingReconciliationStatus.sesuaiTarget); // tepat 110%
      expect(rekon(1000000, 1200000).status,
          FundingReconciliationStatus.melebihiTarget); // 120%
    });

    test('target nol / deposit null → tidak dapat dibandingkan, persen null',
        () {
      expect(rekon(0, 500000).status,
          FundingReconciliationStatus.tidakDapatDibandingkan);
      expect(rekon(1000000, null).status,
          FundingReconciliationStatus.tidakDapatDibandingkan);
      expect(rekon(1000000, null).persentaseRealisasiBp, isNull);
    });

    test('deposit belum terverifikasi tidak dihitung (§112)', () {
      final hasil = rekon(1000000, 900000, verif: false);
      expect(hasil.realisasiPendanaan, isNull);
      expect(hasil.status,
          FundingReconciliationStatus.tidakDapatDibandingkan);
    });

    test('arus bersih = deposit − penarikan; selisih & persen benar', () {
      final hasil =
          rekon(1000000, 900000, penarikan: 100000, pembelian: 600000);
      expect(hasil.arusDanaEksternalBersih, 800000);
      expect(hasil.selisihPendanaan, -100000);
      expect(hasil.persentaseRealisasiBp, 9000);
      // Pembelian dilaporkan terpisah, tidak memengaruhi pendanaan (§113).
      expect(hasil.realisasiPembelian, 600000);
      expect(hasil.realisasiPendanaan, 900000);
    });
  });

  group('Anti double counting (§113) & kontribusi gabungan (§115)', () {
    test('aturan 2: pembelian Stockbit TIDAK ditambah ke kontribusi', () {
      final total = kontribusi.realisasiGabungan(
        bibit: const InvestmentActualInput(
            pembelianBersih: 1500000, terverifikasi: true),
        stockbit: const InvestmentActualInput(
          depositEksternal: 600000,
          pembelianBersih: 550000, // digunakan dari deposit — bukan tambahan
          terverifikasi: true,
        ),
      );
      expect(total, 2100000);
    });

    test('aturan 3–6: penjualan/dividen/penarikan/saldo bukan kontribusi',
        () {
      final total = kontribusi.realisasiGabungan(
        bibit: null,
        stockbit: const InvestmentActualInput(
          depositEksternal: 500000,
          penjualanBersih: 900000,
          dividen: 50000,
          penarikan: 200000,
          saldoRdnAwal: 2000000,
          terverifikasi: true,
        ),
      );
      expect(total, 500000); // hanya deposit eksternal
    });

    test('aturan 7–8: nilai portofolio & modal bukan kontribusi', () {
      final total = kontribusi.realisasiGabungan(
        bibit: const InvestmentActualInput(
          nilaiPortofolio: 50000000,
          modalInvestasi: 40000000,
          terverifikasi: true,
        ),
        stockbit: null,
      );
      expect(total, isNull); // tanpa pembelian Bibit → tidak ada kontribusi
    });

    test('data belum terverifikasi tidak masuk gabungan', () {
      final total = kontribusi.realisasiGabungan(
        bibit: const InvestmentActualInput(pembelianBersih: 1000000),
        stockbit: const InvestmentActualInput(depositEksternal: 500000),
      );
      expect(total, isNull);
    });

    test('satu platform terverifikasi tetap dihitung', () {
      final total = kontribusi.realisasiGabungan(
        bibit: const InvestmentActualInput(
            pembelianBersih: 750000, terverifikasi: true),
        stockbit: const InvestmentActualInput(depositEksternal: 999999),
      );
      expect(total, 750000);
    });
  });
}
