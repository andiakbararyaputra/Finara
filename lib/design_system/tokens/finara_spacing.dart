import 'package:flutter/widgets.dart';

/// Jarak antarelemen yang konsisten (satuan logical pixel = dp/pt).
abstract final class FinaraSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  static const EdgeInsets screen = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets card = EdgeInsets.all(lg);

  /// Batas lebar konten pada layar besar agar tetap nyaman dibaca.
  static const double maxContentWidth = 560;

  /// Area sentuh minimum (Android 48dp / iOS 44pt).
  static const double minTouchTarget = 48;
}

/// Rounded corner 16–24 sesuai token desain adaptif.
abstract final class FinaraRadius {
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
}
