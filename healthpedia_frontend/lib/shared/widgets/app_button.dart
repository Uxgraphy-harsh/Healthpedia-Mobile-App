import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/widgets/premium_button.dart';

class AppButton extends StatelessWidget {
  const AppButton({
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

  @override
  Widget build(BuildContext context) {
    return PremiumButton(
      label: label,
      onPressed: onPressed,
      variant: variant,
      size: size,
      leading: leading,
      trailing: trailing,
      fullWidth: fullWidth,
      loading: loading,
      selected: selected,
    );
  }
}
