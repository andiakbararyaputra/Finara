/// Repository percakapan Finara AI lokal (§47).
library;

import 'package:drift/drift.dart';

import '../db/app_database.dart';

class ChatRepository {
  ChatRepository(this._db);

  final AppDatabase _db;

  Future<int> buatPercakapan({
    required String judul,
    required int providerId,
    required String modelId,
    DateTime? sekarang,
  }) {
    final waktu = sekarang ?? DateTime.now();
    return _db.into(_db.chatConversations).insert(
          ChatConversationsCompanion.insert(
            judul: judul,
            providerId: providerId,
            modelId: modelId,
            dibuatPada: waktu,
            diperbaruiPada: waktu,
          ),
        );
  }

  Future<List<ChatConversation>> daftarPercakapan() {
    return (_db.select(_db.chatConversations)
          ..orderBy([(t) => OrderingTerm.desc(t.diperbaruiPada)]))
        .get();
  }

  Future<ChatConversation?> percakapan(int id) {
    return (_db.select(_db.chatConversations)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> tambahPesan({
    required int conversationId,
    required String role,
    required String content,
    DateTime? sekarang,
  }) {
    final waktu = sekarang ?? DateTime.now();
    return _db.transaction(() async {
      final id = await _db.into(_db.chatMessages).insert(
            ChatMessagesCompanion.insert(
              conversationId: conversationId,
              role: role,
              content: content,
              dibuatPada: waktu,
            ),
          );
      await (_db.update(_db.chatConversations)
            ..where((t) => t.id.equals(conversationId)))
          .write(ChatConversationsCompanion(diperbaruiPada: Value(waktu)));
      return id;
    });
  }

  Future<List<ChatMessage>> pesanPercakapan(int conversationId) {
    return (_db.select(_db.chatMessages)
          ..where((t) => t.conversationId.equals(conversationId))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Future<void> ubahJudul(int id, String judul) async {
    await (_db.update(_db.chatConversations)..where((t) => t.id.equals(id)))
        .write(ChatConversationsCompanion(judul: Value(judul)));
  }

  /// Ganti model di tengah percakapan (§33).
  Future<void> ubahModel(int id, String modelId) async {
    await (_db.update(_db.chatConversations)..where((t) => t.id.equals(id)))
        .write(ChatConversationsCompanion(modelId: Value(modelId)));
  }

  /// Hapus satu pesan (utk regenerasi jawaban §42).
  Future<void> hapusPesan(int pesanId) async {
    await (_db.delete(_db.chatMessages)..where((t) => t.id.equals(pesanId)))
        .go();
  }

  Future<void> hapusPercakapan(int id) {
    return _db.transaction(() async {
      await (_db.delete(_db.chatMessages)
            ..where((t) => t.conversationId.equals(id)))
          .go();
      await (_db.delete(_db.chatConversations)
            ..where((t) => t.id.equals(id)))
          .go();
    });
  }

  Future<void> hapusSemua() {
    return _db.transaction(() async {
      await _db.delete(_db.chatMessages).go();
      await _db.delete(_db.chatConversations).go();
    });
  }

  /// Retensi §47: hapus percakapan yang tidak diperbarui selama [hari].
  Future<int> hapusLebihTuaDari(int hari, {DateTime? sekarang}) async {
    final batas =
        (sekarang ?? DateTime.now()).subtract(Duration(days: hari));
    final kedaluwarsa = await (_db.select(_db.chatConversations)
          ..where((t) => t.diperbaruiPada.isSmallerThanValue(batas)))
        .get();
    for (final c in kedaluwarsa) {
      await hapusPercakapan(c.id);
    }
    return kedaluwarsa.length;
  }
}
