import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/features/onboarding/screens/loading_screen.dart';

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
                'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/Repeat group 4.png',
                width: 1045,
                height: 1045,
                fit: BoxFit.cover,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space16,
                    vertical: AppSpacing.space16,
                  ),
                  child: Container(
                    height: 4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2), // Inactive track
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: double.infinity, // 100% width per Figma
                        decoration: BoxDecoration(
                          color: AppColors.pink200, // Active indicator
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSpacing.space24),
                          // ── Title ──────────
                          const Text(
                            'Last step!',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 56, // Title-3
                              height: 68 / 56, // line-height
                              color: AppColors.rose50,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.space32),

                          // ── Permission Cards ──────────
                          _buildPermissionCard(
                            iconPath: 'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/contacts.svg',
                            title: 'Check contacts',
                            description: 'Connect with your family members easily.\nWe do not store nor share this data, and\nwe\'ll never contact anyone on your behalf.',
                            value: _contactsEnabled,
                            onChanged: (val) => setState(() => _contactsEnabled = val),
                          ),
                          const SizedBox(height: 12),
                          _buildPermissionCard(
                            iconPath: 'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/notifications.svg',
                            title: 'Notifications',
                            description: 'We go light on notifications.',
                            value: _notificationsEnabled,
                            onChanged: (val) => setState(() => _notificationsEnabled = val),
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

                          const SizedBox(height: 120.0), // Padding to clear bottom CTA
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom Controls ──────────
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(
                  left: AppSpacing.space24,
                  right: AppSpacing.space24,
                  bottom: AppSpacing.space48,
                ),
                child: Row(
                  children: [
                    // Back button
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.white.withOpacity(0.5),
                          width: 1,
                        ),
                        color: Colors.transparent,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space16),
                    
                    // Continue Button
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoadingScreen()),
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFF66B9A), // pink300 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26), // Pill shape
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: AppTypography.body2.copyWith(
                              color: const Color(0xFF49001E), // pink900 text
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF), // Glass effect
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x26FFFFFF), width: 0.5),
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
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Geist',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFFD4D4D4), // neutral/300
                    fontSize: 14,
                    height: 1.3,
                    fontFamily: 'Geist',
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
              activeColor: Colors.blue[400],
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
