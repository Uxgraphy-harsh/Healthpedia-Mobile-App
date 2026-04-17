import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'base_input_container.dart';
import 'premium_field_states.dart';

class PremiumPINField extends StatefulWidget {
  const PremiumPINField({
    super.key,
    this.label,
    this.hint,
    this.length = 4,
    this.onCompleted,
    this.onChanged,
    this.state = PremiumFieldState.defaultState,
    this.autofocus = false,
    this.isDark = true,
    this.obscureText = false,
  });

  final String? label;
  final String? hint;
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final PremiumFieldState state;
  final bool autofocus;
  final bool isDark;
  final bool obscureText;

  @override
  State<PremiumPINField> createState() => _PremiumPINFieldState();
}

class _PremiumPINFieldState extends State<PremiumPINField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    for (final node in _focusNodes) {
      node.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _emitState() {
    final value = _controllers.map((controller) => controller.text).join();
    widget.onChanged?.call(value);
    if (value.length == widget.length && !value.contains('')) {
      widget.onCompleted?.call(value);
    }
  }

  void _handleChanged(int index, String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length > 1) {
      for (var i = 0; i < widget.length && i < cleaned.length; i++) {
        _controllers[i].text = cleaned[i];
      }
      if (cleaned.length < widget.length) {
        _focusNodes[cleaned.length].requestFocus();
      }
      setState(_emitState);
      return;
    }

    _controllers[index].text = cleaned;
    if (cleaned.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (cleaned.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(_emitState);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: BaseInputContainer.labelTextStyle(
              context,
              color: widget.isDark ? AppColors.white : AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.length, (index) {
            final isFocused = _focusNodes[index].hasFocus;
            final boxHeight = widget.isDark ? 40.0 : 48.0;
            final radius = widget.isDark ? 8.0 : 12.0;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: index == 0 ? 0 : 4.0,
                ).copyWith(
                  left: index == 0 ? 0 : 4.0,
                  right: index == widget.length - 1 ? 0 : 4.0,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  height: boxHeight,
                  decoration: BoxDecoration(
                    color: widget.isDark ? AppColors.neutral800 : AppColors.white,
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(
                      color: widget.state.isError
                          ? AppColors.error
                          : widget.state == PremiumFieldState.success
                              ? AppColors.success
                              : (isFocused ? (widget.isDark ? AppColors.primary : AppColors.neutral950) : (widget.isDark ? Colors.transparent : AppColors.neutral200)),
                      width: isFocused ? 1.5 : 1,
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      autofocus: widget.autofocus && index == 0,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      obscureText: widget.obscureText,
                      obscuringCharacter: 'o',
                      cursorColor: widget.isDark ? AppColors.primary : AppColors.neutral950,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      style: BaseInputContainer.contentTextStyle(
                        context,
                        color: widget.isDark ? AppColors.white : AppColors.black,
                      ).copyWith(
                        fontSize: widget.isDark ? 16 : 20,
                        height: 1,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        isDense: true,
                        filled: false,
                        fillColor: Colors.transparent,
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) => _handleChanged(index, value),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        if (widget.hint != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.hint!,
            style: BaseInputContainer.contentTextStyle(
              context,
              color: widget.state.isError
                  ? AppColors.error
                  : (widget.isDark ? AppColors.neutral300 : AppColors.neutral600),
            ),
          ),
        ],
      ],
    );
  }
}
