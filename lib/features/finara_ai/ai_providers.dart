/// Provider data & helper modul Finara AI.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../data/db/app_database.dart';
import '../../domain/ai/ai_models.dart';
import '../../domain/ai/ai_provider_adapter.dart';
import '../../l10n/app_localizations.dart';

final daftarProviderAiProvider =
    FutureProvider<List<AiProviderConfiguration>>((ref) {
  return ref.watch(aiProviderRepositoryProvider).semuaProvider();
});

/// Provider AI aktif = konfigurasi pertama (MVP satu konfigurasi, §59 F2).
final providerAiAktifProvider =
    FutureProvider<AiProviderConfiguration?>((ref) async {
  final semua = await ref.watch(daftarProviderAiProvider.future);
  return semua.isEmpty ? null : semua.first;
});

final modelTersimpanProvider =
    FutureProvider.family<List<AiModel>, int>((ref, providerId) {
  return ref.watch(aiProviderRepositoryProvider).modelProvider(providerId);
});

final daftarPercakapanProvider =
    FutureProvider<List<ChatConversation>>((ref) {
  return ref.watch(chatRepositoryProvider).daftarPercakapan();
});

final pesanPercakapanProvider =
    FutureProvider.family<List<ChatMessage>, int>((ref, conversationId) {
  return ref.watch(chatRepositoryProvider).pesanPercakapan(conversationId);
});

/// Bangun adapter dari baris konfigurasi.
AIProviderAdapter buatAdapter(
  AIProviderAdapter Function(AIProviderConfig) factory,
  AiProviderConfiguration config,
) {
  return factory(AIProviderConfig(
    baseUrl: config.baseUrl,
    chatPath: config.chatPath,
    modelsPath: config.modelsPath,
    timeout: Duration(seconds: config.timeoutDetik),
  ));
}

/// Pesan error §48 dalam Bahasa Indonesia.
String labelErrorAi(AppLocalizations l10n, Object error) {
  final kind =
      error is AIProviderException ? error.kind : AIErrorKind.tidakDiketahui;
  return switch (kind) {
    AIErrorKind.apiKeyKosong => l10n.errApiKeyKosong,
    AIErrorKind.apiKeyDitolak => l10n.errApiKeyDitolak,
    AIErrorKind.endpointSalah => l10n.errEndpointSalah,
    AIErrorKind.modelTidakTersedia => l10n.errModelTidakTersedia,
    AIErrorKind.tidakAdaInternet => l10n.errTidakAdaInternet,
    AIErrorKind.timeout => l10n.errTimeout,
    AIErrorKind.rateLimit => l10n.errRateLimit,
    AIErrorKind.kuotaHabis => l10n.errKuotaHabis,
    AIErrorKind.responsTidakValid => l10n.errResponsTidakValid,
    AIErrorKind.responsKosong => l10n.errResponsKosong,
    AIErrorKind.konteksTerlaluPanjang => l10n.errKonteksTerlaluPanjang,
    AIErrorKind.streamingTerputus => l10n.errStreamingTerputus,
    AIErrorKind.parameterTidakDidukung => l10n.errParameterTidakDidukung,
    AIErrorKind.modelOverload => l10n.errModelOverload,
    AIErrorKind.tidakDiketahui => l10n.errTidakDiketahui,
  };
}
