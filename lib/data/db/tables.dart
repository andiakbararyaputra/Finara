/// Skema Drift subset Fase 1 (§54). Seluruh nominal int Rupiah; persentase
/// basis points; nilai tak tersedia = kolom nullable (bukan 0).
/// Revisi bulanan immutable: nominal snapshot tidak pernah di-UPDATE,
/// perubahan = revisi baru (§22).
library;

import 'package:drift/drift.dart';

import '../../domain/ai/ai_models.dart';
import '../../domain/models/ai_enums.dart';
import '../../domain/models/allocation_input.dart';
import '../../domain/models/finance_enums.dart';
import '../../domain/services/dana_split_service.dart';

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

/// Konfigurasi provider AI (§27, §38). API key TIDAK disimpan di sini —
/// hanya di secure storage dengan kunci `ai_api_key_<id>` (§45).
class AiProviderConfigurations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text()();
  TextColumn get baseUrl => text()();
  TextColumn get chatPath =>
      text().withDefault(const Constant('/chat/completions'))();
  TextColumn get modelsPath =>
      text().withDefault(const Constant('/models'))();
  IntColumn get timeoutDetik => integer().withDefault(const Constant(60))();
  BoolColumn get streamingAktif =>
      boolean().withDefault(const Constant(true))();
  TextColumn get modelDefault => text().nullable()();
  TextColumn get izinData => textEnum<AIDataScope>()();
  TextColumn get allowedMode => textEnum<AllowedModelsMode>()
      .withDefault(const Constant('izinkanSemua'))();
  TextColumn get fallbackModel1 => text().nullable()();
  TextColumn get fallbackModel2 => text().nullable()();
  DateTimeColumn get dibuatPada => dateTime()();
}

/// Model per provider (§30, §33–§34): hasil discovery atau input manual.
class AiModels extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get providerId =>
      integer().references(AiProviderConfigurations, #id)();
  TextColumn get modelId => text()();
  TextColumn get displayName => text().nullable()();
  BoolColumn get favorit => boolean().withDefault(const Constant(false))();
  BoolColumn get manual => boolean().withDefault(const Constant(false))();
  BoolColumn get diblokir => boolean().withDefault(const Constant(false))();
  BoolColumn get diizinkan => boolean().withDefault(const Constant(false))();

  /// Status kemampuan (§32): unknown/claimed/verified/unsupported.
  TextColumn get statusChat => textEnum<CapabilityStatus>()
      .withDefault(const Constant('unknown'))();
  TextColumn get statusStreaming => textEnum<CapabilityStatus>()
      .withDefault(const Constant('unknown'))();

  /// Harga per 1 juta token, diisi pengguna (§39); null = tak tersedia.
  IntColumn get hargaInputPerJuta => integer().nullable()();
  IntColumn get hargaOutputPerJuta => integer().nullable()();
  DateTimeColumn get terakhirDipakai => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {providerId, modelId},
      ];
}

/// Cache daftar model mentah per provider (§29).
class ModelListCaches extends Table {
  IntColumn get providerId =>
      integer().references(AiProviderConfigurations, #id)();
  TextColumn get jsonModel => text()();
  DateTimeColumn get diambilPada => dateTime()();

  @override
  Set<Column> get primaryKey => {providerId};
}

/// Percakapan Finara AI (§47), lokal saja.
class ChatConversations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get judul => text()();
  IntColumn get providerId =>
      integer().references(AiProviderConfigurations, #id)();
  TextColumn get modelId => text()();
  DateTimeColumn get dibuatPada => dateTime()();
  DateTimeColumn get diperbaruiPada => dateTime()();
}

class ChatMessages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get conversationId =>
      integer().references(ChatConversations, #id)();
  TextColumn get role => text()(); // system | user | assistant
  TextColumn get content => text()();
  DateTimeColumn get dibuatPada => dateTime()();
}

/// Konfigurasi DANA+ (§88, §97) — baris terbaru menang.
/// Tingkat reward & batas WAJIB dari pengguna, tidak pernah di-hard-code.
class DanaPlusConfigurations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get availability => textEnum<DanaPlusAvailability>()();
  TextColumn get defaultSplitMode => textEnum<DanaSplitMode>()();
  TextColumn get executionStrategy => textEnum<DanaExecutionStrategy>()();
  IntColumn get persenBiasaBp => integer().withDefault(const Constant(5000))();
  IntColumn get bufferBiasa => integer().withDefault(const Constant(0))();
  IntColumn get targetPlus => integer().withDefault(const Constant(0))();
  IntColumn get batasPlus => integer().nullable()();
  IntColumn get tingkatRewardBp => integer().nullable()();
  TextColumn get periodeReward => textEnum<RewardRatePeriod>()
      .withDefault(const Constant('perTahun'))();
  DateTimeColumn get diperbaruiPada => dateTime()();
}

/// Ledger saldo DANA per periode (§94, §97) — unik per (tahun, bulan).
class DanaBalanceLedgers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tahun => integer()();
  IntColumn get bulan => integer()();
  IntColumn get saldoAwalBiasa => integer()();
  IntColumn get saldoAwalPlus => integer()();
  IntColumn get topUpKeBiasa => integer()();
  IntColumn get pindahKePlus => integer()();
  IntColumn get pindahDariPlus => integer()();
  IntColumn get pengeluaranBiasa => integer()();
  IntColumn get pengeluaranPlus => integer()();
  IntColumn get rewardAktual => integer()();
  IntColumn get saldoAkhirBiasa => integer()();
  IntColumn get saldoAkhirPlus => integer()();
  DateTimeColumn get dibuatPada => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {tahun, bulan},
      ];
}

/// Data aktual investasi per platform per periode (§116, sumber manual).
/// Nilai tak diketahui = null, bukan nol (§53).
class InvestmentActuals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get platform => textEnum<InvestmentPlatform>()();
  IntColumn get tahun => integer()();
  IntColumn get bulan => integer()();
  IntColumn get depositEksternal => integer().nullable()();
  IntColumn get penarikan => integer().nullable()();
  IntColumn get pembelianBersih => integer().nullable()();
  IntColumn get penjualanBersih => integer().nullable()();
  IntColumn get saldoRdnAwal => integer().nullable()();
  IntColumn get saldoRdnAkhir => integer().nullable()();
  IntColumn get biaya => integer().nullable()();
  IntColumn get dividen => integer().nullable()();
  IntColumn get nilaiPortofolio => integer().nullable()();
  IntColumn get modalInvestasi => integer().nullable()();
  TextColumn get verifikasi => textEnum<VerificationStatus>()();
  TextColumn get catatan => text().nullable()();
  DateTimeColumn get diperbaruiPada => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {platform, tahun, bulan},
      ];
}

/// Riwayat impor laporan (§80): fingerprint anti-duplikat §73.
/// File asli TIDAK disimpan (§78 default) — hanya hasil terstruktur.
class ImportedReports extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get platform => textEnum<InvestmentPlatform>()();
  TextColumn get jenis => text()(); // statementBibit (MVP)
  IntColumn get tahun => integer().nullable()();
  IntColumn get bulan => integer().nullable()();
  TextColumn get fileHash => text().unique()();
  TextColumn get namaFile => text()();
  DateTimeColumn get diimporPada => dateTime()();
}
