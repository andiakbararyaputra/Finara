/// Provider data baca untuk halaman (revisi aktif, riwayat, checklist).
/// Di-invalidate setelah simpan revisi atau toggle checklist.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db/app_database.dart';
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
