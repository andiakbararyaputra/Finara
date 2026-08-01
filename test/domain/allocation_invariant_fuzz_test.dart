/// Fuzz test invarian (§53, §60): seed tetap agar deterministik.
/// Setiap input acak yang lolos validasi input harus menghasilkan hasil
/// tanpa pelanggaran invarian, kecuali blokir langganan §14 yang memang
/// diharapkan terdeteksi.
library;

import 'dart:math';

import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/models/allocation_violation.dart';
import 'package:finara/domain/services/allocation_engine.dart';
import 'package:finara/domain/services/allocation_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const engine = AllocationEngine();
  const validator = AllocationValidator();
  final random = Random(20260801); // seed tetap

  List<int> bagiSeratusPersen(int bagian) {
    final potong = List<int>.generate(
        bagian - 1, (_) => random.nextInt(10001))
      ..sort();
    final hasil = <int>[];
    var sebelumnya = 0;
    for (final p in potong) {
      hasil.add(p - sebelumnya);
      sebelumnya = p;
    }
    hasil.add(10000 - sebelumnya);
    return hasil;
  }

  AllocationInput inputAcak() {
    final utama = 1000000 + random.nextInt(50000000);
    final kas = random.nextInt(utama ~/ 3);
    final jumlahWajib = random.nextInt(4);
    final wajib = <MandatoryExpenseInput>[];
    var totalWajib = 0;
    final sisaUntukWajib = utama - kas;
    for (var i = 0; i < jumlahWajib; i++) {
      final maks = (sisaUntukWajib - totalWajib) ~/ 2;
      if (maks <= 0) break;
      final nominal = random.nextInt(maks);
      totalWajib += nominal;
      wajib.add(MandatoryExpenseInput(
        nama: 'W$i',
        nominal: nominal,
        dihitungDasarDanaDarurat: random.nextBool(),
      ));
    }

    final utamaBp = bagiSeratusPersen(3);
    final investasiInternal = bagiSeratusPersen(2);
    final subJago = bagiSeratusPersen(3);

    final langganan = <SubscriptionInput>[
      for (var i = 0; i < random.nextInt(3); i++)
        SubscriptionInput(
          id: 'L$i',
          nama: 'L$i',
          siklus: random.nextBool()
              ? SubscriptionCycle.bulanan
              : SubscriptionCycle.tahunan,
          nominal: random.nextInt(500000),
          bulanTagihan: 1 + random.nextInt(12),
          metodeTahunan: random.nextBool()
              ? AnnualFundingMethod.cadanganBulanan
              : AnnualFundingMethod.bayarSaatJatuhTempo,
          sumberAnggaran: random.nextBool()
              ? SubscriptionFundingSource.kantongLanggananJago
              : SubscriptionFundingSource.kantongPengeluaranWajib,
          saldoCadanganAwal: random.nextInt(300000),
        ),
    ];

    return AllocationInput(
      tahun: 2024 + random.nextInt(4),
      bulan: 1 + random.nextInt(12),
      penghasilanUtama: utama,
      penghasilanTambahan: [
        for (var i = 0; i < random.nextInt(3); i++)
          IncomeSourceInput(
            nama: 'T$i',
            nominal: random.nextInt(5000000),
            disertakanBulanAktif: random.nextBool(),
          ),
      ],
      kasPeganganBrimo: kas,
      pengeluaranWajib: wajib,
      jagoBp: utamaBp[0],
      investasiBp: utamaBp[1],
      danaBp: utamaBp[2],
      bibitBp: investasiInternal[0],
      stockbitBp: investasiInternal[1],
      pembulatan: RoundingOption
          .values[random.nextInt(RoundingOption.values.length)],
      metodeSubJago: JagoSubAllocationMethod
          .values[random.nextInt(JagoSubAllocationMethod.values.length)],
      subJagoLanggananBp: subJago[0],
      subJagoDaruratBp: subJago[1],
      subJagoOperasionalBp: subJago[2],
      langganan: langganan,
      danaDarurat: random.nextBool()
          ? EmergencyFundInput(
              targetJumlahBulan: random.nextInt(13),
              saldoSaatIni: random.nextInt(10000000),
            )
          : null,
      frekuensiTopUpDana: DanaTopUpFrequency
          .values[random.nextInt(DanaTopUpFrequency.values.length)],
      hariTopUpMingguan: DateTime.monday + random.nextInt(7),
    );
  }

  test('1000 input acak: semua invarian terpenuhi setelah pembulatan', () {
    var diuji = 0;
    var diblokirLangganan = 0;
    for (var i = 0; i < 1000; i++) {
      final input = inputAcak();
      if (validator.validasiInput(input).isNotEmpty) continue;
      diuji++;
      final hasil = engine.hitung(input);
      final pelanggaran = validator.validasiHasil(input, hasil);

      final hanyaBlokirLangganan = pelanggaran.every((p) =>
          p.code ==
          AllocationViolationCode.kebutuhanLanggananMelebihiAlokasiJago);
      if (pelanggaran.isNotEmpty && hanyaBlokirLangganan) {
        diblokirLangganan++;
        continue; // blokir §14 adalah perilaku benar, bukan bug invarian
      }

      expect(pelanggaran, isEmpty,
          reason: 'iterasi $i: $pelanggaran\n'
              'pendapatan=${hasil.totalPendapatan} '
              'bersih=${hasil.danaBersih} '
              'jago=${hasil.alokasiJago} '
              'investasi=${hasil.totalAlokasiInvestasi} '
              'dana=${hasil.alokasiDana}');
      expect(hasil.selisihBelumDialokasikan, 0, reason: 'iterasi $i');
      expect(hasil.alokasiBibit + hasil.alokasiStockbit,
          hasil.totalAlokasiInvestasi,
          reason: 'iterasi $i');
    }
    // Pastikan cakupan fuzz bermakna.
    expect(diuji, greaterThan(500));
    expect(diuji - diblokirLangganan, greaterThan(300));
  });
}
