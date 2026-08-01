/// Model data Finara AI (§28–§32, §48). Pure Dart, tanpa dependensi UI.
library;

/// Peran pesan chat.
enum AIRole { system, user, assistant }

class AIMessage {
  const AIMessage({required this.role, required this.content});

  final AIRole role;
  final String content;

  Map<String, dynamic> toJson() =>
      {'role': role.name, 'content': content};
}

/// Konfigurasi koneksi satu provider. API key TIDAK ada di sini —
/// dipasok terpisah saat request agar tidak ikut state/log (§45).
class AIProviderConfig {
  const AIProviderConfig({
    required this.baseUrl,
    this.chatPath = '/chat/completions',
    this.modelsPath = '/models',
    this.timeout = const Duration(seconds: 60),
  });

  final String baseUrl;
  final String chatPath;
  final String modelsPath;
  final Duration timeout;

  Uri chatUri() => Uri.parse('$baseUrl$chatPath');
  Uri modelsUri() => Uri.parse('$baseUrl$modelsPath');
}

class AIChatRequest {
  const AIChatRequest({
    required this.model,
    required this.messages,
    this.temperature,
    this.maxOutputTokens,
    this.stream = false,
  });

  final String model;
  final List<AIMessage> messages;
  final double? temperature;
  final int? maxOutputTokens;
  final bool stream;
}

class AIChatResponse {
  const AIChatResponse({required this.content, this.model});

  final String content;
  final String? model;
}

/// Status kemampuan model (§32). Jangan menebak dari nama model.
enum CapabilityStatus { unknown, claimed, verified, unsupported }

class AIModelInfo {
  const AIModelInfo({
    required this.id,
    this.displayName,
    this.ownedBy,
    this.streaming = CapabilityStatus.unknown,
  });

  final String id;
  final String? displayName;
  final String? ownedBy;
  final CapabilityStatus streaming;

  String get label => displayName ?? id;
}

/// Klasifikasi error provider (§48). Pesan tidak boleh memuat kredensial.
enum AIErrorKind {
  apiKeyKosong,
  apiKeyDitolak,
  endpointSalah,
  modelTidakTersedia,
  tidakAdaInternet,
  timeout,
  rateLimit,
  kuotaHabis,
  responsTidakValid,
  responsKosong,
  konteksTerlaluPanjang,
  streamingTerputus,
  parameterTidakDidukung,
  modelOverload,
  tidakDiketahui,
}

class AIProviderException implements Exception {
  const AIProviderException(this.kind, [this.detail = '']);

  final AIErrorKind kind;

  /// Detail teknis TANPA nilai sensitif (sudah disanitasi adapter).
  final String detail;

  @override
  String toString() => 'AIProviderException(${kind.name}: $detail)';
}
