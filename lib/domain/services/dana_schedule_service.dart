/// Jadwal eksekusi Alokasi DANA (§17): pembagian integer, sisa nominal
/// didistribusikan ke periode terakhir agar total tepat sama.
library;

import '../models/allocation_input.dart';
import '../models/allocation_result.dart';

class DanaScheduleService {
  const DanaScheduleService();

  DanaScheduleResult hitung({
    required int totalAlokasiDana,
    required int tahun,
    required int bulan,
    required DanaTopUpFrequency frekuensi,
    required int hariTopUpMingguan,
  }) {
    final jumlahHari = DateTime(tahun, bulan + 1, 0).day;
    final harianDasar = totalAlokasiDana ~/ jumlahHari;
    final anggaranTujuhHari =
        harianDasar * (jumlahHari < 7 ? jumlahHari : 7);

    final jadwal = switch (frekuensi) {
      DanaTopUpFrequency.harian => _jadwalHarian(
          totalAlokasiDana, tahun, bulan, jumlahHari),
      DanaTopUpFrequency.mingguan => _jadwalMingguan(
          totalAlokasiDana, tahun, bulan, jumlahHari, hariTopUpMingguan),
      DanaTopUpFrequency.sekaligus => [
          DanaTopUpEntry(
            tanggal: DateTime(tahun, bulan, 1),
            nominal: totalAlokasiDana,
          ),
        ],
    };

    return DanaScheduleResult(
      frekuensi: frekuensi,
      totalAlokasiDana: totalAlokasiDana,
      uangJajanHarianDasar: harianDasar,
      anggaranTujuhHari: anggaranTujuhHari,
      jadwalTopUp: List.unmodifiable(jadwal),
    );
  }

  List<DanaTopUpEntry> _jadwalHarian(
    int total,
    int tahun,
    int bulan,
    int jumlahHari,
  ) {
    final dasar = total ~/ jumlahHari;
    final sisa = total % jumlahHari;
    return [
      for (var hari = 1; hari <= jumlahHari; hari++)
        DanaTopUpEntry(
          tanggal: DateTime(tahun, bulan, hari),
          nominal: dasar + (hari == jumlahHari ? sisa : 0),
        ),
    ];
  }

  List<DanaTopUpEntry> _jadwalMingguan(
    int total,
    int tahun,
    int bulan,
    int jumlahHari,
    int hariMinggu,
  ) {
    final tanggalTopUp = <DateTime>[
      for (var hari = 1; hari <= jumlahHari; hari++)
        if (DateTime(tahun, bulan, hari).weekday == hariMinggu)
          DateTime(tahun, bulan, hari),
    ];
    // Setiap hari dalam pekan muncul minimal 4 kali per bulan.
    final jumlahTopUp = tanggalTopUp.length;
    final dasar = total ~/ jumlahTopUp;
    final sisa = total % jumlahTopUp;
    return [
      for (var i = 0; i < jumlahTopUp; i++)
        DanaTopUpEntry(
          tanggal: tanggalTopUp[i],
          nominal: dasar + (i == jumlahTopUp - 1 ? sisa : 0),
        ),
    ];
  }
}
