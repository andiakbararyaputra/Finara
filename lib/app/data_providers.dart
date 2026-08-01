/// Provider data baca untuk halaman (revisi aktif, riwayat, checklist).
/// Di-invalidate setelah simpan revisi atau toggle checklist.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db/app_database.dart';
import '../data/repositories/investment_actual_repository.dart';
import '../domain/models/finance_enums.dart';
import '../domain/services/financial_health_score_service.dart';
import '../domain/services/savings_rate_service.dart';
import '../domain/services/stockbit_reconciliation_service.dart';
import 'providers.dart';

/// Revisi aktif bulan berjalan; null jika belum ada alokasi.
final revisiBulanAktifProvider =
    FutureProvider<MonthlyAllocationRevision?>((ref) {
  final kini = DateTime.now();
  return ref
      .watch(allocationRepositoryProvider)
      .revisiAktifBulan(kini.year, kini.month);
});

class RiwayatEntry {
  const RiwayatEntry({required this.bulan, required this.revisi});

  final MonthlyAllocation bulan;
  final MonthlyAllocationRevision revisi;
}

/// Daftar bulan dengan revisi terbarunya, terbaru dulu.
final daftarRiwayatProvider = FutureProvider<List<RiwayatEntry>>((ref) async {
  final repo = ref.watch(allocationRepositoryProvider);
  final daftarBulan = await repo.daftarBulan();
  final entries = <RiwayatEntry>[];
  for (final bulan in daftarBulan) {
    final revisi = await repo.revisiTerbaru(bulan.id);
    if (revisi != null) {
      entries.add(RiwayatEntry(bulan: bulan, revisi: revisi));
    }
  }
  return entries;
});

/// Detail satu revisi + induk bulannya.
class RevisiDetail {
  const RevisiDetail({required this.revisi, required this.bulan});

  final MonthlyAllocationRevision revisi;
  final MonthlyAllocation bulan;
}

final revisiDetailProvider =
    FutureProvider.family<RevisiDetail?, int>((ref, id) async {
  final db = ref.watch(databaseProvider);
  final revisi = await (db.select(db.monthlyAllocationRevisions)
        ..where((t) => t.id.equals(id)))
      .getSingleOrNull();
  if (revisi == null) return null;
  final bulan = await (db.select(db.monthlyAllocations)
        ..where((t) => t.id.equals(revisi.monthlyAllocationId)))
      .getSingle();
  return RevisiDetail(revisi: revisi, bulan: bulan);
});

/// Checklist satu revisi.
final checklistProvider =
    FutureProvider.family<List<ChecklistItem>, int>((ref, revisiId) {
  return ref.watch(allocationRepositoryProvider).checklistRevisi(revisiId);
});

/// Realisasi pengeluaran satu revisi (§22A).
final realisasiPerRevisiProvider =
    FutureProvider.family<List<ExpenseRealization>, int>((ref, revisiId) {
  return ref
      .watch(expenseRealizationRepositoryProvider)
      .perRevisi(revisiId);
});

/// Realisasi pengeluaran bulan kalender berjalan (fitur Catat Pengeluaran).
final realisasiBulanIniProvider =
    FutureProvider<List<ExpenseRealization>>((ref) {
  final kini = DateTime.now();
  return ref
      .watch(expenseRealizationRepositoryProvider)
      .perBulan(kini.year, kini.month);
});

/// Sisa anggaran DANA; null berarti belum ada realisasi (bukan 0).
final sisaAnggaranDanaProvider =
    FutureProvider.family<int?, ({int revisiId, int alokasiDana})>(
        (ref, args) {
  ref.watch(realisasiPerRevisiProvider(args.revisiId));
  return ref.watch(expenseRealizationRepositoryProvider).sisaAnggaranDana(
      revisiId: args.revisiId, alokasiDana: args.alokasiDana);
});

/// Daftar langganan tersimpan (§15).
final daftarLanggananProvider = FutureProvider<List<Subscription>>((ref) {
  return ref.watch(subscriptionRepositoryProvider).semua();
});

/// Revisi aktif bulan sebelum (tahun, bulan) — untuk perbandingan §22.
final revisiBulanSebelumnyaProvider = FutureProvider
    .family<MonthlyAllocationRevision?, ({int tahun, int bulan})>(
        (ref, arg) {
  final sebelumnya = DateTime(arg.tahun, arg.bulan - 1);
  return ref
      .watch(allocationRepositoryProvider)
      .revisiAktifBulan(sebelumnya.year, sebelumnya.month);
});

/// Target dana darurat aktif (§16).
final targetDanaDaruratProvider =
    FutureProvider<EmergencyFundTarget?>((ref) {
  return ref.watch(emergencyFundRepositoryProvider).targetAktif();
});

