import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class AppResponsive {
  AppResponsive._();

  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static bool isCompactPhone(BuildContext context) =>
      screenWidth(context) < 375;
  static bool isRegularPhone(BuildContext context) =>
      screenWidth(context) >= 375 && screenWidth(context) < 430;
  static bool isLargePhone(BuildContext context) =>
      screenWidth(context) >= 430 && screenWidth(context) < 600;
  static bool isTablet(BuildContext context) => screenWidth(context) >= 600;
  static bool isShortPhone(BuildContext context) => screenHeight(context) < 760;

  static double horizontalPadding(BuildContext context) {
    final width = screenWidth(context);
    if (width >= 600) return 24;
    if (width >= 430) return 20;
    if (width < 360) return 14;
    return 16;
  }

  static double sheetHorizontalPadding(BuildContext context) {
    final width = screenWidth(context);
    if (width >= 1024) return 28;
    if (width >= 600) return 24;
    if (width < 360) return 14;
    return 16;
  }

  static double sheetMaxWidth(BuildContext context) {
    final width = screenWidth(context);
    if (width >= 1024) return 560;
    if (width >= 600) return 520;
    return width;
  }

  static double contentMaxWidth(BuildContext context) {
    final width = screenWidth(context);
    if (width >= 1024) return 960;
    if (width >= 600) return 560;
    return width;
  }

  static double onboardingContentMaxWidth(BuildContext context) {
    final width = screenWidth(context);
    if (width >= 1024) return 440;
    if (width >= 600) return 420;
    return width;
  }

  static double onboardingTitleSize(BuildContext context) {
    final width = screenWidth(context);
    if (width >= 430) return 56;
    if (width < 360) return 40;
    return 48;
  }

  static double onboardingHeaderTopSpacing(BuildContext context) {
    if (isShortPhone(context)) return 20;
    if (screenHeight(context) >= 900) return 40;
    return 32;
  }

  static double onboardingSectionSpacing(BuildContext context) {
    if (isShortPhone(context)) return 24;
    return 32;
  }

  static double onboardingAvatarRailHeight(BuildContext context) {
    if (screenWidth(context) < 360) return 84;
    return 100;
  }

  static double onboardingAvatarSize(
    BuildContext context, {
    required bool selected,
  }) {
    if (screenWidth(context) < 360) {
      return selected ? 72 : 56;
    }
    return selected ? 80 : 60;
  }

  static double onboardingActionExtent(BuildContext context) {
    if (screenWidth(context) < 360) return 48;
    return 52;
  }

  static double sheetMaxHeight(BuildContext context) {
    final height = screenHeight(context);
    return math.min(height * 0.92, 760);
  }

  static double clampBottomSpacer(
    BuildContext context, {
    double min = 16,
    double max = 120,
  }) {
    final height = screenHeight(context);
    return math.max(min, math.min(max, height * 0.08));
  }
}

class ResponsiveConstrainedContent extends StatelessWidget {
  const ResponsiveConstrainedContent({
    super.key,
    required this.child,
    this.maxWidth,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final double? maxWidth;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      heightFactor: 1.0,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? AppResponsive.contentMaxWidth(context),
        ),
        child: child,
      ),
    );
  }
}
