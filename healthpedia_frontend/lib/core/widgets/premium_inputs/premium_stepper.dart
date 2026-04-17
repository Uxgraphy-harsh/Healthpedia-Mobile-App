import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'premium_field_states.dart';
import 'premium_text_field.dart';

class PremiumStepper extends StatefulWidget {
  const PremiumStepper({
    super.key,
    this.label,
    this.placeholder,
    required this.value,
    this.min = 0,
    this.max = 999,
    this.step = 1,
    required this.onChanged,
    this.state = PremiumFieldState.defaultState,
    this.isDark = true,
    this.unit,
    this.minHeight = 55,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
    this.backgroundColor,
    this.textColor,
    this.labelColor,
    this.placeholderColor,
    this.borderRadius,
    this.showUnitHint = true,
  });

  final String? label;
  final String? placeholder;
  final int value;
  final int min;
  final int max;
  final int step;
  final ValueChanged<int> onChanged;
  final PremiumFieldState state;
  final bool isDark;
  final String? unit;
  final double minHeight;
  final EdgeInsets contentPadding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? placeholderColor;
  final double? borderRadius;
  final bool showUnitHint;

  @override
  State<PremiumStepper> createState() => _PremiumStepperState();
}

class _PremiumStepperState extends State<PremiumStepper> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
  }

  @override
  void didUpdateWidget(covariant PremiumStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && _controller.text != widget.value.toString()) {
      _controller.text = widget.value.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _increment() {
    if (widget.value + widget.step <= widget.max) {
      widget.onChanged(widget.value + widget.step);
    }
  }

  void _decrement() {
    if (widget.value - widget.step >= widget.min) {
      widget.onChanged(widget.value - widget.step);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canDecrement = widget.value > widget.min && widget.state != PremiumFieldState.disabled;
    final canIncrement = widget.value < widget.max && widget.state != PremiumFieldState.disabled;

    return PremiumTextField(
      label: widget.label,
      placeholder: widget.placeholder,
      controller: _controller,
      state: widget.state,
      isDark: widget.isDark,
      keyboardType: TextInputType.number,
      backgroundColor: widget.backgroundColor,
      textColor: widget.textColor,
      labelColor: widget.labelColor,
      placeholderColor: widget.placeholderColor,
      borderRadius: widget.borderRadius,
      minHeight: widget.minHeight,
      contentPadding: widget.contentPadding,
      onChanged: (val) {
        final parsed = int.tryParse(val);
        if (parsed != null && parsed >= widget.min && parsed <= widget.max) {
          widget.onChanged(parsed);
        }
      },
      suffix: Container(
        decoration: BoxDecoration(
          color: widget.isDark
              ? AppColors.white.withValues(alpha: 0.1)
              : AppColors.black.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: widget.isDark
                ? AppColors.white.withValues(alpha: 0.1)
                : AppColors.black.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: canIncrement ? _increment : null,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.keyboard_arrow_up_rounded,
                  size: 16,
                  color: canIncrement
                      ? (widget.isDark ? AppColors.white : AppColors.black)
                      : (widget.isDark ? AppColors.neutral500 : AppColors.neutral400),
                ),
              ),
            ),
            GestureDetector(
              onTap: canDecrement ? _decrement : null,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16,
                  color: canDecrement
                      ? (widget.isDark ? AppColors.white : AppColors.black)
                      : (widget.isDark ? AppColors.neutral500 : AppColors.neutral400),
                ),
              ),
            ),
          ],
        ),
      ),
      hint: widget.showUnitHint ? widget.unit : null,
    );
  }
}
