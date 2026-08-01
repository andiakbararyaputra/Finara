/// Repository alokasi bulanan berversi (§22): revisi immutable — nominal
/// snapshot tidak pernah di-UPDATE; perubahan bulan terkonfirmasi membuat
/// revisi baru dan revisi lama ditandai `direvisi` (audit trail).
library;

import 'package:drift/drift.dart';

import '../../domain/models/allocation_input.dart';
import '../../domain/models/allocation_result.dart';
import '../../domain/models/finance_enums.dart';
import '../../domain/services/checklist_builder.dart';
import '../db/app_database.dart';

class AllocationRepository {
  AllocationRepository(this._db, {ChecklistBuilder? checklistBuilder})
      : _checklist = checklistBuilder ?? const ChecklistBuilder();

  final AppDatabase _db;
  final ChecklistBuilder _checklist;

  /// Simpan hasil perhitungan sebagai revisi baru bulan (tahun, bulan).
  /// Revisi pertama bernomor 1; bulan yang sudah ada mendapat nomor
  /// berikutnya dan revisi aktif lama ditandai [RevisionStatus.direvisi].
  Future<int> simpanRevisi({
    required AllocationInput input,
    required AllocationResult hasil,
    String? namaPreset,
    String? alasanPerubahan,
    String? catatan,
    DateTime? sekarang,
  }) {
    final waktu = sekarang ?? DateTime.now();
    return _db.transaction(() async {
      final bulanAda = await (_db.select(_db.monthlyAllocations)
            ..where((t) =>
                t.tahun.equals(input.tahun) & t.bulan.equals(input.bulan)))
          .getSingleOrNull();

      final int bulanId;
      var nomorRevisi = 1;
      if (bulanAda == null) {
        bulanId = await _db.into(_db.monthlyAllocations).insert(
              MonthlyAllocationsCompanion.insert(
                tahun: input.tahun,
                bulan: input.bulan,
                dibuatPada: waktu,
              ),
            );
      } else {
        bulanId = bulanAda.id;
        final revisiAktif = await revisiTerbaru(bulanId);
        if (revisiAktif != null) {
          nomorRevisi = revisiAktif.nomorRevisi + 1;
          // Transisi status, bukan perubahan nominal.
          await (_db.update(_db.monthlyAllocationRevisions)
                ..where((t) => t.id.equals(revisiAktif.id)))
              .write(const MonthlyAllocationRevisionsCompanion(
            status: Value(RevisionStatus.direvisi),
          ));
        }
      }

      final revisiId =
          await _db.into(_db.monthlyAllocationRevisions).insert(
                MonthlyAllocationRevisionsCompanion.insert(
                  monthlyAllocationId: bulanId,
                  nomorRevisi: nomorRevisi,
                  status: RevisionStatus.draf,
                  alasanPerubahan: Value(alasanPerubahan),
                  catatan: Value(catatan),
                  penghasilanUtama: input.penghasilanUtama,
                  kasPeganganBrimo: input.kasPeganganBrimo,
                  preset: Value(namaPreset),
                  jagoBp: input.jagoBp,
                  investasiBp: input.investasiBp,
                  danaBp: input.danaBp,
                  bibitBp: input.bibitBp,
                  stockbitBp: input.stockbitBp,
                  pembulatan: input.pembulatan,
                  metodeSubJago: input.metodeSubJago,
                  subJagoLanggananBp: input.subJagoLanggananBp,
                  subJagoDaruratBp: input.subJagoDaruratBp,
                  subJagoOperasionalBp: input.subJagoOperasionalBp,
                  frekuensiTopUpDana: input.frekuensiTopUpDana,
                  hariTopUpMingguan: input.hariTopUpMingguan,
                  totalPendapatan: hasil.totalPendapatan,
                  totalPengeluaranWajib: hasil.totalPengeluaranWajib,
                  danaBersih: hasil.danaBersih,
                  alokasiJago: hasil.alokasiJago,
                  totalAlokasiInvestasi: hasil.totalAlokasiInvestasi,
                  alokasiDana: hasil.alokasiDana,
                  alokasiBibit: hasil.alokasiBibit,
                  alokasiStockbit: hasil.alokasiStockbit,
                  totalDanaMasukJago: hasil.totalDanaMasukJago,
                  subJagoLangganan: hasil.subAlokasiJago.kebutuhanLangganan,
                  subJagoDanaDarurat: hasil.subAlokasiJago.danaDarurat,
                  subJagoOperasional: hasil.subAlokasiJago.danaOperasional,
                  dibuatPada: waktu,
                ),
              );

      for (final s in input.penghasilanTambahan) {
        await _db.into(_db.incomeSources).insert(
              IncomeSourcesCompanion.insert(
                revisionId: revisiId,
                nama: s.nama,
                nominal: s.nominal,
                rutin: s.rutin,
                disertakanBulanAktif: s.disertakanBulanAktif,
              ),
            );
      }

      for (final e in input.pengeluaranWajib) {
        final expenseId = await _db.into(_db.mandatoryExpenses).insert(
              MandatoryExpensesCompanion.insert(
                revisionId: revisiId,
                nama: e.nama,
                kategori: e.nama,
                nominal: e.nominal,
                rutin: true,
                jenisNominal: ExpenseAmountType.tetap,
                kebutuhanPokok: e.kebutuhanPokok,
                dihitungDasarDanaDarurat: e.dihitungDasarDanaDarurat,
                kanalPembayaran: e.kanalPembayaran,
              ),
            );
        // Sumber anggaran wajib selalu Kantong Pengeluaran Wajib (§11).
        await _db.into(_db.budgetFundingAssignments).insert(
              BudgetFundingAssignmentsCompanion.insert(
                itemId: '$expenseId',
                itemType: 'mandatoryExpense',
                revisionId: revisiId,
                fundingSource: BudgetSource.kantongPengeluaranWajib,
                paymentChannel: e.kanalPembayaran,
                includedInSpendingBudget: false,
              ),
            );
      }

      if (hasil.totalAlokasiInvestasi > 0) {
        for (final (platform, bp, nominal) in [
          (InvestmentPlatform.bibit, input.bibitBp, hasil.alokasiBibit),
          (
            InvestmentPlatform.stockbit,
            input.stockbitBp,
            hasil.alokasiStockbit
          ),
        ]) {
          await _db.into(_db.investmentPlatformAllocations).insert(
                InvestmentPlatformAllocationsCompanion.insert(
                  revisionId: revisiId,
                  platform: platform,
                  targetPercentageBp: bp,
                  targetAmount: nominal,
                  roundedAmount: nominal,
                  status: PlanActualStatus.rencana,
                ),
              );
        }
      }

      final checklist = _checklist.buat(input, hasil);
      for (var i = 0; i < checklist.length; i++) {
        await _db.into(_db.checklistItems).insert(
              ChecklistItemsCompanion.insert(
                revisionId: revisiId,
                urutan: i,
                kode: checklist[i].kode,
                nominal: Value(checklist[i].nominal),
                detail: Value(checklist[i].detail),
                selesai: false,
                diperbaruiPada: waktu,
              ),
            );
      }

      return revisiId;
    });
  }

