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
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildSegment(AllergySeverity.mild, 'Mild', AppColors.green600, const Color(0xFFF0FDF4)),
          _buildSegment(AllergySeverity.moderate, 'Moderate', AppColors.orange600, const Color(0xFFFFF7ED)),
          _buildSegment(AllergySeverity.severe, 'Severe', AppColors.red600, const Color(0xFFFEF2F2)),
        ],
      ),
    );
  }

  Widget _buildSegment(AllergySeverity severity, String label, Color activeTextColor, Color activeBgColor) {
    final isSelected = selectedSeverity == severity;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          onChanged(severity);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? activeBgColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected 
                ? [BoxShadow(color: activeTextColor.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: AppTypography.label2.copyWith(
                color: isSelected ? activeTextColor : AppColors.neutral500,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
