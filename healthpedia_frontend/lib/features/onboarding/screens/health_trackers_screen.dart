import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/navigation/premium_route.dart';
import 'package:healthpedia_frontend/core/utils/app_responsive.dart';
import 'package:healthpedia_frontend/core/widgets/premium_switch.dart';
import 'package:healthpedia_frontend/features/onboarding/screens/permissions_screen.dart';
import 'package:healthpedia_frontend/features/onboarding/widgets/onboarding_footer_actions.dart';

/// The Health Trackers onboarding screen.
/// Final production version with global PremiumSwitch component.
class HealthTrackersScreen extends StatefulWidget {
  const HealthTrackersScreen({super.key});

  @override
  State<HealthTrackersScreen> createState() => _HealthTrackersScreenState();
}

class _HealthTrackersScreenState extends State<HealthTrackersScreen> {
  final Map<String, bool> _connectedStates = {
    'Google Fit': true,
    'Apple Health': true,
    'Samsung Health': false,
  };

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppResponsive.horizontalPadding(context);
    final titleSize = AppResponsive.onboardingTitleSize(context);
    final titleTopSpacing = AppResponsive.onboardingHeaderTopSpacing(context);
    final sectionSpacing = AppResponsive.onboardingSectionSpacing(context);

    return Scaffold(
      backgroundColor: AppColors.maroon700,
      body: Stack(
        children: [
          // ── Background Floral Watermark ──────────
          Positioned(
            left: -327,
            top: 351,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/Repeat group 4.png',
                width: 1045,
                height: 1045,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Progress Bar ──────────
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: AppSpacing.space16,
                  ),
                  child: ResponsiveConstrainedContent(
                    maxWidth: AppResponsive.onboardingContentMaxWidth(context),
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: 0.75,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.pink200,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: ResponsiveConstrainedContent(
                      maxWidth: AppResponsive.onboardingContentMaxWidth(context),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: titleTopSpacing),
                          Text(
                            'Connect devices\nand apps',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: titleSize,
                              height: (titleSize + 12) / titleSize,
                              color: AppColors.rose50,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          SizedBox(height: sectionSpacing),

                          _buildTrackerCard(
                            'Google Fit',
                            'assets/Figma MCP Assets/CommonAssets/Icons/image 27.png',
                            _connectedStates['Google Fit']!,
                            (v) => setState(() => _connectedStates['Google Fit'] = v),
                          ),
                          const SizedBox(height: AppSpacing.space16),
                          _buildTrackerCard(
                            'Apple Health',
                            'assets/Figma MCP Assets/CommonAssets/Icons/image 6.png',
                            _connectedStates['Apple Health']!,
                            (v) => setState(() => _connectedStates['Apple Health'] = v),
                          ),
                          const SizedBox(height: AppSpacing.space16),
                          _buildTrackerCard(
                            'Samsung Health',
                            'assets/Figma MCP Assets/CommonAssets/Icons/image 7.png',
                            _connectedStates['Samsung Health']!,
                            (v) => setState(() => _connectedStates['Samsung Health'] = v),
                          ),

                          const SizedBox(height: 48),
                          SizedBox(
                            height: AppResponsive.clampBottomSpacer(
                              context,
                              min: 16,
                              max: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                OnboardingFooterActions(
                  primary: FilledButton(
                    onPressed: () {
                      context.pushPremium(const PermissionsScreen());
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.pink600,
                      foregroundColor: AppColors.rose950,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      textStyle: AppTypography.body2.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackerCard(
    String name,
    String iconPath,
    bool isEnabled,
    ValueChanged<bool> onChanged,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isEnabled
            ? AppColors.blue400.withValues(alpha: 0.3)
            : AppColors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isEnabled
              ? AppColors.blue400.withValues(alpha: 0.5)
              : AppColors.white.withValues(alpha: 0.2),
          width: isEnabled ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              iconPath,
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.image_not_supported_rounded,
                size: 20,
                color: Colors.white70,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Geist',
                  ),
                ),
                const SizedBox(height: 2),
                if (isEnabled)
                  Row(
                    children: [
                      Text(
                        'Connected',
                        style: AppTypography.label3.copyWith(
                          color: AppColors.green300,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '•',
                        style: AppTypography.label3.copyWith(
                          color: AppColors.green300,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Syncing...',
                        style: AppTypography.label3.copyWith(
                          color: AppColors.neutral400,
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    'Not connected',
                    style: AppTypography.label3.copyWith(
                      color: AppColors.neutral400,
                    ),
                  ),
              ],
            ),
          ),
          PremiumSwitch(
            value: isEnabled,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