  Future<MonthlyAllocationRevision?> revisiTerbaru(int bulanId) {
    return (_db.select(_db.monthlyAllocationRevisions)
          ..where((t) => t.monthlyAllocationId.equals(bulanId))
          ..orderBy([(t) => OrderingTerm.desc(t.nomorRevisi)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<MonthlyAllocationRevision?> revisiAktifBulan(int tahun, int bulan) {
    final query = _db.select(_db.monthlyAllocationRevisions).join([
      innerJoin(
        _db.monthlyAllocations,
        _db.monthlyAllocations.id
            .equalsExp(_db.monthlyAllocationRevisions.monthlyAllocationId),
      ),
    ])
      ..where(_db.monthlyAllocations.tahun.equals(tahun) &
          _db.monthlyAllocations.bulan.equals(bulan))
      ..orderBy([
        OrderingTerm.desc(_db.monthlyAllocationRevisions.nomorRevisi),
      ])
      ..limit(1);
    return query
        .map((row) => row.readTable(_db.monthlyAllocationRevisions))
        .getSingleOrNull();
  }

  /// Seluruh revisi satu bulan, terbaru dulu (audit trail §22).
  Future<List<MonthlyAllocationRevision>> riwayatRevisi(int bulanId) {
    return (_db.select(_db.monthlyAllocationRevisions)
          ..where((t) => t.monthlyAllocationId.equals(bulanId))
          ..orderBy([(t) => OrderingTerm.desc(t.nomorRevisi)]))
        .get();
  }

  Future<List<MonthlyAllocation>> daftarBulan({int? tahun}) {
    final q = _db.select(_db.monthlyAllocations)
      ..orderBy([
        (t) => OrderingTerm.desc(t.tahun),
        (t) => OrderingTerm.desc(t.bulan),
      ]);
    if (tahun != null) q.where((t) => t.tahun.equals(tahun));
    return q.get();
  }

  /// Transisi status draf → dikonfirmasi → dikunci. Menimpa nominal tidak
  /// disediakan by design.
  Future<void> ubahStatus(int revisiId, RevisionStatus status) async {
    await (_db.update(_db.monthlyAllocationRevisions)
          ..where((t) => t.id.equals(revisiId)))
        .write(MonthlyAllocationRevisionsCompanion(status: Value(status)));
  }

  Future<List<ChecklistItem>> checklistRevisi(int revisiId) {
    return (_db.select(_db.checklistItems)
          ..where((t) => t.revisionId.equals(revisiId))
          ..orderBy([(t) => OrderingTerm.asc(t.urutan)]))
        .get();
  }

  Future<void> setChecklistSelesai(int itemId, {required bool selesai}) async {
    await (_db.update(_db.checklistItems)..where((t) => t.id.equals(itemId)))
        .write(ChecklistItemsCompanion(
      selesai: Value(selesai),
      diperbaruiPada: Value(DateTime.now()),
    ));
  }

  Future<List<InvestmentPlatformAllocation>> alokasiInvestasiRevisi(
    int revisiId,
  ) {
    return (_db.select(_db.investmentPlatformAllocations)
          ..where((t) => t.revisionId.equals(revisiId)))
        .get();
  }

  /// Data untuk prefill alur Hitung dari revisi lama (edit draf/duplikasi).
  Future<(MonthlyAllocationRevision, List<IncomeSource>,
      List<MandatoryExpense>)?> muatUntukPrefill(int revisiId) async {
    final revisi = await (_db.select(_db.monthlyAllocationRevisions)
          ..where((t) => t.id.equals(revisiId)))
        .getSingleOrNull();
    if (revisi == null) return null;
    final pendapatan = await (_db.select(_db.incomeSources)
          ..where((t) => t.revisionId.equals(revisiId)))
        .get();
    final wajib = await (_db.select(_db.mandatoryExpenses)
          ..where((t) => t.revisionId.equals(revisiId)))
        .get();
    return (revisi, pendapatan, wajib);
  }

  /// Hapus satu bulan beserta seluruh revisi dan data anaknya (§22,
  /// dengan konfirmasi di UI).
  Future<void> hapusBulan(int bulanId) {
    return _db.transaction(() async {
      final revisiIds = (await (_db.select(_db.monthlyAllocationRevisions)
                ..where((t) => t.monthlyAllocationId.equals(bulanId)))
              .get())
          .map((r) => r.id)
          .toList();
      for (final id in revisiIds) {
        await (_db.delete(_db.checklistItems)
              ..where((t) => t.revisionId.equals(id)))
            .go();
        await (_db.delete(_db.incomeSources)
              ..where((t) => t.revisionId.equals(id)))
            .go();
        await (_db.delete(_db.budgetFundingAssignments)
              ..where((t) => t.revisionId.equals(id)))
            .go();
        await (_db.delete(_db.mandatoryExpenses)
              ..where((t) => t.revisionId.equals(id)))
            .go();
        await (_db.delete(_db.investmentPlatformAllocations)
              ..where((t) => t.revisionId.equals(id)))
            .go();
        await (_db.delete(_db.expenseRealizations)
              ..where((t) => t.monthlyAllocationRevisionId.equals(id)))
            .go();
      }
      await (_db.delete(_db.monthlyAllocationRevisions)
            ..where((t) => t.monthlyAllocationId.equals(bulanId)))
          .go();
      await (_db.delete(_db.monthlyAllocations)
            ..where((t) => t.id.equals(bulanId)))
          .go();
    });
  }
}
