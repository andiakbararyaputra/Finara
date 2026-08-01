import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/services/dana_schedule_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = DanaScheduleService();

  test('harian: sisa integer ke hari terakhir, total tepat (§17)', () {
    final hasil = service.hitung(
      totalAlokasiDana: 1000000,
      tahun: 2026,
      bulan: 2, // 28 hari
      frekuensi: DanaTopUpFrequency.harian,
      hariTopUpMingguan: DateTime.monday,
    );
    expect(hasil.jadwalTopUp, hasLength(28));
    expect(hasil.uangJajanHarianDasar, 1000000 ~/ 28);
    final total =
        hasil.jadwalTopUp.fold<int>(0, (sum, e) => sum + e.nominal);
    expect(total, 1000000);
    // Semua hari kecuali terakhir sama besar.
    final dasar = hasil.jadwalTopUp.first.nominal;
    for (final e in hasil.jadwalTopUp.take(27)) {
      expect(e.nominal, dasar);
    }
    expect(hasil.jadwalTopUp.last.nominal, dasar + 1000000 % 28);
  });

  test('mingguan: jumlah kejadian sebenarnya pada bulan aktif', () {
    // Agustus 2026: Senin jatuh pada 3, 10, 17, 24, 31 → 5 kali.
    final hasil = service.hitung(
      totalAlokasiDana: 1000000,
      tahun: 2026,
      bulan: 8,
      frekuensi: DanaTopUpFrequency.mingguan,
      hariTopUpMingguan: DateTime.monday,
    );
    expect(hasil.jadwalTopUp, hasLength(5));
    expect(hasil.jadwalTopUp.first.tanggal.day, 3);
    final total =
        hasil.jadwalTopUp.fold<int>(0, (sum, e) => sum + e.nominal);
    expect(total, 1000000);
    expect(hasil.jadwalTopUp.last.nominal, 200000);
  });

  test('mingguan 4 kejadian: sisa ke top-up terakhir', () {
    // Agustus 2026: Jumat jatuh pada 7, 14, 21, 28 → 4 kali.
    final hasil = service.hitung(
      totalAlokasiDana: 1000003,
      tahun: 2026,
      bulan: 8,
      frekuensi: DanaTopUpFrequency.mingguan,
      hariTopUpMingguan: DateTime.friday,
    );
    expect(hasil.jadwalTopUp, hasLength(4));
    expect(hasil.jadwalTopUp.last.nominal, 250000 + 3);
    final total =
        hasil.jadwalTopUp.fold<int>(0, (sum, e) => sum + e.nominal);
    expect(total, 1000003);
  });

  test('sekaligus: satu entri sebesar total', () {
    final hasil = service.hitung(
      totalAlokasiDana: 750000,
      tahun: 2026,
      bulan: 8,
      frekuensi: DanaTopUpFrequency.sekaligus,
      hariTopUpMingguan: DateTime.monday,
    );
    expect(hasil.jadwalTopUp, hasLength(1));
    expect(hasil.jadwalTopUp.single.nominal, 750000);
  });

  test('anggaran 7 hari = harian dasar × min(7, hari)', () {
    final hasil = service.hitung(
      totalAlokasiDana: 3100000,
      tahun: 2026,
      bulan: 8, // 31 hari
      frekuensi: DanaTopUpFrequency.harian,
      hariTopUpMingguan: DateTime.monday,
    );
    expect(hasil.anggaranTujuhHari, (3100000 ~/ 31) * 7);
  });

  test('alokasi nol: jadwal nol tanpa error', () {
    final hasil = service.hitung(
      totalAlokasiDana: 0,
      tahun: 2026,
      bulan: 8,
      frekuensi: DanaTopUpFrequency.harian,
      hariTopUpMingguan: DateTime.monday,
    );
    expect(
        hasil.jadwalTopUp.fold<int>(0, (sum, e) => sum + e.nominal), 0);
  });
}
