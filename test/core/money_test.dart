import 'package:finara/core/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatRupiah', () {
    test('memformat sesuai contoh spesifikasi', () {
      expect(formatRupiah(300000), 'Rp300.000');
      expect(formatRupiah(1500000), 'Rp1.500.000');
      expect(formatRupiah(10000000), 'Rp10.000.000');
    });

    test('nol dan nilai kecil tanpa pemisah', () {
      expect(formatRupiah(0), 'Rp0');
      expect(formatRupiah(999), 'Rp999');
      expect(formatRupiah(1000), 'Rp1.000');
    });

    test('nilai negatif diberi tanda minus di depan', () {
      expect(formatRupiah(-5000), '-Rp5.000');
    });
  });

  group('parseRupiah', () {
    test('membaca kembali hasil format (round-trip)', () {
      for (final value in [0, 999, 1000, 300000, 1500000, 987654321]) {
        expect(parseRupiah(formatRupiah(value)), value);
      }
    });

    test('menerima berbagai format masukan', () {
      expect(parseRupiah('1.500.000'), 1500000);
      expect(parseRupiah('Rp 1.500.000'), 1500000);
      expect(parseRupiah('1500000'), 1500000);
      expect(parseRupiah('-Rp5.000'), -5000);
    });

    test('tanpa digit menghasilkan null, bukan nol', () {
      expect(parseRupiah(''), isNull);
      expect(parseRupiah('Rp'), isNull);
      expect(parseRupiah('abc'), isNull);
    });
  });

  group('RupiahInputFormatter', () {
    const formatter = RupiahInputFormatter();

    TextEditingValue format(String text) {
      return formatter.formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(text: text),
      );
    }

    test('menambahkan pemisah ribuan saat mengetik', () {
      expect(format('1500000').text, '1.500.000');
      expect(format('300000').text, '300.000');
    });

    test('membuang karakter non-digit', () {
      expect(format('1a2b3').text, '123');
    });

    test('menghapus nol di depan', () {
      expect(format('007000').text, '7.000');
    });

    test('teks kosong tetap kosong', () {
      expect(format('').text, '');
    });

    test('kursor selalu di akhir teks', () {
      final result = format('123456');
      expect(result.selection.baseOffset, result.text.length);
    });
  });
}
