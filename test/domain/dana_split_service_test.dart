import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/services/dana_split_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = DanaSplitService();
  const validator = DanaSplitValidator();

  group('Smart Liquidity (§87 Mode 1)', () {
    test('horizon min(7, hari tersisa, sampai top-up berikutnya)', () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 1000000,
        mode: DanaSplitMode.smartLiquidity,
        sisaAnggaranAktual: 900000,
        hariTersisaPeriode: 30,
        hariSampaiTopUpBerikutnya: 5,
      ));
      expect(hasil.hariHorizon, 5);
      // 900000~/30=30000 × 5 = 150000 kebutuhan → plus 850000.
      expect(hasil.kebutuhanDanaBiasa, 150000);
      expect(hasil.saldoPlus, 850000);
      expect(hasil.saldoBiasa, 150000);
      expect(hasil.total, 1000000);
    });

    test('transaksi terjadwal + buffer menambah kebutuhan', () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 1000000,
        mode: DanaSplitMode.smartLiquidity,
        sisaAnggaranAktual: 700000,
        hariTersisaPeriode: 7,
        transaksiTerjadwalBelumTermasuk: 200000,
        bufferKeamanan: 50000,
      ));
      // 700000/7×7 = 700000 + 200000 + 50000 = 950000 → plus 50000.
      expect(hasil.saldoPlus, 50000);
      expect(hasil.saldoBiasa, 950000);
    });

    test('kebutuhan melebihi dana: seluruhnya Biasa, Plus Rp0, tanpa negatif',
        () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 300000,
        mode: DanaSplitMode.smartLiquidity,
        sisaAnggaranAktual: 900000,
        hariTersisaPeriode: 7,
        bufferKeamanan: 100000,
      ));
      expect(hasil.saldoPlus, 0);
      expect(hasil.saldoBiasa, 300000);
    });

    test('horizon akhir bulan: hari tersisa < 7', () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 500000,
        mode: DanaSplitMode.smartLiquidity,
        sisaAnggaranAktual: 300000,
        hariTersisaPeriode: 3,
      ));
      expect(hasil.hariHorizon, 3);
      expect(hasil.total, 500000);
    });
  });

  group('Mode persentase/nominal/manual (§87)', () {
    test('persentase: biasa dari bp, plus residual', () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 1000001,
        mode: DanaSplitMode.persentase,
        persenBiasaBp: 6000,
      ));
      expect(hasil.saldoBiasa, 600000);
      expect(hasil.saldoPlus, 400001); // residu selisih integer di Plus
      expect(hasil.total, 1000001);
    });

    test('nominal tetap Biasa melebihi dana → dibatasi dana', () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 200000,
        mode: DanaSplitMode.nominalTetapBiasa,
        nominalBufferBiasa: 500000,
      ));
      expect(hasil.saldoBiasa, 200000);
      expect(hasil.saldoPlus, 0);
    });

    test('nominal tetap Plus melebihi dana → dibatasi dana', () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 200000,
        mode: DanaSplitMode.nominalTetapPlus,
        targetNominalPlus: 500000,
      ));
      expect(hasil.saldoPlus, 200000);
      expect(hasil.saldoBiasa, 0);
    });

    test('manual: jumlah tidak sama = error, tidak boleh disimpan (§90)', () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 100000,
        mode: DanaSplitMode.manual,
        manualBiasa: 50000,
        manualPlus: 40000,
      ));
      expect(hasil.manualTidakSama, isTrue);
      expect(
        validator.validasi(
            input: const DanaSplitInput(
                danaDasarPembagian: 100000,
                mode: DanaSplitMode.manual,
                manualBiasa: 50000,
                manualPlus: 40000),
            hasil: hasil),
        contains('manualTidakSama'),
      );
    });

    test('manual valid diterima', () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 100000,
        mode: DanaSplitMode.manual,
        manualBiasa: 60000,
        manualPlus: 40000,
      ));
      expect(hasil.manualTidakSama, isFalse);
      expect(hasil.saldoPlus, 40000);
    });
  });

  group('Batas DANA+ dan pembulatan (§90–§91)', () {
    test('kelebihan dialihkan ke Biasa saat melebihi ruang batas', () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 1000000,
        mode: DanaSplitMode.persentase,
        persenBiasaBp: 2000, // plus mentah 800000
        batasDanaPlus: 2000000,
        saldoAwalDanaPlus: 1500000, // ruang 500000
      ));
      expect(hasil.saldoPlus, 500000);
      expect(hasil.kelebihanDialihkan, 300000);
      expect(hasil.saldoBiasa, 500000);
      expect(hasil.total, 1000000);
    });

    test('pembulatan: floor DANA+, Biasa menyerap sisa (§91)', () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 1000000,
        mode: DanaSplitMode.persentase,
        persenBiasaBp: 3333, // plus mentah 666700
        pembulatan: RoundingOption.sepuluhRibu,
      ));
      expect(hasil.saldoPlus % 10000, 0);
      expect(hasil.saldoPlus, 660000);
      expect(hasil.saldoBiasa, 340000);
      expect(hasil.total, 1000000);
    });

    test('DANA+ nonaktif: seluruh dana ke Biasa (§88)', () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 750000,
        mode: DanaSplitMode.persentase,
        danaPlusAktif: false,
      ));
      expect(hasil.saldoBiasa, 750000);
      expect(hasil.saldoPlus, 0);
    });

    test('dana nol: keduanya nol tanpa error', () {
      final hasil = service.hitung(const DanaSplitInput(
        danaDasarPembagian: 0,
        mode: DanaSplitMode.smartLiquidity,
        sisaAnggaranAktual: 0,
        hariTersisaPeriode: 30,
      ));
      expect(hasil.saldoBiasa, 0);
      expect(hasil.saldoPlus, 0);
    });

    test('akumulasi eksekusi melebihi bulanan terdeteksi validator (§90)',
        () {
      const input = DanaSplitInput(
        danaDasarPembagian: 400000,
        mode: DanaSplitMode.persentase,
      );
      final hasil = service.hitung(input);
      expect(
        validator.validasi(
          input: input,
          hasil: hasil,
          akumulasiEksekusiSebelumnya: 700000,
          totalAlokasiDanaBulanan: 1000000,
        ),
        contains('akumulasiMelebihiBulanan'),
      );
    });
  });

  group('Ledger (§94)', () {
    const ledger = DanaLedgerService();

    test('saldo akhir kedua kantong + realisasi = pemindahan ke DANA+', () {
      final hasil = ledger.hitung(
        saldoAwalBiasa: 100000,
        saldoAwalPlus: 500000,
        topUpKeBiasa: 400000,
        pindahKePlus: 150000,
        pindahDariPlus: 50000,
        pengeluaranBiasa: 200000,
        pengeluaranPlus: 0,
        rewardAktual: 2000,
      );
      expect(hasil.saldoAkhirBiasa, 100000 + 400000 + 50000 - 200000 - 150000);
      expect(hasil.saldoAkhirPlus, 500000 + 150000 + 2000 - 0 - 50000);
      // Saldo awal & reward BUKAN realisasi target (§94).
      expect(hasil.realisasiPlus, 150000);
    });
  });

  group('Simulasi reward (§95)', () {
    const sim = DanaPlusRewardSimulator();

    test('metode sederhana', () {
      // 1 jt, 0,5%/bulan (50bp), 12 bulan → 60.000.
      expect(
        sim.estimasiPertumbuhan(
            saldoAwal: 1000000, tingkatBp: 50, jumlahPeriode: 12),
        60000,
      );
    });

    test('metode majemuk > sederhana', () {
      final majemuk = sim.estimasiPertumbuhan(
          saldoAwal: 1000000, tingkatBp: 100, jumlahPeriode: 12, majemuk: true);
      final sederhana = sim.estimasiPertumbuhan(
          saldoAwal: 1000000, tingkatBp: 100, jumlahPeriode: 12);
      expect(majemuk, greaterThan(sederhana));
    });

    test('tingkat/saldo nol → 0 (tanpa reward yang dikarang)', () {
      expect(
        sim.estimasiPertumbuhan(
            saldoAwal: 0, tingkatBp: 100, jumlahPeriode: 12),
        0,
      );
      expect(
        sim.estimasiPertumbuhan(
            saldoAwal: 1000000, tingkatBp: 0, jumlahPeriode: 12),
        0,
      );
    });
  });
}
