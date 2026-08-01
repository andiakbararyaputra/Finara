/// Input mesin perhitungan alokasi (§10–§17 spesifikasi).
/// Seluruh nominal Rupiah int, persentase basis points (10000 = 100%).
library;

/// Kanal pembayaran (§11) — media eksekusi, bukan sumber anggaran.
enum PaymentChannel { bankJago, dana, tunai, transferBankLain, lainnya }

/// Opsi pembulatan nominal (§18), floor untuk komponen non-residual.
enum RoundingOption {
  tanpa(1),
  seribu(1000),
  limaRibu(5000),
  sepuluhRibu(10000);

  const RoundingOption(this.kelipatan);
  final int kelipatan;

  int floorKe(int nominal) => nominal - (nominal % kelipatan);
}

/// Metode sub-alokasi Bank Jago (§14).
enum JagoSubAllocationMethod { persentaseTetap, berdasarkanLangganan }

/// Siklus tagihan langganan (§15).
enum SubscriptionCycle { bulanan, tahunan }

/// Metode pendanaan langganan tahunan (§15).
enum AnnualFundingMethod { cadanganBulanan, bayarSaatJatuhTempo }

/// Sumber anggaran langganan — satu sumber aktif per periode (§15).
enum SubscriptionFundingSource { kantongPengeluaranWajib, kantongLanggananJago }

/// Frekuensi eksekusi Alokasi DANA (§17).
enum DanaTopUpFrequency { harian, mingguan, sekaligus }

class IncomeSourceInput {
  const IncomeSourceInput({
    required this.nama,
    required this.nominal,
    this.rutin = false,
    this.disertakanBulanAktif = false,
  });

  final String nama;
  final int nominal;
  final bool rutin;
  final bool disertakanBulanAktif;
}

class MandatoryExpenseInput {
  const MandatoryExpenseInput({
    required this.nama,
    required this.nominal,
    this.kanalPembayaran = PaymentChannel.bankJago,
    this.kebutuhanPokok = false,
    this.dihitungDasarDanaDarurat = false,
  });

  final String nama;
  final int nominal;
  final PaymentChannel kanalPembayaran;
  final bool kebutuhanPokok;
  final bool dihitungDasarDanaDarurat;
}

class SubscriptionInput {
  const SubscriptionInput({
    required this.id,
    required this.nama,
    required this.siklus,
    required this.nominal,
    this.bulanTagihan = 1,
    this.metodeTahunan = AnnualFundingMethod.cadanganBulanan,
    this.sumberAnggaran = SubscriptionFundingSource.kantongLanggananJago,
    this.saldoCadanganAwal = 0,
    this.aktif = true,
  });

  final String id;
  final String nama;
  final SubscriptionCycle siklus;

  /// Bulanan: nominal per bulan. Tahunan: biaya tahunan penuh.
  final int nominal;

  /// 1–12; hanya relevan untuk siklus tahunan.
  final int bulanTagihan;
  final AnnualFundingMethod metodeTahunan;
  final SubscriptionFundingSource sumberAnggaran;
  final int saldoCadanganAwal;
  final bool aktif;
}

class EmergencyFundInput {
  const EmergencyFundInput({
    required this.targetJumlahBulan,
    this.saldoSaatIni = 0,
    this.pengeluaranPokokManual,
  });

  final int targetJumlahBulan;
  final int saldoSaatIni;

  /// Koreksi manual; jika null, dihitung dari pengeluaran wajib bertanda
  /// [MandatoryExpenseInput.dihitungDasarDanaDarurat].
  final int? pengeluaranPokokManual;
}

class AllocationInput {
  const AllocationInput({
    required this.tahun,
    required this.bulan,
    required this.penghasilanUtama,
    this.penghasilanTambahan = const [],
    this.kasPeganganBrimo = 300000,
    this.pengeluaranWajib = const [],
    required this.jagoBp,
    required this.investasiBp,
    required this.danaBp,
    this.bibitBp = 10000,
    this.stockbitBp = 0,
    this.pembulatan = RoundingOption.tanpa,
    this.metodeSubJago = JagoSubAllocationMethod.persentaseTetap,
    this.subJagoLanggananBp = 1000,
    this.subJagoDaruratBp = 5000,
    this.subJagoOperasionalBp = 4000,
    this.langganan = const [],
    this.danaDarurat,
    this.frekuensiTopUpDana = DanaTopUpFrequency.mingguan,
    this.hariTopUpMingguan = DateTime.monday,
  });

  final int tahun;

  /// 1–12.
  final int bulan;
  final int penghasilanUtama;
  final List<IncomeSourceInput> penghasilanTambahan;
  final int kasPeganganBrimo;
  final List<MandatoryExpenseInput> pengeluaranWajib;

  /// Tingkat utama: pembagian Dana Bersih (§12 Tahap 2), wajib total 100%.
  final int jagoBp;
  final int investasiBp;
  final int danaBp;

  /// Tingkat internal investasi (§12 Tahap 3), wajib total 100% saat
  /// investasiBp > 0.
  final int bibitBp;
  final int stockbitBp;

  final RoundingOption pembulatan;

  final JagoSubAllocationMethod metodeSubJago;
  final int subJagoLanggananBp;
  final int subJagoDaruratBp;
  final int subJagoOperasionalBp;

  final List<SubscriptionInput> langganan;
  final EmergencyFundInput? danaDarurat;

  final DanaTopUpFrequency frekuensiTopUpDana;

  /// DateTime.monday..DateTime.sunday; relevan untuk frekuensi mingguan.
  final int hariTopUpMingguan;

  int get jumlahHariBulanAktif => DateTime(tahun, bulan + 1, 0).day;
}
