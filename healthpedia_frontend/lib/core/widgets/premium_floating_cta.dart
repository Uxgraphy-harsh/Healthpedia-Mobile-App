import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/kinetic_interaction.dart';

class PremiumFloatingCTA extends StatelessWidget {
  const PremiumFloatingCTA({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return KineticInteraction(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF1F2),
          borderRadius: BorderRadius.circular(99),
          border: Border.all(
            color: const Color(0xFFFFC3D7),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFCD577F).withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: const Color(0xFFCD577F),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTypography.label1SemiBold.copyWith(
                color: const Color(0xFFCD577F),
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
