/// Financial Health Score (§24): 6 komponen berbobot, dukung data parsial.
/// Komponen tanpa data = null (tidak diberi nol); skor dinormalkan ke
/// bobot yang tersedia. Versi ambang disimpan pada hasil.
library;

import '../../core/basis_points.dart';

/// Naikkan saat tabel ambang di bawah berubah (§24 versi ambang).
const int versiAmbangSkor = 1;

enum HealthScoreCategory { perluPerhatian, cukupBerisiko, cukupSehat, sangatSehat }

enum HealthComponentId {
  danaDarurat,
  rasioWajib,
  rasioCicilan,
  konsistensiInvestasi,
  rasioUangJajan,
  checklist,
}

class HealthComponentResult {
  const HealthComponentResult({
    required this.id,
    required this.bobot,
    required this.poin,
    required this.tersedia,
    this.basisAktual = false,
  });

  final HealthComponentId id;
  final int bobot;

  /// Poin diperoleh; hanya bermakna jika [tersedia].
  final int poin;
  final bool tersedia;

  /// True jika dihitung dari data aktual, false = rencana (§24 komponen 5).
  final bool basisAktual;
}

class FinancialHealthScore {
  const FinancialHealthScore({
    required this.skor,
    required this.kelengkapanBp,
    required this.kategori,
    required this.komponen,
    required this.versiAmbang,
  });

  /// 0–100 dinormalkan terhadap bobot komponen tersedia; null jika tidak
  /// ada satu pun komponen tersedia.
  final int? skor;

  /// Kelengkapan data: total bobot tersedia / 100, dalam basis points.
  final int kelengkapanBp;
  final HealthScoreCategory? kategori;
  final List<HealthComponentResult> komponen;
  final int versiAmbang;
}

/// Input per komponen; null = data tidak tersedia.
class HealthScoreInput {
  const HealthScoreInput({
    this.saldoDanaDarurat,
    this.targetDanaDarurat,
    this.totalPendapatan,
    this.totalPengeluaranWajib,
    this.totalCicilan,
    this.bulanInvestasiTercapai,
    this.bulanInvestasiTersedia,
    this.uangJajan,
    this.uangJajanAktual = false,
    this.checklistSelesai,
    this.checklistTotal,
  });

  final int? saldoDanaDarurat;
  final int? targetDanaDarurat;
  final int? totalPendapatan;
  final int? totalPengeluaranWajib;
  final int? totalCicilan;

  /// Maks 3 bulan aktif terakhir bertarget + realisasi terverifikasi (§24.4).
  final int? bulanInvestasiTercapai;
  final int? bulanInvestasiTersedia;
  final int? uangJajan;
  final bool uangJajanAktual;
  final int? checklistSelesai;
  final int? checklistTotal;
}

class FinancialHealthScoreService {
  const FinancialHealthScoreService();

  FinancialHealthScore hitung(HealthScoreInput input) {
    final komponen = <HealthComponentResult>[
      _danaDarurat(input),
      _rasioWajib(input),
      _rasioCicilan(input),
      _konsistensiInvestasi(input),
      _rasioUangJajan(input),
      _checklist(input),
    ];

    final tersedia = komponen.where((k) => k.tersedia).toList();
    final bobotTersedia =
        tersedia.fold<int>(0, (sum, k) => sum + k.bobot);
    final poin = tersedia.fold<int>(0, (sum, k) => sum + k.poin);

    final int? skor =
        bobotTersedia == 0 ? null : (poin * 100) ~/ bobotTersedia;
    final kategori = skor == null
        ? null
        : switch (skor) {
            < 40 => HealthScoreCategory.perluPerhatian,
            < 60 => HealthScoreCategory.cukupBerisiko,
            < 80 => HealthScoreCategory.cukupSehat,
            _ => HealthScoreCategory.sangatSehat,
          };

    return FinancialHealthScore(
      skor: skor,
      kelengkapanBp: bobotTersedia * 100, // bobot 100 total → bp
      kategori: kategori,
      komponen: komponen,
      versiAmbang: versiAmbangSkor,
    );
  }

  HealthComponentResult _danaDarurat(HealthScoreInput i) {
    const bobot = 30;
    final saldo = i.saldoDanaDarurat;
    final target = i.targetDanaDarurat;
    if (saldo == null || target == null || target <= 0) {
      return const HealthComponentResult(
          id: HealthComponentId.danaDarurat,
          bobot: bobot,
          poin: 0,
          tersedia: false);
    }
    final rasioBp = (saldo * totalBasisPoints) ~/ target;
    final poin = switch (rasioBp) {
      >= 10000 => 30,
      >= 7500 => 24,
      >= 5000 => 18,
      >= 2500 => 9,
      _ => 0,
    };
    return HealthComponentResult(
        id: HealthComponentId.danaDarurat,
        bobot: bobot,
        poin: poin,
        tersedia: true);
  }

