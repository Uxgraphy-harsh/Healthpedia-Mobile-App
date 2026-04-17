import 'package:flutter/material.dart';
import 'premium_inputs/premium_field_states.dart' as states;
import 'premium_inputs/premium_text_field.dart' as master;
import 'premium_inputs/premium_select.dart' as sel;

// Re-export states for convenience
typedef PremiumFieldState = states.PremiumFieldState;

/// Legacy wrapper for [PremiumTextField] to ensure backward compatibility
/// while we migrate to the new modular suite.
class PremiumTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final PremiumFieldState state;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool showTrailingChevron;
  final int? maxLines;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? labelColor;

  const PremiumTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.state = states.PremiumFieldState.defaultState,
    this.readOnly = false,
    this.onTap,
    this.showTrailingChevron = false,
    this.maxLines = 1,
    this.backgroundColor,
    this.textColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return master.PremiumTextField(
      label: label,
      placeholder: hintText,
      controller: controller,
      prefix: prefixIcon != null ? Icon(prefixIcon, color: const Color(0xFFA3A3A3), size: 20) : null,
      state: state,
      readOnly: readOnly,
      onTap: onTap,
      showTrailingChevron: showTrailingChevron,
      maxLines: maxLines,
      backgroundColor: backgroundColor,
      textColor: textColor,
      labelColor: labelColor,
    );
  }
}

/// Legacy wrapper for [PremiumDropdown]
class PremiumDropdown extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final PremiumFieldState state;

  const PremiumDropdown({
    super.key,
    this.label,
    this.hintText,
    this.value,
    required this.items,
    required this.onChanged,
    this.state = states.PremiumFieldState.defaultState,
  });

  @override
  Widget build(BuildContext context) {
    return sel.PremiumSelect<String>(
      label: label,
      placeholder: hintText,
      value: value,
      items: items,
      onChanged: onChanged,
      state: state,
    );
  }
}
