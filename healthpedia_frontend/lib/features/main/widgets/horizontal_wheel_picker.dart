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

  const HorizontalWheelPicker({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    required this.unit,
    required this.onChanged,
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
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: RotatedBox(
            quarterTurns: -1,
            child: ListWheelScrollView.useDelegate(
              controller: _controller,
              itemExtent: 60,
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
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 100),
                        style: isSelected
                            ? AppTypography.h3.copyWith(
                                color: AppColors.neutral950,
                                fontWeight: FontWeight.w600,
                              )
                            : AppTypography.h5.copyWith(
                                color: AppColors.neutral400,
                                fontWeight: FontWeight.w400,
                              ),
                        child: Text('$value'),
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
            color: AppColors.neutral500,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