/// Financial Health Score bulan aktif (§24) dari data yang tersedia.
final skorKesehatanProvider =
    FutureProvider<FinancialHealthScore>((ref) async {
  const service = FinancialHealthScoreService();
  final db = ref.watch(databaseProvider);
  final revisi = await ref.watch(revisiBulanAktifProvider.future);
  final target = await ref.watch(targetDanaDaruratProvider.future);

  final pokok = target?.pengeluaranPokokManual;
  final targetNominal = (target != null && pokok != null)
      ? pokok * target.targetJumlahBulan
      : null;

  int? cicilan;
  int? checklistSelesai;
  int? checklistTotal;
  int? uangJajan;
  var uangJajanAktual = false;
  final konsistensi = await _konsistensiInvestasi(ref);

  if (revisi != null) {
    final wajib = await (db.select(db.mandatoryExpenses)
          ..where((t) => t.revisionId.equals(revisi.id)))
        .get();
    // Heuristik F2: cicilan dikenali dari nama/kategori item wajib.
    cicilan = wajib
        .where((e) =>
            e.nama.toLowerCase().contains('cicilan') ||
            e.kategori.toLowerCase().contains('cicilan'))
        .fold<int>(0, (sum, e) => sum + e.nominal);

    final checklist = await ref
        .watch(allocationRepositoryProvider)
        .checklistRevisi(revisi.id);
    checklistTotal = checklist.length;
    checklistSelesai = checklist.where((c) => c.selesai).length;

    final terpakaiDana = await ref
        .watch(expenseRealizationRepositoryProvider)
        .sisaAnggaranDana(
            revisiId: revisi.id, alokasiDana: revisi.alokasiDana);
    if (terpakaiDana != null) {
      uangJajan = revisi.alokasiDana - terpakaiDana; // pengeluaran aktual
      uangJajanAktual = true;
    } else {
      uangJajan = revisi.alokasiDana; // anggaran rencana
    }
  }

  return service.hitung(HealthScoreInput(
    saldoDanaDarurat: target?.saldoSaatIni,
    targetDanaDarurat: targetNominal,
    totalPendapatan: revisi?.totalPendapatan,
    totalPengeluaranWajib: revisi?.totalPengeluaranWajib,
    totalCicilan: revisi == null ? null : cicilan,
    // Konsistensi investasi §115: dari data aktual manual terverifikasi.
    bulanInvestasiTercapai: konsistensi.tercapai,
    bulanInvestasiTersedia: konsistensi.tersedia,
    uangJajan: uangJajan,
    uangJajanAktual: uangJajanAktual,
    checklistSelesai: checklistSelesai,
    checklistTotal: checklistTotal,
  ));
});

/// Savings Rate Rencana bulan aktif (§23), basis points; null tanpa data.
final savingsRateRencanaProvider = FutureProvider<int?>((ref) async {
  final revisi = await ref.watch(revisiBulanAktifProvider.future);
  if (revisi == null) return null;
  final tabunganLain = await ref
      .watch(emergencyFundRepositoryProvider)
      .tabunganLain(DateTime.now().year, DateTime.now().month);
  final lain = tabunganLain
      .where((t) => t.status == PlanActualStatus.rencana)
      .fold<int>(0, (sum, t) => sum + t.nominal);
  return const SavingsRateService().rencanaBp(
    totalPendapatan: revisi.totalPendapatan,
    kontribusiDanaDaruratRencana: revisi.subJagoDanaDarurat,
    totalAlokasiInvestasi: revisi.totalAlokasiInvestasi,
    tabunganLainRencana: lain,
  );
});

/// Data aktual investasi bulan aktif per platform (§116).
final aktualInvestasiBulanIniProvider = FutureProvider
    .family<InvestmentActual?, InvestmentPlatform>((ref, platform) {
  final kini = DateTime.now();
  return ref
      .watch(investmentActualRepositoryProvider)
      .periode(platform, kini.year, kini.month);
});

/// Rekonsiliasi Stockbit bulan aktif (§112).
final rekonsiliasiStockbitProvider =
    FutureProvider<StockbitReconciliation>((ref) async {
  final revisi = await ref.watch(revisiBulanAktifProvider.future);
  final aktual = await ref
      .watch(aktualInvestasiBulanIniProvider(InvestmentPlatform.stockbit)
          .future);
  return const StockbitReconciliationService().rekonsiliasi(
    targetKontribusi: revisi?.alokasiStockbit,
    aktual: aktual == null
        ? const InvestmentActualInput()
        : aktualDariRow(aktual),
  );
});

/// Realisasi kontribusi gabungan bulan aktif (§115); null tanpa data.
final kontribusiGabunganProvider = FutureProvider<int?>((ref) async {
  final bibit = await ref
      .watch(aktualInvestasiBulanIniProvider(InvestmentPlatform.bibit).future);
  final stockbit = await ref.watch(
      aktualInvestasiBulanIniProvider(InvestmentPlatform.stockbit).future);
  return const InvestmentContributionService().realisasiGabungan(
    bibit: bibit == null ? null : aktualDariRow(bibit),
    stockbit: stockbit == null ? null : aktualDariRow(stockbit),
  );
});

/// Konsistensi investasi §24.4/§115: maks 3 bulan terakhir bertarget
/// dengan realisasi terverifikasi. Null jika tidak ada bulan memenuhi.
Future<({int? tercapai, int? tersedia})> _konsistensiInvestasi(
    Ref ref) async {
  final repoAlokasi = ref.read(allocationRepositoryProvider);
  final repoAktual = ref.read(investmentActualRepositoryProvider);
  const gabung = InvestmentContributionService();

  var tersedia = 0;
  var tercapai = 0;
  var kursor = DateTime.now();
  for (var i = 0; i < 3; i++) {
    final revisi =
        await repoAlokasi.revisiAktifBulan(kursor.year, kursor.month);
    if (revisi != null && revisi.totalAlokasiInvestasi > 0) {
      final bibit = await repoAktual.periode(
          InvestmentPlatform.bibit, kursor.year, kursor.month);
      final stockbit = await repoAktual.periode(
          InvestmentPlatform.stockbit, kursor.year, kursor.month);
      final realisasi = gabung.realisasiGabungan(
        bibit: bibit == null ? null : aktualDariRow(bibit),
        stockbit: stockbit == null ? null : aktualDariRow(stockbit),
      );
      if (realisasi != null) {
        tersedia++;
        if (realisasi >= revisi.totalAlokasiInvestasi) tercapai++;
      }
    }
    kursor = DateTime(kursor.year, kursor.month - 1);
  }
  if (tersedia == 0) return (tercapai: null, tersedia: null);
  return (tercapai: tercapai, tersedia: tersedia);
}
