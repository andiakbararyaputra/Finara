/// Pembagian internal Alokasi DANA → Saldo DANA Biasa + Saldo DANA+
/// (Bagian IX §86–§91). Pure Dart, deterministik.
///
/// Invarian: Saldo Biasa + Saldo Plus = Dana Dasar Pembagian, selalu.
/// Saldo DANA+ tidak pernah negatif dan tidak melampaui batas pengguna;
/// selisih pembulatan diserap Saldo Biasa (§91).
library;

import '../models/allocation_input.dart';

/// Mode pembagian (§87). Smart Liquidity adalah default.
enum DanaSplitMode {
  smartLiquidity,
  persentase,
  nominalTetapBiasa,
  nominalTetapPlus,
  manual,
}

/// Strategi eksekusi top-up (§87).
enum DanaExecutionStrategy {
  sekaligusLaluBagi,
  bagiSetiapTopUp,
  smartPerTopUp,
}

/// Status penggunaan DANA+ (§88) — jangan dianggap tersedia utk semua akun.
enum DanaPlusAvailability {
  menggunakan,
  belumMenggunakan,
  tidakTersedia,
  tidakIngin,
}

/// Status realisasi eksekusi rencana DANA/DANA+ periode berjalan (§94).
enum DanaRealizationStatus {
  belumDieksekusi,
  sebagianSelesai,
  selesai,
  tidakSesuaiRencana,
  dibatalkan,
}

class DanaSplitInput {
  const DanaSplitInput({
    required this.danaDasarPembagian,
    required this.mode,
    this.danaPlusAktif = true,
    this.persenBiasaBp = 5000,
    this.nominalBufferBiasa = 0,
    this.targetNominalPlus = 0,
    this.manualBiasa = 0,
    this.manualPlus = 0,
    this.sisaAnggaranAktual,
    this.hariTersisaPeriode = 30,
    this.hariSampaiTopUpBerikutnya,
    this.transaksiTerjadwalBelumTermasuk = 0,
    this.bufferKeamanan = 0,
    this.batasDanaPlus,
    this.saldoAwalDanaPlus = 0,
    this.pembulatan = RoundingOption.tanpa,
  });

  /// Total bulanan ATAU nominal top-up saat ini (§91 — jangan dicampur).
  final int danaDasarPembagian;
  final DanaSplitMode mode;

  /// False jika pengguna tidak menggunakan/tidak tersedia (§88).
  final bool danaPlusAktif;

  /// Mode persentase (§87 Mode 2), basis points; plus = residu.
  final int persenBiasaBp;

  /// Mode 3: buffer tetap DANA Biasa.
  final int nominalBufferBiasa;

  /// Mode 4: target tetap DANA+.
  final int targetNominalPlus;

  /// Mode 5: nominal manual keduanya.
  final int manualBiasa;
  final int manualPlus;

  // Smart Liquidity (§87 Mode 1).
  final int? sisaAnggaranAktual;
  final int hariTersisaPeriode;
  final int? hariSampaiTopUpBerikutnya;
  final int transaksiTerjadwalBelumTermasuk;
  final int bufferKeamanan;

  /// Batas saldo DANA+ dari pengguna (§88); null = tanpa batas.
  final int? batasDanaPlus;
  final int saldoAwalDanaPlus;
  final RoundingOption pembulatan;
}

class DanaSplitResult {
  const DanaSplitResult({
    required this.saldoBiasa,
    required this.saldoPlus,
    required this.mode,
    this.hariHorizon,
    this.kebutuhanDanaBiasa,
    this.kelebihanDialihkan = 0,
    this.manualTidakSama = false,
  });

  final int saldoBiasa;
  final int saldoPlus;
  final DanaSplitMode mode;

  /// Terisi hanya utk Smart Liquidity (alasan rekomendasi §89).
  final int? hariHorizon;
  final int? kebutuhanDanaBiasa;

  /// Nominal DANA+ yang dialihkan ke Biasa karena batas pengguna (§90).
  final int kelebihanDialihkan;

  /// Mode manual: jumlah ≠ dana eksekusi → TIDAK boleh disimpan (§90).
  final bool manualTidakSama;

  int get total => saldoBiasa + saldoPlus;
}

class DanaSplitService {
  const DanaSplitService();

