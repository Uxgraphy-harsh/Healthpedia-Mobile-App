import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

/// App-wide ThemeData built from the Figma design tokens.
/// Centralises Material 3 configuration so individual screens don't
/// need to set their own colours / text themes.
class AppTheme {
  AppTheme._(); // prevent instantiation

  /// Light theme — the primary theme for the application.
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // ── Color scheme ──────────────────────
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.pink50,
        onPrimaryContainer: AppColors.pink900,
        secondary: AppColors.amber500,
        onSecondary: AppColors.white,
        secondaryContainer: AppColors.amber100,
        onSecondaryContainer: AppColors.amber900,
        tertiary: AppColors.sky500,
        onTertiary: AppColors.white,
        tertiaryContainer: AppColors.sky100,
        onTertiaryContainer: AppColors.sky900,
        error: AppColors.error,
        onError: AppColors.white,
        errorContainer: AppColors.red50,
        onErrorContainer: AppColors.red900,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        surfaceContainerHighest: AppColors.neutral100,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.border,
        outlineVariant: AppColors.neutral100,
        shadow: AppColors.black,
        scrim: AppColors.black,
      ),

      // ── Scaffold ──────────────────────────
      scaffoldBackgroundColor: AppColors.background,

      // ── App bar ───────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        titleTextStyle: AppTypography.h6.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),

      // ── Text theme ────────────────────────
      textTheme: TextTheme(
        displayLarge: AppTypography.title1.copyWith(color: AppColors.textPrimary),
        displayMedium: AppTypography.title2.copyWith(color: AppColors.textPrimary),
        displaySmall: AppTypography.title3.copyWith(color: AppColors.textPrimary),
        headlineLarge: AppTypography.h1.copyWith(color: AppColors.textPrimary),
        headlineMedium: AppTypography.h3.copyWith(color: AppColors.textPrimary),
        headlineSmall: AppTypography.h5.copyWith(color: AppColors.textPrimary),
        titleLarge: AppTypography.h4.copyWith(color: AppColors.textPrimary),
        titleMedium: AppTypography.label1.copyWith(color: AppColors.textPrimary),
        titleSmall: AppTypography.label2.copyWith(color: AppColors.textPrimary),
        bodyLarge: AppTypography.body1.copyWith(color: AppColors.textPrimary),
        bodyMedium: AppTypography.body2.copyWith(color: AppColors.textPrimary),
        bodySmall: AppTypography.body3.copyWith(color: AppColors.textSecondary),
        labelLarge: AppTypography.label1.copyWith(color: AppColors.textPrimary),
        labelMedium: AppTypography.label2.copyWith(color: AppColors.textSecondary),
        labelSmall: AppTypography.label3.copyWith(color: AppColors.textTertiary),
      ),

      // ── Card theme ────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Elevated button ───────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.label1.copyWith(fontWeight: FontWeight.w600),
        ),
      ),

      // ── Outlined button ───────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: BorderSide(color: AppColors.border),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.label1.copyWith(fontWeight: FontWeight.w600),
        ),
      ),

      // ── Text button ──────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.label2.copyWith(fontWeight: FontWeight.w600),
        ),
      ),

      // ── Input decoration ──────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.neutral50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error),
        ),
        hintStyle: AppTypography.body2.copyWith(color: AppColors.textTertiary),
        labelStyle: AppTypography.label2.copyWith(color: AppColors.textSecondary),
      ),

      // ── Bottom navigation ─────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.caption1.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTypography.caption1,
      ),

      // ── Divider ───────────────────────────
      dividerTheme: DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 0,
      ),

      // ── Chip theme ────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.neutral50,
        selectedColor: AppColors.primary,
        disabledColor: AppColors.neutral100,
        labelStyle: AppTypography.label3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: BorderSide(color: AppColors.border),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      // ── Bottom sheet ──────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        showDragHandle: true,
        dragHandleColor: AppColors.neutral300,
      ),
    );
  }
}
