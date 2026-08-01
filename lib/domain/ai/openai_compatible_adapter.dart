/// Adapter OpenAI-compatible (§27, §29, §41, §48): /models + /chat/completions
/// dengan streaming SSE. API key hanya dipakai sebagai header Authorization
/// dan tidak pernah masuk ke error, log, atau hasil parse (§45).
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'ai_models.dart';
import 'ai_provider_adapter.dart';

class OpenAICompatibleAdapter implements AIProviderAdapter {
  OpenAICompatibleAdapter(this.config, {http.Client? client})
      : _client = client ?? http.Client();

  final AIProviderConfig config;
  final http.Client _client;
  bool _dibatalkan = false;

  Map<String, String> _headers(String apiKey) => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };

  @override
  Future<bool> testConnection({required String apiKey}) async {
    // Validasi URL + kunci lewat endpoint daftar model (§29 langkah 1–3).
    final models = await fetchModels(apiKey: apiKey);
    return models.isNotEmpty;
  }

  @override
  Future<List<AIModelInfo>> fetchModels({required String apiKey}) async {
    if (apiKey.isEmpty) {
      throw const AIProviderException(AIErrorKind.apiKeyKosong);
    }
    final http.Response respons;
    try {
      respons = await _client
          .get(config.modelsUri(), headers: _headers(apiKey))
          .timeout(config.timeout);
    } on TimeoutException {
      throw const AIProviderException(AIErrorKind.timeout);
    } on SocketException {
      throw const AIProviderException(AIErrorKind.tidakAdaInternet);
    }
    if (respons.statusCode != 200) {
      throw parseError(respons.statusCode, respons.body);
    }
    final Map<String, dynamic> json;
    try {
      json = jsonDecode(respons.body) as Map<String, dynamic>;
    } on FormatException {
      throw const AIProviderException(AIErrorKind.responsTidakValid);
    }
    final data = json['data'];
    if (data is! List) {
      throw const AIProviderException(
          AIErrorKind.responsTidakValid, 'field data bukan list');
    }
    return [
      for (final item in data)
        if (item is Map<String, dynamic>) normalizeModel(item),
    ];
  }

  @override
  AIModelInfo normalizeModel(Map<String, dynamic> raw) {
    return AIModelInfo(
      id: '${raw['id']}',
      displayName: raw['display_name'] as String? ?? raw['name'] as String?,
      ownedBy: raw['owned_by'] as String?,
    );
  }

  @override
  Future<bool> testModel(
      {required String apiKey, required String modelId}) async {
    final respons = await sendMessage(
      AIChatRequest(
        model: modelId,
        messages: const [
          AIMessage(
              role: AIRole.user,
              content: AIProviderAdapter.promptTesKoneksi),
        ],
      ),
      apiKey: apiKey,
    );
    return respons.content.isNotEmpty;
  }

  @override
  Future<AIChatResponse> sendMessage(
    AIChatRequest request, {
    required String apiKey,
  }) async {
    if (apiKey.isEmpty) {
      throw const AIProviderException(AIErrorKind.apiKeyKosong);
    }
    final http.Response respons;
    try {
      respons = await _client
          .post(
            config.chatUri(),
            headers: _headers(apiKey),
            body: jsonEncode(buildRequest(request)),
          )
          .timeout(config.timeout);
    } on TimeoutException {
      throw const AIProviderException(AIErrorKind.timeout);
    } on SocketException {
      throw const AIProviderException(AIErrorKind.tidakAdaInternet);
    }
    if (respons.statusCode != 200) {
      throw parseError(respons.statusCode, respons.body);
    }
    try {
      return parseResponse(
          jsonDecode(utf8.decode(respons.bodyBytes)) as Map<String, dynamic>);
    } on FormatException {
      throw const AIProviderException(AIErrorKind.responsTidakValid);
    }
  }

  @override
  Stream<String> streamMessage(
    AIChatRequest request, {
    required String apiKey,
  }) async* {
    if (apiKey.isEmpty) {
      throw const AIProviderException(AIErrorKind.apiKeyKosong);
    }
    _dibatalkan = false;
    final req = http.Request('POST', config.chatUri())
      ..headers.addAll(_headers(apiKey))
      ..body = jsonEncode(
          buildRequest(AIChatRequest(
        model: request.model,
        messages: request.messages,
        temperature: request.temperature,
        maxOutputTokens: request.maxOutputTokens,
        stream: true,
      )));

    final http.StreamedResponse respons;
    try {
      respons = await _client.send(req).timeout(config.timeout);
    } on TimeoutException {
      throw const AIProviderException(AIErrorKind.timeout);
    } on SocketException {
      throw const AIProviderException(AIErrorKind.tidakAdaInternet);
    }
    if (respons.statusCode != 200) {
      final body = await respons.stream.bytesToString();
      throw parseError(respons.statusCode, body);
    }

    var adaChunk = false;
    try {
      await for (final baris in respons.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())) {
        if (_dibatalkan) return;
        final potongan = parseSseLine(baris);
        if (potongan == null) continue;
        adaChunk = true;
        if (potongan.isNotEmpty) yield potongan;
      }
    } on http.ClientException {
      throw const AIProviderException(AIErrorKind.streamingTerputus);
    }
    if (!adaChunk) {
      throw const AIProviderException(AIErrorKind.responsKosong);
    }
  }

  /// Parse satu baris SSE; null = bukan data, '' = data tanpa teks
  /// (mis. [DONE] atau delta kosong).
  static String? parseSseLine(String baris) {
    if (!baris.startsWith('data:')) return null;
    final payload = baris.substring(5).trim();
    if (payload.isEmpty || payload == '[DONE]') return '';
    try {
      final json = jsonDecode(payload) as Map<String, dynamic>;
      final choices = json['choices'] as List?;
      if (choices == null || choices.isEmpty) return '';
      final delta =
          (choices.first as Map<String, dynamic>)['delta'];
      if (delta is! Map<String, dynamic>) return '';
      return delta['content'] as String? ?? '';
    } on FormatException {
      return '';
    }
  }

  @override
  void cancelRequest() => _dibatalkan = true;

  @override
  List<String> validateParameters(AIChatRequest request) {
    // OpenAI-compatible mendukung seluruh parameter opsional yang dipakai F2.
    return const [];
  }

  @override
  Map<String, dynamic> buildRequest(AIChatRequest request) {
    return {
      'model': request.model,
      'messages': [for (final m in request.messages) m.toJson()],
      if (request.temperature != null) 'temperature': request.temperature,
      if (request.maxOutputTokens != null)
        'max_tokens': request.maxOutputTokens,
      if (request.stream) 'stream': true,
    };
  }

  @override
  AIChatResponse parseResponse(Map<String, dynamic> json) {
    final choices = json['choices'] as List?;
    if (choices == null || choices.isEmpty) {
      throw const AIProviderException(AIErrorKind.responsKosong);
    }
    final message =
        (choices.first as Map<String, dynamic>)['message'];
    final content =
        message is Map<String, dynamic> ? message['content'] : null;
    if (content is! String || content.isEmpty) {
      throw const AIProviderException(AIErrorKind.responsKosong);
    }
    return AIChatResponse(content: content, model: json['model'] as String?);
  }

  @override
  AIProviderException parseError(int statusCode, String body) {
    // Ringkas pesan provider tanpa menyertakan header/kredensial.
    String pesan = '';
    try {
      final json = jsonDecode(body) as Map<String, dynamic>;
      final error = json['error'];
      if (error is Map<String, dynamic>) {
        pesan = '${error['message'] ?? ''}';
      }
    } on FormatException {
      // biarkan pesan kosong
    }
    final kind = switch (statusCode) {
      401 || 403 => AIErrorKind.apiKeyDitolak,
      404 => pesan.toLowerCase().contains('model')
          ? AIErrorKind.modelTidakTersedia
          : AIErrorKind.endpointSalah,
      408 => AIErrorKind.timeout,
      413 => AIErrorKind.konteksTerlaluPanjang,
      429 => pesan.toLowerCase().contains('quota')
          ? AIErrorKind.kuotaHabis
          : AIErrorKind.rateLimit,
      500 || 502 || 503 => AIErrorKind.modelOverload,
      _ => AIErrorKind.tidakDiketahui,
    };
    return AIProviderException(kind, 'HTTP $statusCode: $pesan');
  }
}