  HealthComponentResult _rasioWajib(HealthScoreInput i) {
    const bobot = 20;
    final pendapatan = i.totalPendapatan;
    final wajib = i.totalPengeluaranWajib;
    if (pendapatan == null || pendapatan <= 0 || wajib == null) {
      return const HealthComponentResult(
          id: HealthComponentId.rasioWajib,
          bobot: bobot,
          poin: 0,
          tersedia: false);
    }
    final rasioBp = (wajib * totalBasisPoints) ~/ pendapatan;
    final poin = switch (rasioBp) {
      <= 5000 => 20,
      <= 6000 => 15,
      <= 7000 => 8,
      _ => 0,
    };
    return HealthComponentResult(
        id: HealthComponentId.rasioWajib,
        bobot: bobot,
        poin: poin,
        tersedia: true);
  }

  HealthComponentResult _rasioCicilan(HealthScoreInput i) {
    const bobot = 15;
    final pendapatan = i.totalPendapatan;
    final cicilan = i.totalCicilan;
    if (pendapatan == null || pendapatan <= 0 || cicilan == null) {
      return const HealthComponentResult(
          id: HealthComponentId.rasioCicilan,
          bobot: bobot,
          poin: 0,
          tersedia: false);
    }
    final rasioBp = (cicilan * totalBasisPoints) ~/ pendapatan;
    final poin = switch (rasioBp) {
      <= 1000 => 15,
      <= 2000 => 12,
      <= 3000 => 6,
      _ => 0,
    };
    return HealthComponentResult(
        id: HealthComponentId.rasioCicilan,
        bobot: bobot,
        poin: poin,
        tersedia: true);
  }

  HealthComponentResult _konsistensiInvestasi(HealthScoreInput i) {
    const bobot = 15;
    final tersedia = i.bulanInvestasiTersedia;
    final tercapai = i.bulanInvestasiTercapai;
    if (tersedia == null || tersedia == 0 || tercapai == null) {
      return const HealthComponentResult(
          id: HealthComponentId.konsistensiInvestasi,
          bobot: bobot,
          poin: 0,
          tersedia: false);
    }
    final rasioBp = (tercapai * totalBasisPoints) ~/ tersedia;
    final poin = switch (rasioBp) {
      10000 => 15,
      >= 6700 => 10,
      >= 3400 => 5,
      _ => 0,
    };
    return HealthComponentResult(
        id: HealthComponentId.konsistensiInvestasi,
        bobot: bobot,
        poin: poin,
        tersedia: true);
  }

  HealthComponentResult _rasioUangJajan(HealthScoreInput i) {
    const bobot = 10;
    final pendapatan = i.totalPendapatan;
    final jajan = i.uangJajan;
    if (pendapatan == null || pendapatan <= 0 || jajan == null) {
      return const HealthComponentResult(
          id: HealthComponentId.rasioUangJajan,
          bobot: bobot,
          poin: 0,
          tersedia: false);
    }
    final rasioBp = (jajan * totalBasisPoints) ~/ pendapatan;
    final poin = switch (rasioBp) {
      <= 2000 => 10,
      <= 3000 => 7,
      <= 4000 => 3,
      _ => 0,
    };
    return HealthComponentResult(
        id: HealthComponentId.rasioUangJajan,
        bobot: bobot,
        poin: poin,
        tersedia: true,
        basisAktual: i.uangJajanAktual);
  }

  HealthComponentResult _checklist(HealthScoreInput i) {
    const bobot = 10;
    final total = i.checklistTotal;
    final selesai = i.checklistSelesai;
    if (total == null || total == 0 || selesai == null) {
      return const HealthComponentResult(
          id: HealthComponentId.checklist,
          bobot: bobot,
          poin: 0,
          tersedia: false);
    }
    final rasioBp = (selesai * totalBasisPoints) ~/ total;
    final poin = switch (rasioBp) {
      >= 9000 => 10,
      >= 7500 => 7,
      >= 5000 => 4,
      _ => 0,
    };
    return HealthComponentResult(
        id: HealthComponentId.checklist,
        bobot: bobot,
        poin: poin,
        tersedia: true);
  }
}