  DanaSplitResult hitung(DanaSplitInput input) {
    final dana = input.danaDasarPembagian;

    // §88: tanpa DANA+ seluruh dana ke Saldo Biasa.
    if (!input.danaPlusAktif) {
      return DanaSplitResult(
          saldoBiasa: dana, saldoPlus: 0, mode: input.mode);
    }

    return switch (input.mode) {
      DanaSplitMode.smartLiquidity => _smartLiquidity(input, dana),
      DanaSplitMode.persentase => _persentase(input, dana),
      DanaSplitMode.nominalTetapBiasa => _nominalTetapBiasa(input, dana),
      DanaSplitMode.nominalTetapPlus => _nominalTetapPlus(input, dana),
      DanaSplitMode.manual => _manual(input, dana),
    };
  }

  DanaSplitResult _smartLiquidity(DanaSplitInput input, int dana) {
    // §87: horizon = min(7, hari tersisa, hari sampai top-up berikutnya).
    var horizon = input.hariTersisaPeriode < 7 ? input.hariTersisaPeriode : 7;
    final sampaiTopUp = input.hariSampaiTopUpBerikutnya;
    if (sampaiTopUp != null && sampaiTopUp < horizon) horizon = sampaiTopUp;
    if (horizon < 0) horizon = 0;

    final sisaAnggaran = input.sisaAnggaranAktual ?? dana;
    final anggaranHorizon = input.hariTersisaPeriode <= 0
        ? sisaAnggaran
        : (sisaAnggaran ~/ input.hariTersisaPeriode) * horizon;
    final kebutuhan = anggaranHorizon +
        input.transaksiTerjadwalBelumTermasuk +
        input.bufferKeamanan;

    // §87: kebutuhan > dana → seluruhnya Biasa, Plus Rp0, tanpa negatif.
    final targetPlusMentah = dana - kebutuhan;
    return _finalisasi(
      input: input,
      dana: dana,
      targetPlusMentah: targetPlusMentah < 0 ? 0 : targetPlusMentah,
      hariHorizon: horizon,
      kebutuhanDanaBiasa: kebutuhan,
    );
  }

  DanaSplitResult _persentase(DanaSplitInput input, int dana) {
    final biasa = (dana * input.persenBiasaBp) ~/ 10000;
    return _finalisasi(
        input: input, dana: dana, targetPlusMentah: dana - biasa);
  }

  DanaSplitResult _nominalTetapBiasa(DanaSplitInput input, int dana) {
    final biasa =
        input.nominalBufferBiasa < dana ? input.nominalBufferBiasa : dana;
    return _finalisasi(
        input: input, dana: dana, targetPlusMentah: dana - biasa);
  }

  DanaSplitResult _nominalTetapPlus(DanaSplitInput input, int dana) {
    final plus =
        input.targetNominalPlus < dana ? input.targetNominalPlus : dana;
    return _finalisasi(input: input, dana: dana, targetPlusMentah: plus);
  }

  DanaSplitResult _manual(DanaSplitInput input, int dana) {
    // §90: jumlah manual ≠ dana eksekusi adalah error, bukan penyesuaian.
    if (input.manualBiasa + input.manualPlus != dana ||
        input.manualBiasa < 0 ||
        input.manualPlus < 0) {
      return DanaSplitResult(
        saldoBiasa: input.manualBiasa,
        saldoPlus: input.manualPlus,
        mode: input.mode,
        manualTidakSama: true,
      );
    }
    return _finalisasi(
        input: input, dana: dana, targetPlusMentah: input.manualPlus);
  }

  /// Urutan §91: batasi plus (dana + ruang batas) → floor kelipatan →
  /// cek batas lagi → biasa = residual.
  DanaSplitResult _finalisasi({
    required DanaSplitInput input,
    required int dana,
    required int targetPlusMentah,
    int? hariHorizon,
    int? kebutuhanDanaBiasa,
  }) {
    var plus = targetPlusMentah.clamp(0, dana);
    var kelebihan = 0;

    final batas = input.batasDanaPlus;
    if (batas != null) {
      final ruang = batas - input.saldoAwalDanaPlus;
      final ruangEfektif = ruang < 0 ? 0 : ruang;
      if (plus > ruangEfektif) {
        kelebihan = plus - ruangEfektif; // dialihkan ke Biasa (§90)
        plus = ruangEfektif;
      }
    }

    plus = input.pembulatan.floorKe(plus);

    // Pemeriksaan akhir batas setelah pembulatan (§91 langkah 5).
    if (batas != null && input.saldoAwalDanaPlus + plus > batas) {
      plus = input.pembulatan.floorKe(batas - input.saldoAwalDanaPlus);
      if (plus < 0) plus = 0;
    }

    return DanaSplitResult(
      saldoBiasa: dana - plus,
      saldoPlus: plus,
      mode: input.mode,
      hariHorizon: hariHorizon,
      kebutuhanDanaBiasa: kebutuhanDanaBiasa,
      kelebihanDialihkan: kelebihan,
    );
  }
}

