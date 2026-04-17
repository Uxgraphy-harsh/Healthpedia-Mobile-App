import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'premium_field_states.dart';
import 'premium_text_field.dart';

class PremiumSearchField extends StatefulWidget {
  const PremiumSearchField({
    super.key,
    this.label,
    this.hint,
    this.placeholder = 'Search...',
    this.controller,
    this.state = PremiumFieldState.defaultState,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.isDark = true,
    this.backgroundColor,
    this.textColor,
    this.placeholderColor,
    this.borderRadius = 999,
    this.minHeight = 52,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  });

  final String? label;
  final String? hint;
  final String placeholder;
  final TextEditingController? controller;
  final PremiumFieldState state;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool isDark;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? placeholderColor;
  final double borderRadius;
  final double minHeight;
  final EdgeInsets contentPadding;

  @override
  State<PremiumSearchField> createState() => _PremiumSearchFieldState();
}

class _PremiumSearchFieldState extends State<PremiumSearchField> {
  TextEditingController? _internalController;
  bool _showClear = false;

  TextEditingController get _effectiveController {
    return widget.controller ?? (_internalController ??= TextEditingController());
  }

  @override
  void initState() {
    super.initState();
    _effectiveController.addListener(_handleTextChange);
    _showClear = _effectiveController.text.isNotEmpty;
  }

  @override
  void didUpdateWidget(covariant PremiumSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleTextChange);
      if (oldWidget.controller == null) {
        _internalController?.removeListener(_handleTextChange);
      }
      _effectiveController.addListener(_handleTextChange);
      _showClear = _effectiveController.text.isNotEmpty;
    }
  }

  void _handleTextChange() {
    final next = _effectiveController.text.isNotEmpty;
    if (next != _showClear) {
      setState(() => _showClear = next);
    }
  }

  void _clear() {
    _effectiveController.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleTextChange);
    _internalController?.removeListener(_handleTextChange);
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PremiumTextField(
      label: widget.label,
      hint: widget.hint,
      placeholder: widget.placeholder,
      controller: _effectiveController,
      state: widget.state,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      borderRadius: widget.borderRadius,
      prefixIcon: Icons.search_rounded,
      isDark: widget.isDark,
      backgroundColor: widget.backgroundColor,
      textColor: widget.textColor,
      placeholderColor: widget.placeholderColor,
      minHeight: widget.minHeight,
      contentPadding: widget.contentPadding,
      suffix: _showClear
          ? GestureDetector(
              onTap: _clear,
              child: Icon(
                Icons.close_rounded,
                size: 16,
                color: widget.isDark ? AppColors.neutral300 : AppColors.neutral700,
              ),
            )
          : null,
    );
  }
}
