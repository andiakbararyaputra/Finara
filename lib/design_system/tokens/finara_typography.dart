import 'package:flutter/material.dart';

const String finaraFontFamily = 'Inter';

/// Skala tipografi Finara: heading utama 24–28, section 18–20, body 14–16,
/// caption >= 12, nominal utama 24–32. Ukuran mengikuti text scaling perangkat.
const TextTheme finaraTextTheme = TextTheme(
  displaySmall: TextStyle(
    fontFamily: finaraFontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
  ),
  headlineMedium: TextStyle(
    fontFamily: finaraFontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.25,
  ),
  headlineSmall: TextStyle(
    fontFamily: finaraFontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
  ),
  titleLarge: TextStyle(
    fontFamily: finaraFontFamily,
    fontSize: 19,
    fontWeight: FontWeight.w600,
    height: 1.3,
  ),
  titleMedium: TextStyle(
    fontFamily: finaraFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.35,
  ),
  titleSmall: TextStyle(
    fontFamily: finaraFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.35,
  ),
  bodyLarge: TextStyle(
    fontFamily: finaraFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.45,
  ),
  bodyMedium: TextStyle(
    fontFamily: finaraFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
  ),
  bodySmall: TextStyle(
    fontFamily: finaraFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  ),
  labelLarge: TextStyle(
    fontFamily: finaraFontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.3,
  ),
  labelMedium: TextStyle(
    fontFamily: finaraFontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.3,
  ),
  labelSmall: TextStyle(
    fontFamily: finaraFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
  ),
);
