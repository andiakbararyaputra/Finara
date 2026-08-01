/// Provider infrastruktur: database terenkripsi + repositories.
/// Test meng-override [databaseProvider] dengan NativeDatabase.memory().
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db/app_database.dart';
import '../data/db/connection.dart';
import '../data/db/database_key_manager.dart';
import '../data/repositories/allocation_repository.dart';
import '../data/repositories/emergency_fund_repository.dart';
import '../data/repositories/expense_realization_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/subscription_repository.dart';
import '../data/services/notification_service.dart';
import '../data/services/pin_manager.dart';

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
