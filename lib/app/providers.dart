/// Provider infrastruktur: database terenkripsi + repositories.
/// Test meng-override [databaseProvider] dengan NativeDatabase.memory().
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db/app_database.dart';
import '../data/db/connection.dart';
import '../data/db/database_key_manager.dart';
import '../data/repositories/ai_provider_repository.dart';
import '../data/repositories/allocation_repository.dart';
import '../data/repositories/chat_repository.dart';
import '../data/repositories/dana_plus_repository.dart';
import '../data/repositories/emergency_fund_repository.dart';
import '../data/repositories/expense_realization_repository.dart';
import '../data/repositories/import_repository.dart';
import '../data/repositories/investment_actual_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/subscription_repository.dart';
import '../data/services/api_key_store.dart';
import '../data/services/notification_service.dart';
import '../data/services/pin_manager.dart';
import '../domain/ai/ai_models.dart';
import '../domain/ai/ai_provider_adapter.dart';
import '../domain/ai/openai_compatible_adapter.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(openEncryptedConnection(DatabaseKeyManager()));
  ref.onDispose(db.close);
  return db;
});

final allocationRepositoryProvider = Provider<AllocationRepository>(
  (ref) => AllocationRepository(ref.watch(databaseProvider)),
);

final expenseRealizationRepositoryProvider =
    Provider<ExpenseRealizationRepository>(
  (ref) => ExpenseRealizationRepository(ref.watch(databaseProvider)),
);

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>(
  (ref) => SubscriptionRepository(ref.watch(databaseProvider)),
);

final emergencyFundRepositoryProvider = Provider<EmergencyFundRepository>(
  (ref) => EmergencyFundRepository(ref.watch(databaseProvider)),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(databaseProvider)),
);

final notificationServiceProvider =
    Provider<NotificationService>((ref) => NotificationService());

final pinManagerProvider = Provider<PinManager>((ref) => PinManager());

final aiProviderRepositoryProvider = Provider<AIProviderRepository>(
  (ref) => AIProviderRepository(ref.watch(databaseProvider)),
);

final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => ChatRepository(ref.watch(databaseProvider)),
);

final danaPlusRepositoryProvider = Provider<DanaPlusRepository>(
  (ref) => DanaPlusRepository(ref.watch(databaseProvider)),
);

final investmentActualRepositoryProvider =
    Provider<InvestmentActualRepository>(
  (ref) => InvestmentActualRepository(ref.watch(databaseProvider)),
);

final importRepositoryProvider = Provider<ImportRepository>(
  (ref) => ImportRepository(ref.watch(databaseProvider)),
);

final apiKeyStoreProvider = Provider<ApiKeyStore>((ref) => ApiKeyStore());

/// Factory adapter per konfigurasi; test meng-override dgn MockAIAdapter.
final aiAdapterFactoryProvider =
    Provider<AIProviderAdapter Function(AIProviderConfig)>(
  (ref) => OpenAICompatibleAdapter.new,
);
