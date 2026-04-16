import 'package:flutter/material.dart';

/// Typography styles from the Figma design tokens (Typography.tokens.json).
/// The design system uses "Geist" as both primary and secondary font families.
///
/// Categories: Title (1-3), Heading (H1-H6), Label (1-3), Body (1-4), Caption (1-2).
/// Each text style includes font size, line height, and letter spacing.
///
/// Usage: `Text('Hello', style: AppTypography.h5SemiBold)`
class AppTypography {
  AppTypography._(); // prevent instantiation

  // ─────────────────────────────────────────────
  // Font family constants
  // ─────────────────────────────────────────────

  /// Primary font — used across most UI text
  static const String fontFamilyPrimary = 'Geist';

  /// Secondary font — used for titles/display text
  static const String fontFamilySecondary = 'Geist';

  // ─────────────────────────────────────────────
  // Title styles (large display text)
  // ─────────────────────────────────────────────

  /// Title-1: 72px, lineHeight 88px, letterSpacing -0.8
  static const TextStyle title1 = TextStyle(
    fontFamily: fontFamilySecondary,
    fontSize: 72,
    height: 88 / 72,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w700,
  );

  /// Title-2: 64px, lineHeight 76px, letterSpacing -0.8
  static const TextStyle title2 = TextStyle(
    fontFamily: fontFamilySecondary,
    fontSize: 64,
    height: 76 / 64,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w700,
  );

  /// Title-3: 56px, lineHeight 68px, letterSpacing -0.6
  static const TextStyle title3 = TextStyle(
    fontFamily: fontFamilySecondary,
    fontSize: 56,
    height: 68 / 56,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w700,
  );

  // ─────────────────────────────────────────────
  // Heading styles
  // ─────────────────────────────────────────────

  /// H1: 56px, lineHeight 68px, letterSpacing -0.5
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamilySecondary,
    fontSize: 56,
    height: 68 / 56,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w700,
  );

  /// H2: 48px, lineHeight 58px, letterSpacing -0.4
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 48,
    height: 58 / 48,
    letterSpacing: -0.4,
    fontWeight: FontWeight.w700,
  );

  /// H3: 40px, lineHeight 48px, letterSpacing -0.3
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 40,
    height: 48 / 40,
    letterSpacing: -0.3,
    fontWeight: FontWeight.w700,
  );

  /// H4: 32px, lineHeight 38px, letterSpacing -0.2
  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 32,
    height: 38 / 32,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w700,
  );

  /// H5: 24px, lineHeight 30px, letterSpacing -0.15
  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 24,
    height: 30 / 24,
    letterSpacing: -0.15,
    fontWeight: FontWeight.w700,
  );

  /// H6: 20px, lineHeight 24px, letterSpacing -0.5
  static const TextStyle h6 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 20,
    height: 24 / 20,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w700,
  );

  // ─────────────────────────────────────────────
  // Heading — weight variants (most commonly used)
  // ─────────────────────────────────────────────

  static TextStyle get h5SemiBold => h5.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get h5Medium => h5.copyWith(fontWeight: FontWeight.w500);
  static TextStyle get h5Regular => h5.copyWith(fontWeight: FontWeight.w400);

  static TextStyle get h6SemiBold => h6.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get h6Medium => h6.copyWith(fontWeight: FontWeight.w500);
  static TextStyle get h6Regular => h6.copyWith(fontWeight: FontWeight.w400);

  // ─────────────────────────────────────────────
  // Label styles (UI controls, buttons, tabs)
  // ─────────────────────────────────────────────

  /// Label-1: 16px, lineHeight 22px, letterSpacing -0.18
  static const TextStyle label1 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 16,
    height: 22 / 16,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w500,
  );

  /// Label-2: 14px, lineHeight 20px, letterSpacing -0.16
  static const TextStyle label2 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: -0.16,
    fontWeight: FontWeight.w500,
  );

  /// Label-3: 12px, lineHeight 16px, letterSpacing -0.12
  static const TextStyle label3 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: -0.12,
    fontWeight: FontWeight.w500,
  );

  // ─────────────────────────────────────────────
  // Label — weight variants
  // ─────────────────────────────────────────────

  static TextStyle get label1SemiBold => label1.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get label1Bold => label1.copyWith(fontWeight: FontWeight.w700);
  static TextStyle get label2SemiBold => label2.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get label2Bold => label2.copyWith(fontWeight: FontWeight.w700);
  static TextStyle get label3SemiBold => label3.copyWith(fontWeight: FontWeight.w600);

  // ─────────────────────────────────────────────
  // Body styles (paragraphs, descriptions)
  // ─────────────────────────────────────────────

  /// Body-1: 18px, lineHeight 28px, letterSpacing 0
  static const TextStyle body1 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 18,
    height: 28 / 18,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w400,
  );

  /// Body-2: 16px, lineHeight 24px, letterSpacing 0
  static const TextStyle body2 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w400,
  );

  /// Body-3: 14px, lineHeight 20px, letterSpacing 0
  static const TextStyle body3 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w400,
  );

  /// Body-4: 12px, lineHeight 16px, letterSpacing 0
  static const TextStyle body4 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w400,
  );

  // ─────────────────────────────────────────────
  // Body — weight variants
  // ─────────────────────────────────────────────

  static TextStyle get body1Medium => body1.copyWith(fontWeight: FontWeight.w500);
  static TextStyle get body1SemiBold => body1.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get body2Medium => body2.copyWith(fontWeight: FontWeight.w500);
  static TextStyle get body2SemiBold => body2.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get body3Medium => body3.copyWith(fontWeight: FontWeight.w500);
  static TextStyle get body3SemiBold => body3.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get body4Medium => body4.copyWith(fontWeight: FontWeight.w500);

  // ─────────────────────────────────────────────
  // Caption styles (metadata, timestamps, fine print)
  // ─────────────────────────────────────────────

  /// Caption-1: 10px, lineHeight 12px, letterSpacing 0
  static const TextStyle caption1 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 10,
    height: 12 / 10,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w400,
  );

  /// Caption-2: 9px, lineHeight 10px, letterSpacing 0
  static const TextStyle caption2 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: 9,
    height: 10 / 9,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w400,
  );
}
