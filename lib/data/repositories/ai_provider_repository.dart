/// Repository konfigurasi provider AI + model (§27–§34).
library;

import 'dart:convert';

import 'package:drift/drift.dart';

import '../../domain/ai/ai_models.dart';
import '../../domain/ai/model_policy.dart';
import '../../domain/models/ai_enums.dart';
import '../db/app_database.dart';

/// Konversi baris model DB ke info kebijakan (§34).
ModelPolicyInfo policyDariRow(AiModel m) => ModelPolicyInfo(
      modelId: m.modelId,
      favorit: m.favorit,
      diblokir: m.diblokir,
      diizinkan: m.diizinkan,
      statusChat: m.statusChat,
      statusStreaming: m.statusStreaming,
    );

class AIProviderRepository {
  AIProviderRepository(this._db);

  final AppDatabase _db;

  Future<int> tambahProvider({
    required String nama,
    required String baseUrl,
    String chatPath = '/chat/completions',
    String modelsPath = '/models',
    int timeoutDetik = 60,
    bool streamingAktif = true,
    AIDataScope izinData = AIDataScope.tanpaAkses,
    DateTime? sekarang,
  }) {
    return _db.into(_db.aiProviderConfigurations).insert(
          AiProviderConfigurationsCompanion.insert(
            nama: nama,
            baseUrl: baseUrl,
            chatPath: Value(chatPath),
            modelsPath: Value(modelsPath),
            timeoutDetik: Value(timeoutDetik),
            streamingAktif: Value(streamingAktif),
            izinData: izinData,
            dibuatPada: sekarang ?? DateTime.now(),
          ),
        );
  }

