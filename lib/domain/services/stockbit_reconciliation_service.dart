/// Rekonsiliasi Stockbit (§112) dan pencegahan double counting (§113).
/// Pure Dart. Prinsip: deposit eksternal ke RDN = kontribusi;
/// pembelian saham = penggunaan dana, bukan kontribusi kedua.
library;

import '../../core/basis_points.dart';

/// Status rekonsiliasi pendanaan (§112).
enum FundingReconciliationStatus {
  belumTercapai,
  mendekatiTarget,
  sesuaiTarget,
  melebihiTarget,
  tidakDapatDibandingkan,
}

/// Data aktual satu platform satu periode (§116) — semuanya nullable;
/// nilai tak diketahui TIDAK diubah jadi nol.
class InvestmentActualInput {
  const InvestmentActualInput({
    this.depositEksternal,
    this.penarikan,
    this.pembelianBersih,
    this.penjualanBersih,
    this.saldoRdnAwal,
    this.saldoRdnAkhir,
    this.biaya,
    this.dividen,
    this.nilaiPortofolio,
    this.modalInvestasi,
    this.terverifikasi = false,
  });

  final int? depositEksternal;
  final int? penarikan;
  final int? pembelianBersih;
  final int? penjualanBersih;
  final int? saldoRdnAwal;
  final int? saldoRdnAkhir;
  final int? biaya;
  final int? dividen;
  final int? nilaiPortofolio;
  final int? modalInvestasi;
  final bool terverifikasi;
}

class StockbitReconciliation {
  const StockbitReconciliation({
    required this.status,
    this.realisasiPendanaan,
    this.arusDanaEksternalBersih,
    this.realisasiPembelian,
    this.selisihPendanaan,
    this.persentaseRealisasiBp,
  });

  /// = deposit eksternal terverifikasi; BUKAN pembelian/penjualan/saldo.
  final int? realisasiPendanaan;
  final int? arusDanaEksternalBersih;

  /// Indikator penggunaan dana — tidak dijumlahkan dgn pendanaan (§113).
  final int? realisasiPembelian;
  final int? selisihPendanaan;

  /// Null saat tidak dapat dibandingkan (§112).
  final int? persentaseRealisasiBp;
  final FundingReconciliationStatus status;
}

class StockbitReconciliationService {
  const StockbitReconciliationService();

  StockbitReconciliation rekonsiliasi({
    required int? targetKontribusi,
    required InvestmentActualInput aktual,
  }) {
    // §112: hanya deposit eksternal TERVERIFIKASI yang jadi realisasi.
    final deposit = aktual.terverifikasi ? aktual.depositEksternal : null;
    final arusBersih = (deposit != null && aktual.penarikan != null)
        ? deposit - aktual.penarikan!
        : null;

    if (targetKontribusi == null || targetKontribusi <= 0 || deposit == null) {
      return StockbitReconciliation(
        status: FundingReconciliationStatus.tidakDapatDibandingkan,
        realisasiPendanaan: deposit,
        arusDanaEksternalBersih: arusBersih,
        realisasiPembelian: aktual.pembelianBersih,
      );
    }

    final persen = (deposit * totalBasisPoints) ~/ targetKontribusi;
    final status = switch (persen) {
      < 8000 => FundingReconciliationStatus.belumTercapai,
      < 10000 => FundingReconciliationStatus.mendekatiTarget,
      <= 11000 => FundingReconciliationStatus.sesuaiTarget,
      _ => FundingReconciliationStatus.melebihiTarget,
    };

    return StockbitReconciliation(
      status: status,
      realisasiPendanaan: deposit,
      arusDanaEksternalBersih: arusBersih,
      realisasiPembelian: aktual.pembelianBersih,
      selisihPendanaan: deposit - targetKontribusi,
      persentaseRealisasiBp: persen,
    );
  }
}

/// Agregasi kontribusi investasi lintas platform (§113 aturan 1–11, §115).
class InvestmentContributionService {
  const InvestmentContributionService();

  /// Realisasi Kontribusi Investasi gabungan (§115):
  /// Bibit = pembelian selesai (§72); Stockbit = deposit eksternal (§112).
  /// Pembelian Stockbit TIDAK dijumlahkan (aturan §113 #2) — deposit sudah
  /// dihitung. Penjualan, dividen, saldo awal, nilai portofolio, dan
  /// unrealized G/L bukan kontribusi (aturan #3–#9).
  int? realisasiGabungan({
    required InvestmentActualInput? bibit,
    required InvestmentActualInput? stockbit,
  }) {
    final kontribusiBibit =
        (bibit?.terverifikasi ?? false) ? bibit?.pembelianBersih : null;
    final kontribusiStockbit =
        (stockbit?.terverifikasi ?? false) ? stockbit?.depositEksternal : null;
    if (kontribusiBibit == null && kontribusiStockbit == null) return null;
    return (kontribusiBibit ?? 0) + (kontribusiStockbit ?? 0);
  }
}
