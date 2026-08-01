/// Savings Rate (§23): rencana dan aktual dihitung terpisah, tidak pernah
/// dicampur dalam satu angka. Nilai tak tersedia = null.
library;

import '../../core/basis_points.dart';

class SavingsRateService {
  const SavingsRateService();

  /// Savings Rate Rencana dalam basis points; null jika pendapatan nol/null.
  int? rencanaBp({
    required int? totalPendapatan,
    required int kontribusiDanaDaruratRencana,
    required int totalAlokasiInvestasi,
    int tabunganLainRencana = 0,
  }) {
    if (totalPendapatan == null || totalPendapatan <= 0) return null;
    final tabungan = kontribusiDanaDaruratRencana +
        totalAlokasiInvestasi +
        tabunganLainRencana;
    return (tabungan * totalBasisPoints) ~/ totalPendapatan;
  }

  /// Savings Rate Aktual; null jika salah satu data aktual belum tersedia
  /// (§23: jangan simpulkan aktual dari rencana).
  int? aktualBp({
    required int? totalPendapatanAktual,
    required int? kontribusiDanaDaruratAktual,
    required int? realisasiKontribusiBibit,
    required int? realisasiPendanaanStockbit,
    int? tabunganLainAktual,
  }) {
    if (totalPendapatanAktual == null || totalPendapatanAktual <= 0) {
      return null;
    }
    if (kontribusiDanaDaruratAktual == null &&
        realisasiKontribusiBibit == null &&
        realisasiPendanaanStockbit == null &&
        tabunganLainAktual == null) {
      return null;
    }
    final tabungan = (kontribusiDanaDaruratAktual ?? 0) +
        (realisasiKontribusiBibit ?? 0) +
        (realisasiPendanaanStockbit ?? 0) +
        (tabunganLainAktual ?? 0);
    return (tabungan * totalBasisPoints) ~/ totalPendapatanAktual;
  }
}