  Future<List<AiProviderConfiguration>> semuaProvider() {
    return (_db.select(_db.aiProviderConfigurations)
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Future<AiProviderConfiguration?> provider(int id) {
    return (_db.select(_db.aiProviderConfigurations)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> perbaruiProvider(
      int id, AiProviderConfigurationsCompanion perubahan) async {
    await (_db.update(_db.aiProviderConfigurations)
          ..where((t) => t.id.equals(id)))
        .write(perubahan);
  }

  Future<void> hapusProvider(int id) {
    return _db.transaction(() async {
      final percakapan = await (_db.select(_db.chatConversations)
            ..where((t) => t.providerId.equals(id)))
          .get();
      for (final c in percakapan) {
        await (_db.delete(_db.chatMessages)
              ..where((t) => t.conversationId.equals(c.id)))
            .go();
      }
      await (_db.delete(_db.chatConversations)
            ..where((t) => t.providerId.equals(id)))
          .go();
      await (_db.delete(_db.aiModels)
            ..where((t) => t.providerId.equals(id)))
          .go();
      await (_db.delete(_db.modelListCaches)
            ..where((t) => t.providerId.equals(id)))
          .go();
      await (_db.delete(_db.aiProviderConfigurations)
            ..where((t) => t.id.equals(id)))
          .go();
    });
  }

  /// Simpan hasil discovery: ganti model non-manual + perbarui cache (§29).
  Future<void> simpanHasilDiscovery({
    required int providerId,
    required List<AIModelInfo> models,
    DateTime? sekarang,
  }) {
    final waktu = sekarang ?? DateTime.now();
    return _db.transaction(() async {
      final favoritLama = {
        for (final m in await modelProvider(providerId))
          if (m.favorit) m.modelId,
      };
      await (_db.delete(_db.aiModels)
            ..where((t) =>
                t.providerId.equals(providerId) & t.manual.equals(false)))
          .go();
      for (final m in models) {
        await _db.into(_db.aiModels).insert(
              AiModelsCompanion.insert(
                providerId: providerId,
                modelId: m.id,
                displayName: Value(m.displayName),
                favorit: Value(favoritLama.contains(m.id)),
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }
      await _db.into(_db.modelListCaches).insert(
            ModelListCachesCompanion.insert(
              providerId: Value(providerId),
              jsonModel: jsonEncode([
                for (final m in models)
                  {'id': m.id, 'display_name': m.displayName},
              ]),
              diambilPada: waktu,
            ),
            mode: InsertMode.insertOrReplace,
          );
    });
  }

  Future<List<AiModel>> modelProvider(int providerId) {
    return (_db.select(_db.aiModels)
          ..where((t) => t.providerId.equals(providerId))
          ..orderBy([
            (t) => OrderingTerm.desc(t.favorit),
            (t) => OrderingTerm.asc(t.modelId),
          ]))
        .get();
  }

  Future<int> tambahModelManual({
    required int providerId,
    required String modelId,
    String? displayName,
  }) {
    return _db.into(_db.aiModels).insert(
          AiModelsCompanion.insert(
            providerId: providerId,
            modelId: modelId,
            displayName: Value(displayName),
            manual: const Value(true),
          ),
        );
  }

  Future<void> setFavorit(int id, {required bool favorit}) async {
    await (_db.update(_db.aiModels)..where((t) => t.id.equals(id)))
        .write(AiModelsCompanion(favorit: Value(favorit)));
  }

  Future<void> setDiblokir(int id, {required bool diblokir}) async {
    await (_db.update(_db.aiModels)..where((t) => t.id.equals(id)))
        .write(AiModelsCompanion(diblokir: Value(diblokir)));
  }

  Future<void> setDiizinkan(int id, {required bool diizinkan}) async {
    await (_db.update(_db.aiModels)..where((t) => t.id.equals(id)))
        .write(AiModelsCompanion(diizinkan: Value(diizinkan)));
  }

  /// Set hasil tes kemampuan (§35): hanya VERIFIED/UNSUPPORTED dari tes
  /// yang benar-benar dijalankan.
  Future<void> setStatusKemampuan(
    int id, {
    CapabilityStatus? chat,
    CapabilityStatus? streaming,
  }) async {
    await (_db.update(_db.aiModels)..where((t) => t.id.equals(id))).write(
      AiModelsCompanion(
        statusChat: chat == null ? const Value.absent() : Value(chat),
        statusStreaming:
            streaming == null ? const Value.absent() : Value(streaming),
      ),
    );
  }

  Future<void> setHarga(
    int id, {
    required int? inputPerJuta,
    required int? outputPerJuta,
  }) async {
    await (_db.update(_db.aiModels)..where((t) => t.id.equals(id))).write(
      AiModelsCompanion(
        hargaInputPerJuta: Value(inputPerJuta),
        hargaOutputPerJuta: Value(outputPerJuta),
      ),
    );
  }

  Future<void> setAllowedMode(int providerId, AllowedModelsMode mode) async {
    await (_db.update(_db.aiProviderConfigurations)
          ..where((t) => t.id.equals(providerId)))
        .write(AiProviderConfigurationsCompanion(allowedMode: Value(mode)));
  }

  Future<void> setFallback(
    int providerId, {
    required String? model1,
    required String? model2,
  }) async {
    await (_db.update(_db.aiProviderConfigurations)
          ..where((t) => t.id.equals(providerId)))
        .write(AiProviderConfigurationsCompanion(
      fallbackModel1: Value(model1),
      fallbackModel2: Value(model2),
    ));
  }

  Future<void> setFallbackMode(int providerId, FallbackMode mode) async {
    await (_db.update(_db.aiProviderConfigurations)
          ..where((t) => t.id.equals(providerId)))
        .write(AiProviderConfigurationsCompanion(fallbackMode: Value(mode)));
  }

  Future<void> setModelDefault(int providerId, String modelId) async {
    await (_db.update(_db.aiProviderConfigurations)
          ..where((t) => t.id.equals(providerId)))
        .write(AiProviderConfigurationsCompanion(
      modelDefault: Value(modelId),
    ));
  }

  Future<void> catatModelDipakai(int providerId, String modelId) async {
    await (_db.update(_db.aiModels)
          ..where((t) =>
              t.providerId.equals(providerId) & t.modelId.equals(modelId)))
        .write(AiModelsCompanion(terakhirDipakai: Value(DateTime.now())));
  }

  Future<void> hapusCacheModel(int providerId) async {
    await (_db.delete(_db.modelListCaches)
          ..where((t) => t.providerId.equals(providerId)))
        .go();
  }
}
