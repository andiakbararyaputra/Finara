/// Backup & restore terenkripsi (§51). Berisi data non-kredensial saja —
/// API key dan header custom TIDAK pernah ikut (tersimpan terpisah di
/// secure storage dan harus dimasukkan ulang setelah pemulihan).
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:drift/drift.dart';

import '../db/app_database.dart';

class BackupService {
  BackupService(this._db, {this.iterasiPbkdf2 = 100000});

  final AppDatabase _db;

  /// Dapat diturunkan pada test agar cepat.
  final int iterasiPbkdf2;

  static const _magic = 'FNRB1'; // format file cadangan Finara v1
  static const _formatJson = 'finara-backup';
  static const _versiFormat = 1;

  Future<SecretKey> _turunkanKunci(
      String frasa, List<int> salt) {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iterasiPbkdf2,
      bits: 256,
    );
    return pbkdf2.deriveKeyFromPassword(password: frasa, nonce: salt);
  }

  /// Snapshot seluruh tabel sebagai JSON (tanpa kredensial).
  Future<Map<String, dynamic>> snapshot() async {
    Future<List<Map<String, dynamic>>> ambil<T extends DataClass>(
        TableInfo<Table, T> tabel) async {
      final rows = await _db.select(tabel).get();
      return [for (final r in rows) r.toJson()];
    }

    return {
      'format': _formatJson,
      'versi': _versiFormat,
      'skema': _db.schemaVersion,
      'dibuatPada': DateTime.now().toIso8601String(),
      'tabel': {
        'monthlyAllocations': await ambil(_db.monthlyAllocations),
        'monthlyAllocationRevisions':
            await ambil(_db.monthlyAllocationRevisions),
        'incomeSources': await ambil(_db.incomeSources),
        'mandatoryExpenses': await ambil(_db.mandatoryExpenses),
        'budgetFundingAssignments':
            await ambil(_db.budgetFundingAssignments),
        'expenseRealizations': await ambil(_db.expenseRealizations),
        'subscriptions': await ambil(_db.subscriptions),
        'subscriptionReserveLedgers':
            await ambil(_db.subscriptionReserveLedgers),
        'emergencyFundTargets': await ambil(_db.emergencyFundTargets),
        'emergencyFundContributions':
            await ambil(_db.emergencyFundContributions),
        'otherSavingsContributions':
            await ambil(_db.otherSavingsContributions),
        'investmentPlatformAllocations':
            await ambil(_db.investmentPlatformAllocations),
        'checklistItems': await ambil(_db.checklistItems),
        'reminders': await ambil(_db.reminders),
        'appSettings': await ambil(_db.appSettings),
        'aiProviderConfigurations':
            await ambil(_db.aiProviderConfigurations),
        'aiModels': await ambil(_db.aiModels),
        'modelListCaches': await ambil(_db.modelListCaches),
        'chatConversations': await ambil(_db.chatConversations),
        'chatMessages': await ambil(_db.chatMessages),
        'danaPlusConfigurations': await ambil(_db.danaPlusConfigurations),
        'danaBalanceLedgers': await ambil(_db.danaBalanceLedgers),
        'investmentActuals': await ambil(_db.investmentActuals),
        'importedReports': await ambil(_db.importedReports),
      },
    };
  }

  /// Muat snapshot: MENGGANTI seluruh data saat ini.
  Future<void> muatSnapshot(Map<String, dynamic> data) async {
    if (data['format'] != _formatJson) {
      throw const FormatException('bukan cadangan Finara');
    }
    final tabel = data['tabel'] as Map<String, dynamic>;
    List<Map<String, dynamic>> baris(String nama) => [
          for (final r in (tabel[nama] as List? ?? const []))
            (r as Map).cast<String, dynamic>(),
        ];

    await _db.transaction(() async {
      await _db.hapusSemuaData();
      // Urutan mengikuti dependensi foreign key.
      Future<void> isi<T extends DataClass>(
          TableInfo<Table, T> t,
          String nama,
          T Function(Map<String, dynamic>) dari) async {
        for (final r in baris(nama)) {
          await _db.into(t).insert(dari(r) as Insertable<T>,
              mode: InsertMode.insertOrReplace);
        }
      }

      await isi(_db.monthlyAllocations, 'monthlyAllocations',
          MonthlyAllocation.fromJson);
      await isi(_db.monthlyAllocationRevisions,
          'monthlyAllocationRevisions', MonthlyAllocationRevision.fromJson);
      await isi(_db.incomeSources, 'incomeSources', IncomeSource.fromJson);
      await isi(_db.mandatoryExpenses, 'mandatoryExpenses',
          MandatoryExpense.fromJson);
      await isi(_db.budgetFundingAssignments, 'budgetFundingAssignments',
          BudgetFundingAssignment.fromJson);
      await isi(_db.expenseRealizations, 'expenseRealizations',
          ExpenseRealization.fromJson);
      await isi(_db.subscriptions, 'subscriptions', Subscription.fromJson);
      await isi(_db.subscriptionReserveLedgers,
          'subscriptionReserveLedgers', SubscriptionReserveLedger.fromJson);
      await isi(_db.emergencyFundTargets, 'emergencyFundTargets',
          EmergencyFundTarget.fromJson);
      await isi(_db.emergencyFundContributions,
          'emergencyFundContributions', EmergencyFundContribution.fromJson);
      await isi(_db.otherSavingsContributions, 'otherSavingsContributions',
          OtherSavingsContribution.fromJson);
      await isi(
          _db.investmentPlatformAllocations,
          'investmentPlatformAllocations',
          InvestmentPlatformAllocation.fromJson);
      await isi(
          _db.checklistItems, 'checklistItems', ChecklistItem.fromJson);
      await isi(_db.reminders, 'reminders', Reminder.fromJson);
      await isi(_db.appSettings, 'appSettings', AppSetting.fromJson);
      await isi(_db.aiProviderConfigurations, 'aiProviderConfigurations',
          AiProviderConfiguration.fromJson);
      await isi(_db.aiModels, 'aiModels', AiModel.fromJson);
      await isi(_db.modelListCaches, 'modelListCaches',
          ModelListCache.fromJson);
      await isi(_db.chatConversations, 'chatConversations',
          ChatConversation.fromJson);
      await isi(_db.chatMessages, 'chatMessages', ChatMessage.fromJson);
      await isi(_db.danaPlusConfigurations, 'danaPlusConfigurations',
          DanaPlusConfiguration.fromJson);
      await isi(_db.danaBalanceLedgers, 'danaBalanceLedgers',
          DanaBalanceLedger.fromJson);
      await isi(_db.investmentActuals, 'investmentActuals',
          InvestmentActual.fromJson);
      await isi(_db.importedReports, 'importedReports',
          ImportedReport.fromJson);
    });
  }

  /// Buat file cadangan terenkripsi (AES-GCM 256, kunci PBKDF2 dari frasa).
  Future<Uint8List> buatCadangan(String frasaSandi) async {
    final json = utf8.encode(jsonEncode(await snapshot()));
    final salt = SecretKeyData.random(length: 16).bytes;
    final kunci = await _turunkanKunci(frasaSandi, salt);
    final aes = AesGcm.with256bits();
    final nonce = aes.newNonce();
    final kotak =
        await aes.encrypt(json, secretKey: kunci, nonce: nonce);

    final builder = BytesBuilder()
      ..add(ascii.encode(_magic))
      ..add(salt)
      ..add(kotak.nonce)
      ..add(kotak.mac.bytes)
      ..add(kotak.cipherText);
    return builder.toBytes();
  }

  /// Pulihkan dari file cadangan; melempar jika frasa/file tidak valid.
  Future<void> pulihkan(Uint8List bytes, String frasaSandi) async {
    if (bytes.length < 5 + 16 + 12 + 16 ||
        ascii.decode(bytes.sublist(0, 5)) != _magic) {
      throw const FormatException('bukan file cadangan Finara');
    }
    final salt = bytes.sublist(5, 21);
    final nonce = bytes.sublist(21, 33);
    final mac = Mac(bytes.sublist(33, 49));
    final cipher = bytes.sublist(49);

    final kunci = await _turunkanKunci(frasaSandi, salt);
    final jernih = await AesGcm.with256bits().decrypt(
      SecretBox(cipher, nonce: nonce, mac: mac),
      secretKey: kunci,
    );
    final data =
        (jsonDecode(utf8.decode(jernih)) as Map).cast<String, dynamic>();
    await muatSnapshot(data);
  }
}
