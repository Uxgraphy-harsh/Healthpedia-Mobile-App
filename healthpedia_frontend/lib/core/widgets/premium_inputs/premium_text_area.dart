import 'package:flutter/material.dart';
import 'premium_field_states.dart';
import 'premium_text_field.dart';

class PremiumTextArea extends StatelessWidget {
  const PremiumTextArea({
    super.key,
    this.label,
    this.hint,
    this.placeholder,
    this.controller,
    this.state = PremiumFieldState.defaultState,
    this.minLines = 2,
    this.maxLines,
    this.maxLength,
    this.onChanged,
    this.isDark = true,
  });

  final String? label;
  final String? hint;
  final String? placeholder;
  final TextEditingController? controller;
  final PremiumFieldState state;
  final int minLines;
  final int? maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return PremiumTextField(
      label: label,
      hint: hint,
      placeholder: placeholder,
      controller: controller,
      state: state,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines ?? minLines,
      maxLength: maxLength,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      isDark: isDark,
      minHeight: 72,
      contentPadding: const EdgeInsets.all(16),
      showBorder: false,
    );
  }
}
