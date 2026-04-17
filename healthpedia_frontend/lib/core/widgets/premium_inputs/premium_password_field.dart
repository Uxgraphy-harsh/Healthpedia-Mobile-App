import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'premium_field_states.dart';
import 'premium_text_field.dart';

class PremiumPasswordField extends StatefulWidget {
  const PremiumPasswordField({
    super.key,
    this.label,
    this.hint,
    this.placeholder = 'Enter password',
    this.controller,
    this.state = PremiumFieldState.defaultState,
    this.onChanged,
    this.onSubmitted,
    this.isDark = true,
  });

  final String? label;
  final String? hint;
  final String placeholder;
  final TextEditingController? controller;
  final PremiumFieldState state;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool isDark;

  @override
  State<PremiumPasswordField> createState() => _PremiumPasswordFieldState();
}

class _PremiumPasswordFieldState extends State<PremiumPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return PremiumTextField(
      label: widget.label,
      hint: widget.hint,
      placeholder: widget.placeholder,
      controller: widget.controller,
      state: widget.state,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      obscureText: _obscureText,
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      isDark: widget.isDark,
      suffix: GestureDetector(
        onTap: () => setState(() => _obscureText = !_obscureText),
        child: Icon(
          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: 16,
          color: widget.state.isDisabled
              ? (widget.isDark ? AppColors.neutral500 : AppColors.neutral400)
              : (widget.isDark ? AppColors.neutral300 : AppColors.neutral700),
        ),
      ),
    );
  }
}
