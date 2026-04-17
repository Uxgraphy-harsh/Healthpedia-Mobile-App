import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';

/// A premium standardized switch component for the Healthpedia "2026 Tactile Depth" system.
/// Uses a custom implementation for pixel-perfect tap responsiveness and smooth animations.
class PremiumSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const PremiumSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onChanged(!value);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: 36,
          height: 20,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: value ? AppColors.blue400 : AppColors.neutral300,
            borderRadius: BorderRadius.circular(100),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.2),
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
