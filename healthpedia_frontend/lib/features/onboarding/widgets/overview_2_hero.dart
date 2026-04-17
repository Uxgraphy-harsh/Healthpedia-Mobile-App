import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';

/// Hero widget for Overview 2 — "Record symptoms" screen.
/// Features a flower-themed background photo with floating "Symptoms Log" and "Doctor" cards.
class Overview2Hero extends StatelessWidget {
  const Overview2Hero({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final heroHeight = screenHeight * 0.42;

    return SizedBox(
      height: heroHeight,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // ── Background Image (Flower) ──────────
          Container(
            width: 286,
            height: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/Overview 2 Image.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ── Floating Symptoms Log Card ──────────
          Positioned(
            top: 40,
            left: 5,
            child: const _SymptomsLogCard(),
          ),

          // ── Floating Doctor Card ────────────────
          Positioned(
            bottom: 60,
            right: 5,
            child: const _DoctorCard(),
          ),
        ],
      ),
    );
  }
}

class _SymptomsLogCard extends StatelessWidget {
  const _SymptomsLogCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 194, // Exact Figma width
      height: 129, // Exact Figma height
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: _getOnboardingShadows(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SYMPTOMS LOG',
            style: AppTypography.caption1.copyWith(
              color: AppColors.pink500,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.space12),
          _SymptomItem(
            title: 'Sever Headache',
            subtitle: 'Since 2 weeks • Every night',
          ),
          const SizedBox(height: AppSpacing.space12),
          _SymptomItem(
            title: 'Nausea',
            subtitle: 'Been 1 year • Every morning',
          ),
        ],
      ),
    );
  }
}

class _SymptomItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SymptomItem({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColors.neutral200, width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.label3.copyWith(
              color: AppColors.pink950,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            style: AppTypography.body4.copyWith(
              color: AppColors.neutral400,
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  const _DoctorCard();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main Card
        Container(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _getOnboardingShadows(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 4), // Space for stacked avatar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Dr. Kiran Goswami',
                    style: AppTypography.label3.copyWith(
                      color: AppColors.pink950,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Available',
                    style: AppTypography.caption1.copyWith(
                      color: const Color(0xFF15803D),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              // Video call icon in grey circle
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.neutral200,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/videocam.svg',
                    width: 12,
                    height: 12,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Floating Doctor Avatar
        Positioned(
          top: -18,
          left: 16,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 81.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

List<BoxShadow> _getOnboardingShadows() {
  return [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      offset: const Offset(0, 1),
      blurRadius: 2,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.09),
      offset: const Offset(0, 5),
      blurRadius: 5,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      offset: const Offset(0, 10),
      blurRadius: 6,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.01),
      offset: const Offset(0, 18),
      blurRadius: 7,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      offset: const Offset(0, -1),
      blurRadius: 2,
    ),
  ];
}
