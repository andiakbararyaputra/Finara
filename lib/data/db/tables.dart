/// Skema Drift subset Fase 1 (§54). Seluruh nominal int Rupiah; persentase
/// basis points; nilai tak tersedia = kolom nullable (bukan 0).
/// Revisi bulanan immutable: nominal snapshot tidak pernah di-UPDATE,
/// perubahan = revisi baru (§22).
library;

import 'package:drift/drift.dart';

import '../../domain/models/allocation_input.dart';
import '../../domain/models/finance_enums.dart';

class MonthlyAllocations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tahun => integer()();
  IntColumn get bulan => integer()(); // 1–12
  DateTimeColumn get dibuatPada => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {tahun, bulan},
      ];
}

/// Snapshot rencana satu revisi — immutable kecuali [status] dan
/// [alasanPerubahan] (transisi status bukan perubahan nominal).
class MonthlyAllocationRevisions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get monthlyAllocationId =>
      integer().references(MonthlyAllocations, #id)();
  IntColumn get nomorRevisi => integer()();
  TextColumn get status => textEnum<RevisionStatus>()();
  TextColumn get alasanPerubahan => text().nullable()();
  TextColumn get catatan => text().nullable()();

  // Input yang menentukan hasil (agar revisi dapat dihitung ulang/diaudit).
  IntColumn get penghasilanUtama => integer()();
  IntColumn get kasPeganganBrimo => integer()();
  TextColumn get preset => text().nullable()(); // nama preset; null = custom
  IntColumn get jagoBp => integer()();
  IntColumn get investasiBp => integer()();
  IntColumn get danaBp => integer()();
  IntColumn get bibitBp => integer()();
  IntColumn get stockbitBp => integer()();
  TextColumn get pembulatan => textEnum<RoundingOption>()();
  TextColumn get metodeSubJago => textEnum<JagoSubAllocationMethod>()();
  IntColumn get subJagoLanggananBp => integer()();
  IntColumn get subJagoDaruratBp => integer()();
  IntColumn get subJagoOperasionalBp => integer()();
  TextColumn get frekuensiTopUpDana => textEnum<DanaTopUpFrequency>()();
  IntColumn get hariTopUpMingguan => integer()();

  // Nominal hasil final setelah pembulatan (§18).
  IntColumn get totalPendapatan => integer()();
  IntColumn get totalPengeluaranWajib => integer()();
  IntColumn get danaBersih => integer()();
  IntColumn get alokasiJago => integer()();
  IntColumn get totalAlokasiInvestasi => integer()();
  IntColumn get alokasiDana => integer()();
  IntColumn get alokasiBibit => integer()();
  IntColumn get alokasiStockbit => integer()();
  IntColumn get totalDanaMasukJago => integer()();
  IntColumn get subJagoLangganan => integer()();
  IntColumn get subJagoDanaDarurat => integer()();
  IntColumn get subJagoOperasional => integer()();

  DateTimeColumn get dibuatPada => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {monthlyAllocationId, nomorRevisi},
      ];
}

class IncomeSources extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get revisionId =>
      integer().references(MonthlyAllocationRevisions, #id)();
  TextColumn get nama => text()();
  IntColumn get nominal => integer()();
  BoolColumn get rutin => boolean()();
  BoolColumn get disertakanBulanAktif => boolean()();
}

class MandatoryExpenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get revisionId =>
      integer().references(MonthlyAllocationRevisions, #id)();
  TextColumn get nama => text()();
  TextColumn get kategori => text()();
  IntColumn get nominal => integer()();
  IntColumn get tanggalJatuhTempo => integer().nullable()(); // hari 1–31
  BoolColumn get rutin => boolean()();
  TextColumn get jenisNominal => textEnum<ExpenseAmountType>()();
  BoolColumn get kebutuhanPokok => boolean()();
  BoolColumn get dihitungDasarDanaDarurat => boolean()();
  TextColumn get kanalPembayaran => textEnum<PaymentChannel>()();
}

/// Satu nominal = satu sumber anggaran aktif per periode (aturan global #1).
class BudgetFundingAssignments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get itemId => text()();
  TextColumn get itemType => text()();
  IntColumn get revisionId =>
      integer().references(MonthlyAllocationRevisions, #id)();
  TextColumn get fundingSource => textEnum<BudgetSource>()();
  TextColumn get paymentChannel => textEnum<PaymentChannel>()();
  BoolColumn get includedInSpendingBudget => boolean()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {itemId, itemType, revisionId},
      ];
}

