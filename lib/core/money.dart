import 'package:flutter/services.dart';

/// Seluruh nominal Rupiah disimpan sebagai bilangan bulat tanpa desimal.
/// Format tampilan: Rp300.000 (pemisah ribuan titik, tanpa spasi).
String formatRupiah(int amount) {
  final sign = amount < 0 ? '-' : '';
  final digits = amount.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    buffer.write(digits[i]);
    final remaining = digits.length - i;
    if (remaining > 1 && remaining % 3 == 1) {
      buffer.write('.');
    }
  }
  return '${sign}Rp$buffer';
}

/// Mengambil nilai bulat dari teks berformat Rupiah.
/// Mengembalikan null jika tidak ada digit sama sekali.
int? parseRupiah(String text) {
  final negative = text.trimLeft().startsWith('-');
  final digits = text.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) {
    return null;
  }
  final value = int.parse(digits);
  return negative ? -value : value;
}

/// Menambahkan pemisah ribuan secara otomatis saat pengguna mengetik nominal.
class RupiahInputFormatter extends TextInputFormatter {
  const RupiahInputFormatter({this.maxDigits = 15});

  final int maxDigits;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return const TextEditingValue(text: '');
    }
    if (digits.length > maxDigits) {
      return oldValue;
    }
    final normalized = int.parse(digits).toString();
    final buffer = StringBuffer();
    for (var i = 0; i < normalized.length; i++) {
      buffer.write(normalized[i]);
      final remaining = normalized.length - i;
      if (remaining > 1 && remaining % 3 == 1) {
        buffer.write('.');
      }
    }
    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
