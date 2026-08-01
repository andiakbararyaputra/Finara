/// Interface adapter provider AI (§55, 11 method). Semua implementasi wajib
/// deterministik pada parsing dan tidak pernah membocorkan API key ke
/// pesan error, log, atau hasil parse.
library;

import 'ai_models.dart';

abstract class AIProviderAdapter {
  /// Prompt tes koneksi standar (§35).
  static const promptTesKoneksi = 'Balas dengan kata: Terhubung.';

  Future<bool> testConnection({required String apiKey});

  Future<List<AIModelInfo>> fetchModels({required String apiKey});

  /// Normalisasi satu entri mentah daftar model provider.
  AIModelInfo normalizeModel(Map<String, dynamic> raw);

  /// Tes chat minimal pada model tertentu (§35); true jika merespons.
  Future<bool> testModel({required String apiKey, required String modelId});

  Future<AIChatResponse> sendMessage(
    AIChatRequest request, {
    required String apiKey,
  });

  /// Stream potongan teks jawaban; selesai saat stream ditutup.
  Stream<String> streamMessage(
    AIChatRequest request, {
    required String apiKey,
  });

  /// Batalkan request berjalan (best effort).
  void cancelRequest();

  /// Validasi parameter terhadap kemampuan provider (§41).
  /// Mengembalikan daftar nama parameter yang dibuang (dengan peringatan UI).
  List<String> validateParameters(AIChatRequest request);

  /// Bangun body request format provider.
  Map<String, dynamic> buildRequest(AIChatRequest request);

  /// Parse body respons non-streaming.
  AIChatResponse parseResponse(Map<String, dynamic> json);

  /// Petakan status/body error ke [AIProviderException].
  AIProviderException parseError(int statusCode, String body);
}
