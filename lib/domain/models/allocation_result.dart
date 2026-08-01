/// Hasil deterministik mesin alokasi. Semua nominal adalah nilai final
/// setelah pembulatan; invarian §53 diverifikasi AllocationValidator.
library;

import '../../core/basis_points.dart';
import 'allocation_input.dart';

class AllocationResult {
  const AllocationResult({
    required this.totalPendapatan,
    required this.kasPeganganBrimo,
    required this.totalPengeluaranWajib,
    required this.danaBersih,
    required this.alokasiJago,
    required this.totalAlokasiInvestasi,
    required this.alokasiDana,
    required this.alokasiBibit,
    required this.alokasiStockbit,
    required this.totalDanaMasukJago,
    required this.selisihBelumDialokasikan,
    required this.subAlokasiJago,
    required this.rencanaLangganan,
    required this.jadwalDana,
    this.rencanaDanaDarurat,
  });

  final int totalPendapatan;
  final int kasPeganganBrimo;
  final int totalPengeluaranWajib;
  final int danaBersih;

  /// Alokasi Bank Jago dari Dana Bersih (residual pembulatan tingkat utama).
  final int alokasiJago;
  final int totalAlokasiInvestasi;
  final int alokasiDana;

  /// Alokasi Bibit (residual pembulatan internal investasi).
  final int alokasiBibit;
  final int alokasiStockbit;

  /// Total Pengeluaran Wajib + Alokasi Bank Jago dari Dana Bersih (§12 Tahap 4).
  final int totalDanaMasukJago;

  /// Wajib Rp0 pada hasil valid (§20).
  final int selisihBelumDialokasikan;

  final JagoSubAllocationResult subAlokasiJago;
  final SubscriptionPlanResult rencanaLangganan;
  final DanaScheduleResult jadwalDana;
  final EmergencyFundPlan? rencanaDanaDarurat;

  /// Persentase efektif (§18): nominal final dibagi basisnya, dalam basis
  /// points dibulatkan ke terdekat. Null jika basis nol.
  static int? persentaseEfektifBp(int nominal, int basis) {
    if (basis == 0) return null;
    return ((nominal * totalBasisPoints) / basis).round();
  }
}

/// Sub-alokasi atas Alokasi Bank Jago dari Dana Bersih (§14) —
/// tidak mencakup Kantong Pengeluaran Wajib.
class JagoSubAllocationResult {
  const JagoSubAllocationResult({
    required this.metode,
    required this.kebutuhanLangganan,
    required this.sisaSetelahLangganan,
    required this.danaDarurat,
    required this.danaOperasional,
  });

  final JagoSubAllocationMethod metode;

  /// Kantong Langganan (metode persentase) atau Kebutuhan Langganan Bulan
  /// Aktif (metode langganan aktual).
  final int kebutuhanLangganan;

  /// Negatif menandakan langganan melebihi alokasi — hasil tidak boleh
  /// disimpan (§14).
  final int sisaSetelahLangganan;
  final int danaDarurat;

  /// Komponen residual sub-alokasi (§18).
  final int danaOperasional;

  int get total => kebutuhanLangganan + danaDarurat + danaOperasional;
}

class SubscriptionPlanResult {
  const SubscriptionPlanResult({
    required this.rencanaPerLangganan,
    required this.totalKontribusiBulanIni,
    required this.totalTagihanJatuhTempo,
    required this.totalKekuranganCadangan,
    required this.kebutuhanKantongLangganan,
  });

  final List<SubscriptionMonthlyPlan> rencanaPerLangganan;
  final int totalKontribusiBulanIni;
  final int totalTagihanJatuhTempo;
  final int totalKekuranganCadangan;

  /// Kebutuhan bulan aktif khusus sumber Kantong Langganan Bank Jago (§14).
  final int kebutuhanKantongLangganan;
}

/// Rencana bulan aktif satu langganan, termasuk ledger cadangan tahunan (§15).
class SubscriptionMonthlyPlan {
  const SubscriptionMonthlyPlan({
    required this.id,
    required this.nama,
    required this.sumberAnggaran,
    required this.kontribusiBulanIni,
    required this.tagihanJatuhTempoBulanIni,
    required this.saldoCadanganAwal,
    required this.pembayaranDariCadangan,
    required this.saldoCadanganAkhir,
    required this.kekuranganCadangan,
  });

  final String id;
  final String nama;
  final SubscriptionFundingSource sumberAnggaran;
  final int kontribusiBulanIni;
  final int tagihanJatuhTempoBulanIni;
  final int saldoCadanganAwal;
  final int pembayaranDariCadangan;
  final int saldoCadanganAkhir;

  /// Kebutuhan yang harus diselesaikan pengguna; tidak disembunyikan (§15).
  final int kekuranganCadangan;
}

/// Target dana darurat (§16).
class EmergencyFundPlan {
  const EmergencyFundPlan({
    required this.pengeluaranPokok,
    required this.pengeluaranPokokDariManual,
    required this.targetJumlahBulan,
    required this.targetNominal,
    required this.saldoSaatIni,
    required this.kekurangan,
    required this.kontribusiBulanIni,
    this.estimasiBulanTercapai,
  });

  final int pengeluaranPokok;
  final bool pengeluaranPokokDariManual;
  final int targetJumlahBulan;
  final int targetNominal;
  final int saldoSaatIni;
  final int kekurangan;
  final int kontribusiBulanIni;

  /// Null jika tidak dapat diestimasi (kontribusi nol dan masih kurang).
  final int? estimasiBulanTercapai;

  /// Progres dalam basis points, dibatasi 0–10000. Null jika target nol.
  int? get progresBp {
    if (targetNominal <= 0) return null;
    final bp = (saldoSaatIni * totalBasisPoints) ~/ targetNominal;
    return bp > totalBasisPoints ? totalBasisPoints : bp;
  }
}

/// Jadwal eksekusi Alokasi DANA (§17); sisa integer ke periode terakhir.
class DanaScheduleResult {
  const DanaScheduleResult({
    required this.frekuensi,
    required this.totalAlokasiDana,
    required this.uangJajanHarianDasar,
    required this.anggaranTujuhHari,
    required this.jadwalTopUp,
  });

  final DanaTopUpFrequency frekuensi;
  final int totalAlokasiDana;
  final int uangJajanHarianDasar;
  final int anggaranTujuhHari;
  final List<DanaTopUpEntry> jadwalTopUp;
}

class DanaTopUpEntry {
  const DanaTopUpEntry({required this.tanggal, required this.nominal});

  final DateTime tanggal;
  final int nominal;
}
