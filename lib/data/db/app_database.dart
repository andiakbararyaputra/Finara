/// Database Drift Finara (subset Fase 1, §54).
/// Enkripsi sqlite3mc: PRAGMA key diterapkan pada koneksi produksi
/// (lihat connection.dart); test memakai NativeDatabase.memory().
library;

import 'package:drift/drift.dart';

import '../../domain/ai/ai_models.dart';
import '../../domain/models/ai_enums.dart';
import '../../domain/models/allocation_input.dart';
import '../../domain/models/finance_enums.dart';
import '../../domain/services/dana_split_service.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  MonthlyAllocations,
  MonthlyAllocationRevisions,
  IncomeSources,
  MandatoryExpenses,
  BudgetFundingAssignments,
  ExpenseRealizations,
  Subscriptions,
  SubscriptionReserveLedgers,
  EmergencyFundTargets,
  EmergencyFundContributions,
  OtherSavingsContributions,
  InvestmentPlatformAllocations,
  ChecklistItems,
  Reminders,
  AppSettings,
  AiProviderConfigurations,
  AiModels,
  ModelListCaches,
  ChatConversations,
  ChatMessages,
  DanaPlusConfigurations,
  DanaBalanceLedgers,
  InvestmentActuals,
  ImportedReports,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, dari, ke) async {
          if (dari < 2) {
            // v2: tabel Finara AI (Fase 2).
            await m.createTable(aiProviderConfigurations);
            await m.createTable(aiModels);
            await m.createTable(modelListCaches);
            await m.createTable(chatConversations);
            await m.createTable(chatMessages);
          }
          if (dari < 3) {
            // v3: Allowed Models, fallback, kemampuan, harga (Fase 3B).
            await m.addColumn(aiProviderConfigurations,
                aiProviderConfigurations.allowedMode);
            await m.addColumn(aiProviderConfigurations,
                aiProviderConfigurations.fallbackModel1);
            await m.addColumn(aiProviderConfigurations,
                aiProviderConfigurations.fallbackModel2);
            await m.addColumn(aiModels, aiModels.diblokir);
            await m.addColumn(aiModels, aiModels.diizinkan);
            await m.addColumn(aiModels, aiModels.statusChat);
            await m.addColumn(aiModels, aiModels.statusStreaming);
            await m.addColumn(aiModels, aiModels.hargaInputPerJuta);
            await m.addColumn(aiModels, aiModels.hargaOutputPerJuta);
          }
          if (dari < 4) {
            // v4: DANA+ (Fase 4B).
            await m.createTable(danaPlusConfigurations);
            await m.createTable(danaBalanceLedgers);
          }
          if (dari < 5) {
            // v5: data aktual investasi manual (Fase 4C).
            await m.createTable(investmentActuals);
          }
          if (dari < 6) {
            // v6: riwayat impor laporan (Fase 4A).
            await m.createTable(importedReports);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  /// Hapus seluruh data pengguna (§51) — dipanggil setelah konfirmasi ganda.
  Future<void> hapusSemuaData() {
    return transaction(() async {
      for (final tabel in allTables) {
        await delete(tabel).go();
      }
    });
  }
}
