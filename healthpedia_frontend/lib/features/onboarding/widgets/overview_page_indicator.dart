import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';

/// Horizontal page indicator dots for the overview carousel.
/// The active dot is elongated (24px wide) and pink; inactive dots are
/// small circles (6px) in neutral gray. Matches Figma node 63:570.
class OverviewPageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const OverviewPageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
          width: isActive ? 24 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.rose500 : AppColors.neutral300,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
        );
      }),
    );
  }
}
