/// Sanitasi konteks sebelum dikirim ke provider AI (§44–§45):
/// buang pola kredensial dan token dari teks yang dibangun aplikasi.
library;

class DataSanitizer {
  const DataSanitizer();

  static final _polaSensitif = <RegExp>[
    RegExp(r'sk-[A-Za-z0-9_\-]{8,}'), // API key gaya OpenAI
    RegExp(r'Bearer\s+\S+', caseSensitive: false),
    RegExp(r'(api[_\s-]?key|authorization)\s*[:=]\s*\S+',
        caseSensitive: false),
    RegExp(r'\b(pin|otp|password|cvv)\b\s*[:=]?\s*\d+',
        caseSensitive: false),
    RegExp(r'\b\d{15,16}\b'), // nomor kartu
  ];

  String bersihkan(String teks) {
    var hasil = teks;
    for (final pola in _polaSensitif) {
      hasil = hasil.replaceAll(pola, '[DIHAPUS]');
    }
    return hasil;
  }
}
