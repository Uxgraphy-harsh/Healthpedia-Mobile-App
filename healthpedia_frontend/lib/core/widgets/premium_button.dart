import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

enum PremiumButtonVariant { primary, secondary, tertiary, destructive }

enum PremiumButtonSize { xSmall, small, medium, large, docked }

class PremiumButton extends StatelessWidget {
  const PremiumButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = PremiumButtonVariant.primary,
    this.size = PremiumButtonSize.large,
    this.leading,
    this.trailing,
    this.fullWidth = true,
    this.loading = false,
    this.selected = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final PremiumButtonVariant variant;
  final PremiumButtonSize size;
  final Widget? leading;
  final Widget? trailing;
  final bool fullWidth;
  final bool loading;
  final bool selected;

  bool get _isEnabled => onPressed != null && !loading;

  double get _height {
    switch (size) {
      case PremiumButtonSize.xSmall:
        return 28;
      case PremiumButtonSize.small:
        return 48;
      case PremiumButtonSize.medium:
        return 48;
      case PremiumButtonSize.large:
      case PremiumButtonSize.docked:
        return 56;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case PremiumButtonSize.xSmall:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 4);
      case PremiumButtonSize.small:
      case PremiumButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 14);
      case PremiumButtonSize.large:
      case PremiumButtonSize.docked:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    }
  }

  TextStyle get _textStyle {
    switch (size) {
      case PremiumButtonSize.xSmall:
        return AppTypography.label3.copyWith(fontWeight: FontWeight.w500);
      case PremiumButtonSize.small:
      case PremiumButtonSize.medium:
        return AppTypography.label2.copyWith(fontWeight: FontWeight.w500);
      case PremiumButtonSize.large:
      case PremiumButtonSize.docked:
        return AppTypography.body1Medium.copyWith(height: 24 / 18);
    }
  }

  Color _backgroundColor() {
    if (!_isEnabled) {
      return AppColors.neutral200;
    }

    switch (variant) {
      case PremiumButtonVariant.primary:
        return AppColors.neutral950;
      case PremiumButtonVariant.secondary:
        return AppColors.neutral100;
      case PremiumButtonVariant.tertiary:
        return Colors.transparent;
      case PremiumButtonVariant.destructive:
        return AppColors.red500;
    }
  }

  Color _foregroundColor() {
    if (!_isEnabled) {
      return AppColors.neutral500;
    }

    switch (variant) {
      case PremiumButtonVariant.primary:
      case PremiumButtonVariant.destructive:
        return AppColors.white;
      case PremiumButtonVariant.secondary:
      case PremiumButtonVariant.tertiary:
        return AppColors.neutral950;
    }
  }

  BorderSide? _borderSide() {
    if (variant == PremiumButtonVariant.tertiary) {
      return BorderSide(color: _isEnabled ? AppColors.neutral300 : AppColors.neutral200);
    }
    if (variant == PremiumButtonVariant.secondary) {
      return BorderSide(color: _isEnabled ? AppColors.neutral200 : AppColors.neutral100);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final foregroundColor = _foregroundColor();
    final borderSide = _borderSide();
    final content = AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child: loading
          ? SizedBox(
              key: const ValueKey('loading'),
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
              ),
            )
          : Row(
              key: ValueKey<String>('label:$label:$selected'),
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null) ...[
                  IconTheme(
                    data: IconThemeData(color: foregroundColor, size: 18),
                    child: leading!,
                  ),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _textStyle.copyWith(color: foregroundColor),
                  ),
                ),
                if (selected) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.check_rounded, color: foregroundColor, size: 18),
                ] else if (trailing != null) ...[
                  const SizedBox(width: 8),
                  IconTheme(
                    data: IconThemeData(color: foregroundColor, size: 18),
                    child: trailing!,
                  ),
                ],
              ],
            ),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: fullWidth ? double.infinity : null,
      height: _height,
      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(8),
        border: borderSide == null ? null : Border.fromBorderSide(borderSide),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: _padding,
            child: Center(child: content),
          ),
        ),
      ),
    );
  }
}

class PremiumButtonDock extends StatelessWidget {
  const PremiumButtonDock({
    super.key,
    required this.child,
    this.includeShadow = false,
    this.includeHomeIndicatorSpacing = true,
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
  });

  final Widget child;
  final bool includeShadow;
  final bool includeHomeIndicatorSpacing;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: includeShadow
            ? [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.12),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: padding.copyWith(
          bottom: includeHomeIndicatorSpacing
              ? padding.bottom + (bottomInset > 0 ? bottomInset : 10)
              : padding.bottom,
        ),
        child: child,
      ),
    );
  }
}
