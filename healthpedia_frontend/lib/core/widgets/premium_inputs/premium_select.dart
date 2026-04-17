import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'base_input_container.dart';
import 'premium_field_states.dart';
import 'premium_text_field.dart';

class PremiumSelect<T> extends StatefulWidget {
  const PremiumSelect({
    super.key,
    this.label,
    this.hint,
    this.placeholder = 'Select option',
    this.value,
    this.items,
    this.itemLabelBuilder,
    this.onChanged,
    this.state = PremiumFieldState.defaultState,
    this.onTap,
    this.isDark = true,
    this.backgroundColor,
    this.textColor,
    this.labelColor,
    this.placeholderColor,
    this.borderRadius,
    this.minHeight = 55,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
  });

  final String? label;
  final String? hint;
  final String? placeholder;
  final T? value;
  final List<T>? items;
  final String Function(T)? itemLabelBuilder;
  final ValueChanged<T?>? onChanged;
  final PremiumFieldState state;
  final VoidCallback? onTap;
  final bool isDark;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? placeholderColor;
  final double? borderRadius;
  final double minHeight;
  final EdgeInsets contentPadding;

  @override
  State<PremiumSelect<T>> createState() => _PremiumSelectState<T>();
}

class _PremiumSelectState<T> extends State<PremiumSelect<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  String? get _displayValue {
    final value = widget.value;
    if (value == null) {
      return null;
    }
    return widget.itemLabelBuilder?.call(value) ?? value.toString();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    if (widget.items == null || widget.items!.isEmpty) {
      return;
    }
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
    widget.onTap?.call();
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() => _isOpen = false);
    }
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;
    const verticalGap = 4.0;
    const screenPadding = 12.0;
    const preferredMaxHeight = 240.0;

    final availableBelow = screenSize.height - position.dy - size.height - screenPadding;
    final availableAbove = position.dy - screenPadding;
    final showAbove = availableBelow < 160 && availableAbove > availableBelow;
    final maxHeight = (showAbove ? availableAbove : availableBelow)
        .clamp(120.0, preferredMaxHeight);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeDropdown,
            ),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            targetAnchor: showAbove ? Alignment.topLeft : Alignment.bottomLeft,
            followerAnchor: showAbove ? Alignment.bottomLeft : Alignment.topLeft,
            offset: Offset(0, showAbove ? -verticalGap : verticalGap),
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: size.width,
                    constraints: BoxConstraints(maxHeight: maxHeight),
                    decoration: BoxDecoration(
                      color: (widget.isDark ? AppColors.neutral800 : AppColors.neutral100)
                          .withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (widget.isDark ? AppColors.neutral700 : AppColors.neutral200)
                            .withValues(alpha: 0.5),
                      ),
                    ),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      shrinkWrap: true,
                      itemCount: widget.items!.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: (widget.isDark ? AppColors.neutral700 : AppColors.neutral200)
                            .withValues(alpha: 0.3),
                        indent: 12,
                        endIndent: 12,
                      ),
                      itemBuilder: (context, index) {
                        final item = widget.items![index];
                        final label = widget.itemLabelBuilder?.call(item) ?? item.toString();
                        final isSelected = item == widget.value;
                        return InkWell(
                          onTap: () {
                            widget.onChanged?.call(item);
                            _closeDropdown();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    label,
                                    style: BaseInputContainer.contentTextStyle(
                                      context,
                                      color: isSelected
                                          ? AppColors.black
                                          : (widget.isDark ? AppColors.white : AppColors.neutral900),
                                    ).copyWith(
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_rounded,
                                    size: 18,
                                    color: AppColors.black,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: PremiumTextField(
        label: widget.label,
        hint: widget.hint,
        placeholder: widget.placeholder,
        valueText: _displayValue,
        state: _isOpen ? PremiumFieldState.focused : widget.state,
        readOnly: true,
        isDark: widget.isDark,
        onTap: _toggleDropdown,
        showTrailingChevron: true,
        backgroundColor: widget.backgroundColor,
        textColor: widget.textColor,
        labelColor: widget.labelColor,
        placeholderColor: widget.placeholderColor,
        borderRadius: widget.borderRadius,
        minHeight: widget.minHeight,
        contentPadding: widget.contentPadding,
      ),
    );
  }
}
