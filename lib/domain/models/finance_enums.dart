/// Enum status dan sumber anggaran lintas modul (§11, §22, §54).
/// Sumber anggaran ≠ kanal pembayaran: sumber = pos pembiayaan,
/// kanal = media eksekusi (PaymentChannel di allocation_input.dart).
library;

/// Status siklus hidup revisi alokasi bulanan (§22).
enum RevisionStatus { draf, dikonfirmasi, dikunci, direvisi }

/// Pos yang membiayai suatu nominal (aturan global #1–#2).
enum BudgetSource {
  kantongPengeluaranWajib,
  kantongLanggananJago,
  alokasiJago,
  alokasiDana,
}

/// Jenis nominal pengeluaran wajib (§11).
enum ExpenseAmountType { tetap, variabel }

/// Status verifikasi realisasi (§22A).
enum VerificationStatus { belumDiverifikasi, terverifikasi }

/// Pembeda rencana vs realisasi (aturan global #3).
enum PlanActualStatus { rencana, aktual }

/// Sub-platform Total Alokasi Investasi (§12 Tahap 3).
enum InvestmentPlatform { bibit, stockbit }

/// Jenis pengingat lokal (§49).
enum ReminderKind {
  hariGajian,
  buatAlokasi,
  topUpBibit,
  transferRdnStockbit,
  topUpDana,
  tagihan,
  langganan,
  evaluasiAkhirBulan,
}
