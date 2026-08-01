/// Database Drift Finara (subset Fase 1, §54).
/// Enkripsi sqlite3mc: PRAGMA key diterapkan pada koneksi produksi
/// (lihat connection.dart); test memakai NativeDatabase.memory().
library;

import 'package:drift/drift.dart';

import '../../domain/models/allocation_input.dart';
import '../../domain/models/finance_enums.dart';
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
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
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
