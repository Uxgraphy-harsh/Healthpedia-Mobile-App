import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/features/onboarding/screens/permissions_screen.dart';

/// The Health Trackers onboarding screen.
/// Prompts the user to connect to Google Fit or Apple Health, rendered elegantly 
/// with a frosted glass aesthetic matching the current onboarding context.
class HealthTrackersScreen extends StatefulWidget {
  const HealthTrackersScreen({super.key});

  @override
  State<HealthTrackersScreen> createState() => _HealthTrackersScreenState();
}

class _HealthTrackersScreenState extends State<HealthTrackersScreen> {
  bool _googleFitEnabled = true;
  bool _appleHealthEnabled = false;

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
                        width: 268.5, // 75% width per Figma (268.5 out of 358)
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
                            'Connect\nmultiple\nhealth\ntrackers!',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 56, // Title-3
                              height: 68 / 56, // line-height
                              color: AppColors.rose50,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.space32),

                          // ── Tracker Cards ──────────
                          _buildGoogleFitCard(),
                          const SizedBox(height: 10),
                          _buildAppleHealthCard(),

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
                  
                  // "I'll do it later" Button
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PermissionsScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: AppColors.white.withOpacity(0.5), 
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26), // Pill shape
                          ),
                        ),
                        child: Text(
                          'I\'ll do it later',
                          style: AppTypography.body2.copyWith(
                            color: const Color(0xFFFFC3D7), // pink100
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
        ],
      ),
    );
  }

  Widget _buildGoogleFitCard() {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF), // Glass effect
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x26FFFFFF), width: 0.5),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/image 26.png',
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Google Fit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Geist',
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: const [
                    Text('Connected', style: TextStyle(color: Color(0xFF86efac), fontSize: 13, fontFamily: 'Geist')),
                    SizedBox(width: 4),
                    Text('•', style: TextStyle(color: Color(0xFF86efac), fontSize: 13, fontFamily: 'Geist')),
                    SizedBox(width: 4),
                    Text('Syncing...', style: TextStyle(color: Color(0xFFA3A3A3), fontSize: 13, fontFamily: 'Geist')),
                  ],
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.75, // Scale down to match Figma perfectly
            child: CupertinoSwitch(
              value: _googleFitEnabled,
              activeColor: Colors.blue[400],
              onChanged: (val) => setState(() => _googleFitEnabled = val),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppleHealthCard() {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF), // Glass effect
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x26FFFFFF), width: 0.5),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/image 5.png',
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Apple health',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Geist',
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Not connected', 
                  style: TextStyle(color: Color(0xFFA3A3A3), fontSize: 13, fontFamily: 'Geist'),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.75,
            child: CupertinoSwitch(
              value: _appleHealthEnabled,
              activeColor: Colors.blue[400],
              onChanged: (val) => setState(() => _appleHealthEnabled = val),
            ),
          ),
        ],
      ),
    );
  }
}