class ExpenseRealizations extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get transactionDate => dateTime()();
  IntColumn get amount => integer()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get fundingSource => textEnum<BudgetSource>()();
  TextColumn get paymentChannel => textEnum<PaymentChannel>()();
  IntColumn get monthlyAllocationRevisionId =>
      integer().nullable().references(MonthlyAllocationRevisions, #id)();
  TextColumn get referenceItemId => text().nullable()();
  TextColumn get verificationStatus => textEnum<VerificationStatus>()();
  TextColumn get userNotes => text().nullable()();
}

class Subscriptions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text()();
  TextColumn get siklus => textEnum<SubscriptionCycle>()();

  /// Bulanan: nominal/bulan. Tahunan: biaya tahunan penuh.
  IntColumn get nominal => integer()();
  IntColumn get bulanTagihan => integer()(); // 1–12
  IntColumn get tanggalTagihan => integer().nullable()(); // hari 1–31
  TextColumn get metodeTahunan => textEnum<AnnualFundingMethod>()();
  TextColumn get sumberAnggaran => textEnum<SubscriptionFundingSource>()();
  IntColumn get saldoCadangan => integer()();
  BoolColumn get aktif => boolean()();
  BoolColumn get pengingatAktif => boolean()();
}

/// Ledger cadangan tahunan per periode (§15) — append-only.
class SubscriptionReserveLedgers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subscriptionId => integer().references(Subscriptions, #id)();
  IntColumn get tahun => integer()();
  IntColumn get bulan => integer()();
  IntColumn get saldoAwal => integer()();
  IntColumn get kontribusi => integer()();
  IntColumn get pembayaran => integer()();
  IntColumn get saldoAkhir => integer()();
  DateTimeColumn get dibuatPada => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {subscriptionId, tahun, bulan},
      ];
}

/// Target dana darurat aktif (§16) — satu baris aktif.
class EmergencyFundTargets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get targetJumlahBulan => integer()();
  IntColumn get pengeluaranPokokManual => integer().nullable()();
  IntColumn get saldoSaatIni => integer()();
  DateTimeColumn get targetTanggalTercapai => dateTime().nullable()();
  DateTimeColumn get diperbaruiPada => dateTime()();
}

class EmergencyFundContributions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tahun => integer()();
  IntColumn get bulan => integer()();
  IntColumn get nominal => integer()();
  TextColumn get status => textEnum<PlanActualStatus>()();
  TextColumn get catatan => text().nullable()();
  DateTimeColumn get dibuatPada => dateTime()();
}

/// Tabungan di luar dana darurat/investasi (§23).
class OtherSavingsContributions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text()();
  IntColumn get nominal => integer()();
  IntColumn get tahun => integer()();
  IntColumn get bulan => integer()();
  TextColumn get status => textEnum<PlanActualStatus>()();
}

/// Target per platform investasi per revisi (§54, §120).
class InvestmentPlatformAllocations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get revisionId =>
      integer().references(MonthlyAllocationRevisions, #id)();
  TextColumn get platform => textEnum<InvestmentPlatform>()();
  IntColumn get targetPercentageBp => integer()();
  IntColumn get targetAmount => integer()();
  IntColumn get roundedAmount => integer()();
  DateTimeColumn get plannedTransferDate => dateTime().nullable()();
  TextColumn get status => textEnum<PlanActualStatus>()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {revisionId, platform},
      ];
}

/// Checklist transfer per revisi (§21); di-reset saat alokasi baru dibuat.
class ChecklistItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get revisionId =>
      integer().references(MonthlyAllocationRevisions, #id)();
  IntColumn get urutan => integer()();

  /// Kode template item — dipetakan ke string ARB di presentasi.
  TextColumn get kode => text()();
  IntColumn get nominal => integer().nullable()();
  TextColumn get detail => text().nullable()();
  BoolColumn get selesai => boolean()();
  DateTimeColumn get diperbaruiPada => dateTime()();
}

class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get jenis => textEnum<ReminderKind>()();
  TextColumn get judul => text()();
  DateTimeColumn get waktu => dateTime()();
  BoolColumn get berulangBulanan => boolean()();
  BoolColumn get aktif => boolean()();
}

/// Pengaturan aplikasi key-value (tema, pembulatan default, keamanan).
class AppSettings extends Table {
  TextColumn get kunci => text()();
  TextColumn get nilai => text()();

  @override
  Set<Column> get primaryKey => {kunci};
}