/// Validasi pembagian (§90); hasil dengan pelanggaran tidak boleh disimpan.
class DanaSplitValidator {
  const DanaSplitValidator();

  List<String> validasi({
    required DanaSplitInput input,
    required DanaSplitResult hasil,
    int akumulasiEksekusiSebelumnya = 0,
    int? totalAlokasiDanaBulanan,
  }) {
    final v = <String>[];
    if (hasil.manualTidakSama) v.add('manualTidakSama');
    if (hasil.saldoBiasa < 0) v.add('biasaNegatif');
    if (hasil.saldoPlus < 0) v.add('plusNegatif');
    if (hasil.total != input.danaDasarPembagian) v.add('totalTidakSama');
    if (!input.danaPlusAktif && hasil.saldoPlus != 0) {
      v.add('plusHarusNolSaatNonaktif');
    }
    final batas = input.batasDanaPlus;
    if (batas != null && input.saldoAwalDanaPlus + hasil.saldoPlus > batas) {
      v.add('melampauiBatasPengguna');
    }
    // §90: akumulasi eksekusi bulan aktif ≤ total alokasi DANA bulanan.
    if (totalAlokasiDanaBulanan != null &&
        akumulasiEksekusiSebelumnya + input.danaDasarPembagian >
            totalAlokasiDanaBulanan) {
      v.add('akumulasiMelebihiBulanan');
    }
    return v;
  }
}

/// Ledger saldo DANA periode berjalan (§94).
class DanaLedgerResult {
  const DanaLedgerResult({
    required this.saldoAkhirBiasa,
    required this.saldoAkhirPlus,
    required this.realisasiPlus,
  });

  final int saldoAkhirBiasa;
  final int saldoAkhirPlus;

  /// Realisasi target = total pemindahan KE DANA+ bulan aktif (§94) —
  /// bukan saldo akun.
  final int realisasiPlus;
}

class DanaLedgerService {
  const DanaLedgerService();

  DanaLedgerResult hitung({
    required int saldoAwalBiasa,
    required int saldoAwalPlus,
    required int topUpKeBiasa,
    required int pindahKePlus,
    required int pindahDariPlus,
    required int pengeluaranBiasa,
    required int pengeluaranPlus,
    required int rewardAktual,
  }) {
    return DanaLedgerResult(
      saldoAkhirBiasa: saldoAwalBiasa +
          topUpKeBiasa +
          pindahDariPlus -
          pengeluaranBiasa -
          pindahKePlus,
      saldoAkhirPlus: saldoAwalPlus +
          pindahKePlus +
          rewardAktual -
          pengeluaranPlus -
          pindahDariPlus,
      realisasiPlus: pindahKePlus,
    );
  }
}

/// Simulasi pertumbuhan DANA+ (§95); tingkat WAJIB dari input pengguna.
enum RewardRatePeriod { perHari, perBulan, perTahun }

class DanaPlusRewardSimulator {
  const DanaPlusRewardSimulator();

  /// Estimasi pertumbuhan selama [jumlahPeriode] satuan [satuan];
  /// [tingkatBp] = basis points per satuan. Metode sederhana atau majemuk.
  int estimasiPertumbuhan({
    required int saldoAwal,
    required int tingkatBp,
    required int jumlahPeriode,
    bool majemuk = false,
  }) {
    if (saldoAwal <= 0 || tingkatBp <= 0 || jumlahPeriode <= 0) return 0;
    if (!majemuk) {
      return (saldoAwal * tingkatBp * jumlahPeriode) ~/ 10000;
    }
    var saldo = saldoAwal;
    for (var i = 0; i < jumlahPeriode; i++) {
      saldo += (saldo * tingkatBp) ~/ 10000;
    }
    return saldo - saldoAwal;
  }
}
