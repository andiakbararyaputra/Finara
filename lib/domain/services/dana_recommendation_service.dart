/// Rekomendasi pembagian DANA/DANA+ (§89) dan checklist eksekusi (§93).
/// Pure Dart; rekomendasi tidak pernah menentukan pembagian secara absolut.
library;

import '../models/allocation_input.dart';
import 'dana_split_service.dart';

/// Rekomendasi + alasan (§89). Semua nominal Rupiah bulat.
class DanaRecommendation {
  const DanaRecommendation({
    required this.keBiasa,
    required this.kePlus,
    required this.hariHorizon,
    required this.anggaranHorizon,
    required this.tagihanBelumTermasuk,
    required this.buffer,
  });

  final int keBiasa;
  final int kePlus;
  final int hariHorizon;

  /// Sisa anggaran yang diperkirakan terpakai dalam horizon.
  final int anggaranHorizon;
  final int tagihanBelumTermasuk;
  final int buffer;

  /// Dana yang belum diperlukan segera = kandidat DANA+.
  int get danaBelumDiperlukan => kePlus;
}

class DanaRecommendationService {
  const DanaRecommendationService();

  /// Null jika tidak relevan (DANA+ nonaktif atau dana ≤ 0).
  DanaRecommendation? rekomendasikan({
    required int danaDasarPembagian,
    required bool danaPlusAktif,
    int? sisaAnggaranAktual,
    int hariTersisaPeriode = 30,
    int? hariSampaiTopUpBerikutnya,
    int transaksiTerjadwalBelumTermasuk = 0,
    int bufferKeamanan = 0,
    int? batasDanaPlus,
    int saldoAwalDanaPlus = 0,
    RoundingOption pembulatan = RoundingOption.tanpa,
  }) {
    if (!danaPlusAktif || danaDasarPembagian <= 0) return null;

    final input = DanaSplitInput(
      danaDasarPembagian: danaDasarPembagian,
      mode: DanaSplitMode.smartLiquidity,
      sisaAnggaranAktual: sisaAnggaranAktual,
      hariTersisaPeriode: hariTersisaPeriode,
      hariSampaiTopUpBerikutnya: hariSampaiTopUpBerikutnya,
      transaksiTerjadwalBelumTermasuk: transaksiTerjadwalBelumTermasuk,
      bufferKeamanan: bufferKeamanan,
      batasDanaPlus: batasDanaPlus,
      saldoAwalDanaPlus: saldoAwalDanaPlus,
      pembulatan: pembulatan,
    );
    final hasil = const DanaSplitService().hitung(input);

    final horizon = hasil.hariHorizon ?? 0;
    final kebutuhan = hasil.kebutuhanDanaBiasa ?? hasil.saldoBiasa;
    final anggaranHorizon =
        kebutuhan - transaksiTerjadwalBelumTermasuk - bufferKeamanan;

    return DanaRecommendation(
      keBiasa: hasil.saldoBiasa,
      kePlus: hasil.saldoPlus,
      hariHorizon: horizon,
      anggaranHorizon: anggaranHorizon < 0 ? 0 : anggaranHorizon,
      tagihanBelumTermasuk: transaksiTerjadwalBelumTermasuk,
      buffer: bufferKeamanan,
    );
  }
}

/// Kode langkah checklist eksekusi (§93); label UI dari ARB.
enum DanaChecklistStep {
  topUp,
  pertahankanBiasa,
  pindahkanKePlus,
  periksaTotal,
  catatAktual,
}

class DanaChecklistEntry {
  const DanaChecklistEntry(this.step, {this.nominal});

  final DanaChecklistStep step;
  final int? nominal;
}

/// Menyusun instruksi manual utk top-up berikutnya (§93). Untuk frekuensi
/// periodik JANGAN memakai target bulanan penuh — gunakan nominal top-up
/// yang sedang dieksekusi.
class DanaChecklistBuilder {
  const DanaChecklistBuilder();

  List<DanaChecklistEntry> susun({
    required int nominalTopUp,
    required int keBiasa,
    required int kePlus,
    required bool danaPlusAktif,
  }) {
    if (nominalTopUp <= 0) return const [];
    return [
      DanaChecklistEntry(DanaChecklistStep.topUp, nominal: nominalTopUp),
      DanaChecklistEntry(DanaChecklistStep.pertahankanBiasa,
          nominal: keBiasa),
      if (danaPlusAktif && kePlus > 0)
        DanaChecklistEntry(DanaChecklistStep.pindahkanKePlus,
            nominal: kePlus),
      const DanaChecklistEntry(DanaChecklistStep.periksaTotal),
      const DanaChecklistEntry(DanaChecklistStep.catatAktual),
    ];
  }
}
