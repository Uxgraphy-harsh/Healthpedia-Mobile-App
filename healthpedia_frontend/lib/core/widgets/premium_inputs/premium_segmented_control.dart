import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'base_input_container.dart';

class PremiumSegmentedControl<T> extends StatelessWidget {
  const PremiumSegmentedControl({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.isDark = false,
  });

  final T selectedValue;
  final List<T> items;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onChanged;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.neutral800 : AppColors.backgroundTertiary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: items.map((item) {
          final isSelected = item == selectedValue;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(item),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark ? AppColors.neutral700 : AppColors.white)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    labelBuilder(item),
                    style: BaseInputContainer.contentTextStyle(
                      context,
                      color: isSelected
                          ? (isDark ? AppColors.white : AppColors.black)
                          : (isDark ? AppColors.neutral300 : AppColors.neutral600),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
