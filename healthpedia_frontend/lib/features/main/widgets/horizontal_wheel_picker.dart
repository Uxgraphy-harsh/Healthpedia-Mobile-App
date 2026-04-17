import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

class HorizontalWheelPicker extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;
  final String unit;
  final ValueChanged<int> onChanged;
  final bool isDark;

  const HorizontalWheelPicker({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    required this.unit,
    required this.onChanged,
    this.isDark = false,
  });

  @override
  State<HorizontalWheelPicker> createState() => _HorizontalWheelPickerState();
}

class _HorizontalWheelPickerState extends State<HorizontalWheelPicker> {
  late FixedExtentScrollController _controller;
  int _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _controller = FixedExtentScrollController(
      initialItem: widget.initialValue - widget.minValue,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = widget.isDark ? AppColors.white : AppColors.neutral950;
    final Color unselectedColor = widget.isDark ? AppColors.white.withValues(alpha: 0.4) : AppColors.neutral400;
    final Color unitColor = widget.isDark ? AppColors.white.withValues(alpha: 0.6) : AppColors.neutral500;

    return Column(
      children: [
        SizedBox(
          height: 92,
          child: RotatedBox(
            quarterTurns: -1,
            child: ListWheelScrollView.useDelegate(
              controller: _controller,
              itemExtent: 68,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                HapticFeedback.lightImpact();
                setState(() {
                  _currentValue = widget.minValue + index;
                });
                widget.onChanged(_currentValue);
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  final value = widget.minValue + index;
                  final isSelected = value == _currentValue;
                  return RotatedBox(
                    quarterTurns: 1,
                    child: Center(
                      child: SizedBox(
                        width: 64,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '$value',
                            maxLines: 1,
                            softWrap: false,
                            style: isSelected
                                ? AppTypography.h4.copyWith(
                                    color: selectedColor,
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                  )
                                : AppTypography.h5.copyWith(
                                    color: unselectedColor,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: widget.maxValue - widget.minValue + 1,
              ),
            ),
          ),
        ),
        Text(
          widget.unit,
          style: AppTypography.label2.copyWith(
            color: unitColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
