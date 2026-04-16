import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';

/// Hero widget for Overview 3 — "Timely reminders" screen.
/// Features a large iPhone frame with a stacked notification popup and a bottom gradient fade.
class Overview3Hero extends StatelessWidget {
  const Overview3Hero({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Height matching the scaled composition
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // ── iPhone Frame (Scaled & Half-Cut) ────────
          Positioned(
            top: 27,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.82, // Hard-cut the bottom portion
                child: Image.asset(
                  'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/Overview 3 image - full.png',
                  width: 284,
                  height: 486,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),

          // ── Bottom Gradient Fade (Spill-off effect) ──
          Positioned(
            bottom: -20, // Offset to spill outside the hero area slightly
            left: 0,
            right: 0,
            height: 120,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.background.withOpacity(0.0),
                      AppColors.background.withOpacity(0.8),
                      AppColors.background,
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // ── Stacked Notification Card ────────────
          const Positioned(
            top: 177,
            child: _NotificationStack(),
          ),
        ],
      ),
    );
  }
}

class _NotificationStack extends StatelessWidget {
  const _NotificationStack();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      height: 90, // Container for overlapping cards
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          // ── Back Card (Ghost Notification) ───────
          Positioned(
            top: 16, // Shifted down
            child: Container(
              width: 304,
              height: 54,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFF9E9E9).withOpacity(0.5),
                    const Color(0xFFF7E9E0).withOpacity(0.5),
                  ],
                ),
                borderRadius: BorderRadius.circular(11),
                boxShadow: _getNotificationShadows(),
              ),
            ),
          ),

          // ── Front Card (Active Notification) ──────
          Positioned(
            top: 0,
            child: Container(
              width: 328,
              height: 62,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                boxShadow: _getNotificationShadows(),
              ),
              child: Row(
                children: [
                  // Floral Icon
                  Container(
                    width: 36,
                    height: 36,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE0E9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/Repeat group 4.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space12),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Time for your medication 💊',
                              style: AppTypography.body3SemiBold.copyWith(
                                color: AppColors.pink950,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              '7:45 PM',
                              style: AppTypography.body4.copyWith(
                                color: AppColors.neutral400,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 1),
                        Text(
                          'Just a gentle reminder to take your evening Vitamin D3.',
                          style: AppTypography.body3.copyWith(
                            color: AppColors.pink950,
                            fontSize: 10.5,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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

  List<BoxShadow> _getNotificationShadows() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.10),
        offset: const Offset(0, 1),
        blurRadius: 2,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.09),
        offset: const Offset(0, 5),
        blurRadius: 5,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0, 10),
        blurRadius: 6,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.02),
        offset: const Offset(0, 18),
        blurRadius: 7,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        offset: const Offset(0, -1),
        blurRadius: 2,
      ),
    ];
  }
}
