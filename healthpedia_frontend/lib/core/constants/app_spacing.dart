import 'package:flutter/material.dart';

/// Spacing scale from the Figma design tokens (Space.tokens.json).
/// Use these constants instead of hardcoding pixel values.
///
/// The scale follows an incremental system: 0, 1, 2, 4, 8, 10, 12, 14, 16,
/// 20, 24, 28, 32, 40, 48, 60, 72.
class AppSpacing {
  AppSpacing._(); // prevent instantiation

  // ─────────────────────────────────────────────
  // Raw spacing values (from Space.tokens.json)
  // ─────────────────────────────────────────────
  static const double space0 = 0;
  static const double space1 = 1;
  static const double space2 = 2;
  static const double space4 = 4;
  static const double space8 = 8;
  static const double space10 = 10;
  static const double space12 = 12;
  static const double space14 = 14;
  static const double space16 = 16;
  static const double space20 = 20;
  static const double space24 = 24;
  static const double space28 = 28;
  static const double space32 = 32;
  static const double space40 = 40;
  static const double space48 = 48;
  static const double space60 = 60;
  static const double space72 = 72;

  // ─────────────────────────────────────────────
  // Semantic spacing aliases
  // ─────────────────────────────────────────────

  /// Tiny spacing (e.g. between icon and label)
  static const double xs = space4;

  /// Small spacing (e.g. inner padding of chips)
  static const double sm = space8;

  /// Medium spacing (e.g. card padding)
  static const double md = space16;

  /// Large spacing (e.g. section gaps)
  static const double lg = space24;

  /// Extra-large spacing (e.g. major section separators)
  static const double xl = space32;

  /// 2x-extra-large spacing
  static const double xxl = space48;

  /// Screen-edge horizontal padding
  static const double screenHorizontal = space20;

  /// Screen-edge vertical padding
  static const double screenVertical = space24;

  // ─────────────────────────────────────────────
  // Size tokens (from Size.tokens.json)
  // ─────────────────────────────────────────────
  static const double size0 = 0;
  static const double size2 = 2;
  static const double size4 = 4;
  static const double size6 = 6;
  static const double size8 = 8;
  static const double size10 = 10;
  static const double size12 = 12;
  static const double size14 = 14;
  static const double size16 = 16;
  static const double size20 = 20;
  static const double size24 = 24;
  static const double size28 = 28;
  static const double size32 = 32;
  static const double size36 = 36;
  static const double size40 = 40;
  static const double size44 = 44;
  static const double size48 = 48;
  static const double size56 = 56;
  static const double size64 = 64;
  static const double size80 = 80;
  static const double size96 = 96;

  // ─────────────────────────────────────────────
  // Radius tokens (from Radius.tokens.json)
  // ─────────────────────────────────────────────

  /// No rounding
  static const double radiusNone = 0;

  /// 2px — subtle rounding
  static const double radiusSm = 2;

  /// 4px — default rounding for small elements
  static const double radiusMd = 4;

  /// 8px — card-level rounding
  static const double radiusLg = 8;

  /// 12px — prominent rounding
  static const double radiusXl = 12;

  /// 16px — container-level rounding
  static const double radius2xl = 16;

  /// 24px — large component rounding
  static const double radius3xl = 24;

  /// 32px — hero section rounding
  static const double radius4xl = 32;

  /// 48px — pill-shaped rounding
  static const double radius5xl = 48;

  /// 999px — fully circular
  static const double radiusFull = 999;

  // ─────────────────────────────────────────────
  // EdgeInsets helpers
  // ─────────────────────────────────────────────

  /// Standard screen-level padding (horizontal + vertical)
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
    vertical: screenVertical,
  );

  /// Horizontal-only screen padding
  static const EdgeInsets screenPaddingHorizontal = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
  );

  /// Card-level padding
  static const EdgeInsets cardPadding = EdgeInsets.all(md);

  /// Compact padding for list items
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );
}
