import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/navigation/premium_route.dart';
import 'package:healthpedia_frontend/core/utils/app_responsive.dart';
import 'package:healthpedia_frontend/features/onboarding/screens/loading_screen.dart';
import 'package:healthpedia_frontend/features/onboarding/widgets/onboarding_footer_actions.dart';

/// The Permissions onboarding screen.
/// "Last step!" screen requesting Contacts and Notifications permissions.
class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _contactsEnabled = true;
  bool _notificationsEnabled = false;

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
          // ── Background Watermark ──────────
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

          // ── Main Content ──────────
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
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.pink200,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: ResponsiveConstrainedContent(
                      maxWidth: AppResponsive.onboardingContentMaxWidth(
                        context,
                      ),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: titleTopSpacing),
                          Text(
                            'Last step!',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: titleSize,
                              height: (titleSize + 12) / titleSize,
                              color: AppColors.rose50,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          SizedBox(height: sectionSpacing),

                          // ── Permission Cards ──────────
                          _buildPermissionCard(
                            iconPath:
                                'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/contacts.svg',
                            title: 'Check contacts',
                            description:
                                'Connect with your family members easily.\nWe do not store nor share this data, and\nwe\'ll never contact anyone on your behalf.',
                            value: _contactsEnabled,
                            onChanged: (val) =>
                                setState(() => _contactsEnabled = val),
                          ),
                          const SizedBox(height: 12),
                          _buildPermissionCard(
                            iconPath:
                                'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/notifications.svg',
                            title: 'Notifications',
                            description: 'We go light on notifications.',
                            value: _notificationsEnabled,
                            onChanged: (val) =>
                                setState(() => _notificationsEnabled = val),
                          ),

                          const SizedBox(height: 32),

                          // ── Privacy Note ──────────
                          Center(
                            child: Column(
                              children: [
                                const Text(
                                  'We take your privacy (and our own) seriously.',
                                  style: TextStyle(
                                    color: Color(0xFFA3A3A3), // neutral/400
                                    fontSize: 14,
                                    fontFamily: 'Geist',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () {
                                    // Learn more action
                                  },
                                  child: const Text(
                                    'Learn more',
                                    style: TextStyle(
                                      color: Color(0xFFFAFAFA), // neutral/50
                                      fontSize: 14,
                                      fontFamily: 'Geist',
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xFFFAFAFA),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: AppResponsive.clampBottomSpacer(
                              context,
                              min: 16,
                              max: 28,
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
                      context.pushPremium(const LoadingScreen());
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFF66B9A),
                      foregroundColor: const Color(0xFF49001E),
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

  Widget _buildPermissionCard({
    required String iconPath,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.15),
          width: 0.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      iconPath,
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: AppTypography.body2SemiBold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: AppTypography.label3.copyWith(
                    color: AppColors.neutral300,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Transform.scale(
            scale: 0.75, // Scale down to match Figma perfectly
            child: CupertinoSwitch(
              value: value,
              activeTrackColor: Colors.blue[400],
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
