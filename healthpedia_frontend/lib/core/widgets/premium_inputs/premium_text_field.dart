import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'base_input_container.dart';
import 'premium_field_states.dart';

class PremiumTextField extends StatefulWidget {
  const PremiumTextField({
    super.key,
    this.label,
    this.hint,
    this.placeholder,
    this.controller,
    this.valueText,
    this.state = PremiumFieldState.defaultState,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.showTrailingChevron = false,
    this.isDark = true,
    this.backgroundColor,
    this.textColor,
    this.labelColor,
    this.placeholderColor,
    this.borderColor,
    this.borderRadius,
    this.minLines,
    this.maxLength,
    this.textAlignVertical,
    this.minHeight = 55,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
    this.showBorder = false,
    this.labelInside,
    this.showHelperIcon = true,
    this.forceLabelInside = false,
  });

  final String? label;
  final String? hint;
  final String? placeholder;
  final TextEditingController? controller;
  final String? valueText;
  final PremiumFieldState state;
  final bool readOnly;
  final bool autofocus;
  final bool obscureText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final bool showTrailingChevron;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? placeholderColor;
  final Color? borderColor;
  final bool isDark;
  final double? borderRadius;
  final int? minLines;
  final int? maxLength;
  final TextAlignVertical? textAlignVertical;
  final double minHeight;
  final EdgeInsets contentPadding;
  final bool showBorder;
  final bool? labelInside;
  final bool showHelperIcon;
  final bool forceLabelInside;

  @override
  State<PremiumTextField> createState() => _PremiumTextFieldState();
}

class _PremiumTextFieldState extends State<PremiumTextField> {
  late final FocusNode _focusNode;
  TextEditingController? _internalController;
  bool _isFocused = false;

  TextEditingController get _effectiveController {
    return widget.controller ?? (_internalController ??= TextEditingController());
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _syncValueText();
  }

  @override
  void didUpdateWidget(covariant PremiumTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueText != widget.valueText || oldWidget.controller != widget.controller) {
      _syncValueText();
    }
  }

  void _syncValueText() {
    if (widget.controller == null && widget.valueText != null) {
      final controller = _effectiveController;
      if (controller.text != widget.valueText) {
        controller.value = controller.value.copyWith(
          text: widget.valueText,
          selection: TextSelection.collapsed(offset: widget.valueText!.length),
          composing: TextRange.empty,
        );
      }
    }
  }

  void _handleFocusChange() {
    if (_isFocused != _focusNode.hasFocus) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = _effectiveController.text.trim().isNotEmpty;
    final usesInsideLabel = widget.label != null && (widget.labelInside ?? !widget.isDark);
    final showsCompactLabel = usesInsideLabel && (_isFocused || hasValue || widget.hint != null || widget.forceLabelInside);
    final showsProminentLabel = usesInsideLabel && !showsCompactLabel;
    final labelTrailing = widget.maxLength != null
        ? Text(
            '${_effectiveController.text.length}/${widget.maxLength}',
            style: BaseInputContainer.labelTextStyle(
              context,
              color: widget.isDark ? AppColors.neutral300 : AppColors.neutral600,
            ),
          )
        : null;

    return BaseInputContainer(
      label: showsCompactLabel ? widget.label : null,
      labelTrailing: labelTrailing,
      hint: widget.hint,
      state: widget.state,
      isFocused: _isFocused,
      prefix: widget.prefix ?? _buildPrefix(),
      suffix: _buildSuffix(),
      isDark: widget.isDark,
      backgroundColor: widget.backgroundColor,
      labelColor: widget.labelColor,
      hintColor: widget.state.isError ? AppColors.error : null,
      borderColor: widget.borderColor,
      borderRadius: widget.borderRadius,
      contentPadding: widget.contentPadding,
      minHeight: widget.minHeight,
      showBorder: widget.showBorder,
      labelInside: showsCompactLabel,
      showHelperIcon: widget.showHelperIcon,
      child: TextField(
        controller: _effectiveController,
        focusNode: _focusNode,
        showCursor: true,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        textAlignVertical: widget.textAlignVertical,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        enabled: !widget.state.isDisabled,
        onChanged: (val) {
          widget.onChanged?.call(val);
          if (widget.maxLength != null) {
            setState(() {});
          }
        },
        onSubmitted: widget.onSubmitted,
        onTap: widget.onTap,
        cursorColor: widget.isDark ? AppColors.primary : AppColors.neutral950,
        style: BaseInputContainer.contentTextStyle(
          context,
          color: widget.textColor ??
              (widget.state.isDisabled
                  ? (widget.isDark ? AppColors.neutral400 : AppColors.neutral500)
                  : (widget.isDark ? AppColors.white : AppColors.black)),
        ),
        decoration: InputDecoration(
          filled: false,
          hintText: showsProminentLabel ? widget.label : widget.placeholder,
          hintStyle: BaseInputContainer.contentTextStyle(
            context,
            color: widget.placeholderColor ??
                (widget.isDark ? AppColors.neutral300 : AppColors.neutral400),
          ).copyWith(
            fontSize: showsProminentLabel ? 18 : 14,
            height: showsProminentLabel ? 24 / 18 : 20 / 14,
            fontWeight: FontWeight.w400,
          ),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: widget.maxLines == null || widget.maxLines! > 1 ? 0 : 2,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }

  Widget? _buildPrefix() {
    if (widget.prefix != null || widget.prefixIcon == null) {
      return widget.prefix;
    }
    return Icon(
      widget.prefixIcon,
      size: 16,
      color: _isFocused
          ? AppColors.primary
          : (widget.isDark ? AppColors.neutral300 : AppColors.neutral700),
    );
  }

  Widget? _buildSuffix() {
    if (widget.suffix != null) {
      return widget.suffix;
    }
    if (widget.state == PremiumFieldState.loading) {
      return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      );
    }
    if (widget.state == PremiumFieldState.success) {
      return const Icon(Icons.check_circle_rounded, size: 16, color: AppColors.success);
    }
    if (widget.state == PremiumFieldState.error) {
      return const Icon(Icons.error_outline_rounded, size: 16, color: AppColors.error);
    }
    if (widget.showTrailingChevron) {
      return Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 16,
        color: widget.isDark ? AppColors.neutral300 : AppColors.neutral700,
      );
    }
    if (widget.suffixIcon != null) {
      return Icon(
        widget.suffixIcon,
        size: 16,
        color: _isFocused
            ? AppColors.primary
            : (widget.isDark ? AppColors.neutral300 : AppColors.neutral700),
      );
    }
    return null;
  }
}
