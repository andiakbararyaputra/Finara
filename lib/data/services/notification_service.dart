/// Notifikasi lokal (§49, subset Fase 1): pengingat top-up DANA sesuai
/// jadwal alokasi terkonfirmasi. Kegagalan plugin (mis. di test) ditelan
/// agar alur utama tidak terganggu.
library;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../domain/models/allocation_result.dart';

class NotificationService {
  NotificationService([FlutterLocalNotificationsPlugin? plugin])
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _siap = false;

  static const _channel = AndroidNotificationDetails(
    'finara_pengingat',
    'Pengingat Finara',
    channelDescription: 'Pengingat jadwal transfer dan top-up',
    importance: Importance.defaultImportance,
  );

  Future<bool> _pastikanSiap() async {
    if (_siap) return true;
    try {
      tzdata.initializeTimeZones();
      // Target rilis Fase 1 adalah pengguna Indonesia (WIB).
      tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
      const init = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      );
      await _plugin.initialize(settings: init);
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      _siap = true;
      return true;
    } catch (_) {
      return false; // plugin tidak tersedia (mis. widget test)
    }
  }

  /// Jadwalkan pengingat top-up DANA pukul 08.00 untuk tanggal mendatang.
  Future<void> jadwalkanTopUpDana({
    required List<DanaTopUpEntry> jadwal,
    required String judul,
    required String Function(int nominal) isi,
  }) async {
    if (!await _pastikanSiap()) return;
    try {
      final sekarang = DateTime.now();
      var id = 1000;
      for (final entri in jadwal) {
        final waktu = DateTime(
            entri.tanggal.year, entri.tanggal.month, entri.tanggal.day, 8);
        if (!waktu.isAfter(sekarang)) continue;
        await _plugin.zonedSchedule(
          id: id++,
          title: judul,
          body: isi(entri.nominal),
          scheduledDate: tz.TZDateTime.from(waktu, tz.local),
          notificationDetails:
              const NotificationDetails(android: _channel),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      }
    } catch (_) {
      // Pengingat bersifat pelengkap; jangan gagalkan alur konfirmasi.
    }
  }

  Future<void> batalkanSemua() async {
    if (!await _pastikanSiap()) return;
    try {
      await _plugin.cancelAll();
    } catch (_) {}
  }
}
