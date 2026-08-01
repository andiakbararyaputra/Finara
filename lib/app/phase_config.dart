import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fase pengembangan sesuai Bagian VII spesifikasi.
/// Fitur dari fase yang belum aktif harus disembunyikan, bukan dinonaktifkan.
enum AppPhase {
  fase1,
  fase2,
  fase3,
  fase4;

  bool isAtLeast(AppPhase other) => index >= other.index;
}

/// Fase aktif build saat ini; dinaikkan saat fase berikutnya dirilis.
const AppPhase activeAppPhase = AppPhase.fase1;

final appPhaseProvider = Provider<AppPhase>((ref) => activeAppPhase);
