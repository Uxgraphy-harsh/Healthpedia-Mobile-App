import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'premium_field_states.dart';

class BaseInputContainer extends StatelessWidget {
  const BaseInputContainer({
    super.key,
    required this.child,
    this.label,
    this.hint,
    this.state = PremiumFieldState.defaultState,
    this.isFocused = false,
    this.backgroundColor,
    this.labelColor,
    this.hintColor,
    this.borderColor,
    this.isDark = false,
    this.padding,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.borderRadius,
    this.prefix,
    this.suffix,
    this.onTap,
    this.minHeight = 55,
    this.showBorder = false,
    this.borderWidth = 1,
    this.fillWidth = true,
    this.labelTrailing,
    this.labelInside,
    this.showHelperIcon = true,
  });

  final Widget child;
  final String? label;
  final String? hint;
  final PremiumFieldState state;
  final bool isFocused;
  final Color? backgroundColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? borderColor;
  final bool isDark;
  final EdgeInsets? padding;
  final EdgeInsets contentPadding;
  final double? borderRadius;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onTap;
  final double minHeight;
  final bool showBorder;
  final double borderWidth;
  final bool fillWidth;
  final Widget? labelTrailing;
  final bool? labelInside;
  final bool showHelperIcon;

  static TextStyle labelTextStyle(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
      fontSize: 14,
      height: 16 / 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      color: color ?? AppColors.neutral950,
    );
  }

  static TextStyle contentTextStyle(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: color ?? AppColors.neutral950,
    );
  }

  Color _resolvedFillColor() {
    if (backgroundColor != null) {
      return backgroundColor!;
    }
    if (state.isDisabled) {
      return isDark ? AppColors.neutral800 : AppColors.neutral100;
    }
    return isDark ? AppColors.neutral800 : Colors.transparent;
  }

  Color _resolvedBorderColor() {
    if (borderColor != null) {
      return borderColor!;
    }
    if (state.isError) {
      return AppColors.error;
    }
    if (state == PremiumFieldState.success) {
      return AppColors.success;
    }
    if (isFocused || state.isFocused) {
      return isDark ? AppColors.primary : AppColors.neutral950;
    }
    return isDark ? AppColors.white.withValues(alpha: 0.14) : AppColors.neutral200;
  }

  Color _resolvedLabelColor() {
    if (labelColor != null) {
      return labelColor!;
    }
    return isDark ? AppColors.white : AppColors.neutral600;
  }

  Color _resolvedHintColor() {
    if (hintColor != null) {
      return hintColor!;
    }
    if (state.isError) {
      return AppColors.error;
    }
    return isDark ? AppColors.neutral300 : AppColors.neutral600;
  }

  @override
  Widget build(BuildContext context) {
    final usesInsideLabel = label != null && (labelInside ?? !isDark);
    final Widget? helperIcon = switch (state) {
      PremiumFieldState.error when showHelperIcon =>
        const Icon(Icons.error_outline_rounded, size: 16, color: AppColors.error),
      PremiumFieldState.success when showHelperIcon =>
        const Icon(Icons.check_circle_outline_rounded, size: 16, color: AppColors.success),
      _ => null,
    };

    final fieldContent = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (prefix != null) ...[
          prefix!,
          const SizedBox(width: 8),
        ],
        Expanded(child: child),
        if (suffix != null) ...[
          const SizedBox(width: 8),
          suffix!,
        ],
      ],
    );

    final field = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: state.isInteractive ? onTap : null,
        borderRadius: BorderRadius.circular(borderRadius ?? (isDark ? 8 : 12)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          constraints: BoxConstraints(minHeight: minHeight),
          width: fillWidth ? double.infinity : null,
          decoration: BoxDecoration(
            color: _resolvedFillColor(),
            borderRadius: BorderRadius.circular(borderRadius ?? (isDark ? 8 : 12)),
            border: (showBorder || !isDark)
                ? Border.all(
                    color: _resolvedBorderColor(),
                    width: isFocused || state.isFocused ? borderWidth + 0.25 : borderWidth,
                  )
                : null,
          ),
          child: Padding(
            padding: padding ?? contentPadding,
            child: usesInsideLabel
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              label!,
                              style: labelTextStyle(
                                context,
                                color: _resolvedLabelColor(),
                              ).copyWith(
                                fontSize: 12,
                                height: 16 / 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          if (labelTrailing case final Widget trailing) trailing,
                        ],
                      ),
                      const SizedBox(height: 4),
                      fieldContent,
                    ],
                  )
                : fieldContent,
          ),
        ),
      ),
    );

    final Widget? helper = hint == null
        ? null
        : Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (helperIcon case final Widget icon) ...[
                  icon,
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    hint!,
                    style: contentTextStyle(
                      context,
                      color: _resolvedHintColor(),
                    ).copyWith(
                      fontSize: 12,
                      height: 16 / 12,
                    ),
                  ),
                ),
              ],
            ),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!usesInsideLabel && (label != null || labelTrailing != null)) ...[
          Row(
            children: [
              if (label != null)
                Expanded(
                  child: Text(
                    label!,
                    style: labelTextStyle(
                      context,
                      color: _resolvedLabelColor(),
                    ),
                  ),
                )
              else
                const Spacer(),
              if (labelTrailing case final Widget trailing) trailing,
            ],
          ),
          const SizedBox(height: 6),
        ],
        field,
        if (helper case final Widget helperWidget) helperWidget,
      ],
    );
  }
}
