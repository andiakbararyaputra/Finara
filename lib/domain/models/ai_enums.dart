/// Enum khusus modul Finara AI (§34, §44, §47).
library;

/// Cakupan data keuangan yang boleh dikirim ke provider (§44).
enum AIDataScope { tanpaAkses, bulanAktif, tigaBulan, enamBulan }

/// Mode Allowed Models (§34).
enum AllowedModelsMode { izinkanSemua, hanyaTertentu, hanyaFavorit }

/// Perilaku fallback model (§37): otomatis, konfirmasi dulu, atau nonaktif.
enum FallbackMode { otomatis, konfirmasi, nonaktif }

/// Retensi riwayat percakapan (§47).
enum ChatRetention { simpanSelamanya, hari7, hari30, hari90 }
