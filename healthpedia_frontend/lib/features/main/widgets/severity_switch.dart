import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

enum AllergySeverity { mild, moderate, severe }

class SeveritySwitch extends StatelessWidget {
  final AllergySeverity selectedSeverity;
  final ValueChanged<AllergySeverity> onChanged;

  const SeveritySwitch({
    super.key,
    required this.selectedSeverity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color containerBorder;
    Color containerBg;

    switch (selectedSeverity) {
      case AllergySeverity.mild:
        containerBorder = const Color(0xFFDCFCE7); // green/100
        containerBg = const Color(0xFFF7FDF9); // Solid very light green
        break;
      case AllergySeverity.moderate:
        containerBorder = const Color(0xFFFFEDD5); // orange/100
        containerBg = const Color(0xFFFFFBF7); // Solid very light orange
        break;
      case AllergySeverity.severe:
        containerBorder = const Color(0xFFFEE2E2); // red/100
        containerBg = const Color(0xFFFFF9F9); // Solid very light red
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: containerBg,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: containerBorder, width: 1),
      ),
      child: Row(
        children: [
          _buildSegment(
            AllergySeverity.mild, 
            'Mild', 
            AppColors.green600, 
            const Color(0xFFF0FDF4),
            const Color(0xFFBBF7D0), // green/200
          ),
          _buildSegment(
            AllergySeverity.moderate, 
            'Moderate', 
            AppColors.orange600, 
            const Color(0xFFFFF7ED),
            const Color(0xFFFED7AA), // orange/200
          ),
          _buildSegment(
            AllergySeverity.severe, 
            'Severe', 
            AppColors.red600, 
            const Color(0xFFFEF2F2),
            const Color(0xFFFECACA), // red/200
          ),
        ],
      ),
    );
  }

  Widget _buildSegment(
    AllergySeverity severity, 
    String label, 
    Color activeTextColor, 
    Color activeBgColor,
    Color activeBorderColor,
  ) {
    final isSelected = selectedSeverity == severity;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          onChanged(severity);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? activeBgColor : activeBgColor.withOpacity(0),
            borderRadius: BorderRadius.circular(99),
            border: Border.all(
              color: isSelected ? activeBorderColor : activeBorderColor.withOpacity(0),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTypography.label2.copyWith(
                color: isSelected ? activeTextColor : AppColors.neutral500,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
