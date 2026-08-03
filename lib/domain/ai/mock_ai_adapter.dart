/// Adapter tiruan untuk pengujian dan pengembangan (§60) —
/// tidak pernah memanggil jaringan.
library;

import 'dart:async';

import 'ai_models.dart';
import 'ai_provider_adapter.dart';

class MockAIAdapter implements AIProviderAdapter {
  MockAIAdapter({
    this.models = const [
      AIModelInfo(id: 'mock-mini', displayName: 'Mock Mini'),
      AIModelInfo(id: 'mock-pro', displayName: 'Mock Pro'),
    ],
    this.jawaban = 'Terhubung.',
    this.errorKind,
    this.jedaChunk = Duration.zero,
  });

  final List<AIModelInfo> models;
  /// Dapat diubah antar-permintaan (utk uji regenerasi).
  String jawaban;

  /// Jika diisi, semua operasi jaringan melempar error ini.
  final AIErrorKind? errorKind;
  final Duration jedaChunk;

  final List<AIChatRequest> requestLog = [];
  bool dibatalkan = false;

  void _cekError() {
    final kind = errorKind;
    if (kind != null) throw AIProviderException(kind);
  }

  @override
  Future<bool> testConnection({required String apiKey}) async {
    _cekError();
    return true;
  }

  @override
  Future<List<AIModelInfo>> fetchModels({required String apiKey}) async {
    _cekError();
    return models;
  }

  @override
  AIModelInfo normalizeModel(Map<String, dynamic> raw) =>
      AIModelInfo(id: '${raw['id']}');

  @override
  Future<bool> testModel(
      {required String apiKey, required String modelId}) async {
    _cekError();
    return models.any((m) => m.id == modelId);
  }

  @override
  Future<AIChatResponse> sendMessage(
    AIChatRequest request, {
    required String apiKey,
  }) async {
    _cekError();
    requestLog.add(request);
    return AIChatResponse(content: jawaban, model: request.model);
  }

  @override
  Stream<String> streamMessage(
    AIChatRequest request, {
    required String apiKey,
  }) async* {
    _cekError();
    requestLog.add(request);
    dibatalkan = false;
    for (final kata in jawaban.split(' ')) {
      if (dibatalkan) return;
      if (jedaChunk > Duration.zero) {
        await Future<void>.delayed(jedaChunk);
      }
      yield '$kata ';
    }
  }

  @override
  void cancelRequest() => dibatalkan = true;

  @override
  List<String> validateParameters(AIChatRequest request) => const [];

  @override
  Map<String, dynamic> buildRequest(AIChatRequest request) =>
      {'model': request.model};

  @override
  AIChatResponse parseResponse(Map<String, dynamic> json) =>
      AIChatResponse(content: jawaban);

  @override
  AIProviderException parseError(int statusCode, String body) =>
      const AIProviderException(AIErrorKind.tidakDiketahui);
}
