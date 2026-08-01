/// Aturan Allowed Models (§34), fallback (§37), dan estimasi biaya (§39).
/// Pure Dart, deterministik.
library;

import '../models/ai_enums.dart';
import 'ai_models.dart';

/// Ringkasan status satu model untuk evaluasi aturan.
class ModelPolicyInfo {
  const ModelPolicyInfo({
    required this.modelId,
    this.favorit = false,
    this.diblokir = false,
    this.diizinkan = false,
    this.statusChat = CapabilityStatus.unknown,
    this.statusStreaming = CapabilityStatus.unknown,
  });

  final String modelId;
  final bool favorit;
  final bool diblokir;
  final bool diizinkan;
  final CapabilityStatus statusChat;
  final CapabilityStatus statusStreaming;
}

class AllowedModelsService {
  const AllowedModelsService();

  /// Urutan prioritas §34: blokir selalu menang; lalu mode allowlist;
  /// lalu mode favorit.
  bool bolehDipakai(AllowedModelsMode mode, ModelPolicyInfo model) {
    if (model.diblokir) return false;
    return switch (mode) {
      AllowedModelsMode.izinkanSemua => true,
      AllowedModelsMode.hanyaTertentu => model.diizinkan,
      AllowedModelsMode.hanyaFavorit => model.favorit,
    };
  }

  /// Pemilihan otomatis (§34 aturan 4, §36): hanya model diizinkan dengan
  /// kemampuan chat sudah VERIFIED. Null = tidak ada; minta pengguna
  /// memilih manual atau menjalankan tes.
  String? pilihOtomatis(
    AllowedModelsMode mode,
    List<ModelPolicyInfo> kandidat, {
    bool butuhStreaming = false,
  }) {
    for (final m in kandidat) {
      if (!bolehDipakai(mode, m)) continue;
      if (m.statusChat != CapabilityStatus.verified) continue;
      if (butuhStreaming && m.statusStreaming != CapabilityStatus.verified) {
        continue;
      }
      return m.modelId;
    }
    return null;
  }
}

/// Rantai fallback (§37): utama → cadangan1 → cadangan2.
class FallbackService {
  const FallbackService();

  /// Error yang memenuhi syarat fallback (§37); API key tidak valid TIDAK
  /// memicu fallback pada provider yang sama.
  static const errorLayakFallback = {
    AIErrorKind.modelTidakTersedia,
    AIErrorKind.rateLimit,
    AIErrorKind.modelOverload,
    AIErrorKind.timeout,
  };

  /// Model berikutnya dalam rantai; null jika habis atau error tidak layak.
  /// Model yang diblokir/tidak diizinkan dilewati (§34 tetap berlaku).
  String? modelBerikutnya({
    required String modelGagal,
    required AIErrorKind error,
    required String? fallback1,
    required String? fallback2,
    required AllowedModelsMode mode,
    required List<ModelPolicyInfo> daftarModel,
  }) {
    if (!errorLayakFallback.contains(error)) return null;
    const allowed = AllowedModelsService();
    final rantai = [fallback1, fallback2];
    final mulaiDari = modelGagal == fallback1 ? 1 : 0;
    for (var i = mulaiDari; i < rantai.length; i++) {
      final kandidatId = rantai[i];
      if (kandidatId == null || kandidatId == modelGagal) continue;
      final info = daftarModel.firstWhere(
        (m) => m.modelId == kandidatId,
        orElse: () => ModelPolicyInfo(modelId: kandidatId),
      );
      if (allowed.bolehDipakai(mode, info)) return kandidatId;
    }
    return null;
  }
}

/// Estimasi token & biaya (§39). Estimasi kasar ~4 karakter/token;
/// tidak pernah menampilkan angka jika harga tidak tersedia.
class CostEstimator {
  const CostEstimator();

  int estimasiToken(String teks) {
    if (teks.isEmpty) return 0;
    return (teks.length + 3) ~/ 4;
  }

  /// Biaya dalam satuan harga yang sama dgn input (per 1 juta token);
  /// null jika harga tidak tersedia (§39: jangan tampilkan estimasi palsu).
  int? estimasiBiaya({
    required int tokenInput,
    required int tokenOutput,
    required int? hargaInputPerJuta,
    required int? hargaOutputPerJuta,
  }) {
    if (hargaInputPerJuta == null || hargaOutputPerJuta == null) return null;
    return (tokenInput * hargaInputPerJuta + tokenOutput * hargaOutputPerJuta) ~/
        1000000;
  }
}
