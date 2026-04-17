import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/utils/app_responsive.dart';

class OnboardingFooterActions extends StatelessWidget {
  const OnboardingFooterActions({
    super.key,
    required this.primary,
    this.onBackTap,
  });

  final Widget primary;
  final VoidCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppResponsive.horizontalPadding(context);
    final bottomSpacing = AppResponsive.clampBottomSpacer(
      context,
      min: 12,
      max: 32,
    );
    final actionExtent = AppResponsive.onboardingActionExtent(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        16,
        horizontalPadding,
        bottomSpacing,
      ),
      child: ResponsiveConstrainedContent(
        maxWidth: AppResponsive.onboardingContentMaxWidth(context),
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            SizedBox(
              width: actionExtent,
              height: actionExtent,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.5),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.white),
                  onPressed: onBackTap ?? () => Navigator.of(context).pop(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(height: actionExtent, child: primary),
            ),
          ],
        ),
      ),
    );
  }
}
