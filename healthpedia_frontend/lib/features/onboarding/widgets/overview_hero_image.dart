import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';

/// Hero image section for Overview 1 (Figma node 59:470).
/// Shows the main yoga photo in a rounded container with three floating
/// pill badges ("Reminders", "Reports", "AI Assistance") and a bottom
/// card with small family photos + "Take Care of your Family's Health".
class OverviewHeroImage extends StatelessWidget {
  const OverviewHeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Centered image container ──────────
          Positioned.fill(
            left: 36,
            right: 36,
            child: _HeroImageContainer(),
          ),

          // ── Floating pill: Reminders (top-right) ──
          Positioned(
            top: -8, // Matches Figma y="-8"
            right: 16,
            child: const _FloatingPill(
              iconPath: 'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/calendar_month.svg',
              label: 'Reminders',
            ),
          ),

          // ── Floating pill: Reports (mid-left) ──
          Positioned(
            top: 68, // Matches Figma y="68"
            left: -10,
            child: const _FloatingPill(
              iconPath: 'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/diagnosis.svg',
              label: 'Reports',
            ),
          ),

          // ── Floating pill: AI Assistance (mid-right) ──
          Positioned(
            top: 108, // Matches Figma y="108"
            right: 0,
            child: const _FloatingPill(
              iconPath: 'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/neurology.svg',
              label: 'AI Assisstance',
            ),
          ),

          // ── Family Health Card (bottom center) ────
          const Positioned(
            bottom: 30,
            left: 60,
            right: 60,
            child: _FamilyHealthCard(),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Hero image container with rounded corners + family card
// ═══════════════════════════════════════════════════════════

/// The large rounded photo container with the yoga image and the
/// overlapping "Family's Health" card at the bottom.
class _HeroImageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Image.asset(
        'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/Overview 1 Image.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// "Family's Health" card at the bottom of the hero image
// ═══════════════════════════════════════════════════════════

/// Card with two small overlapping family photos and text
/// "Take Care of your / Family's Health" (Figma node 60:523).
class _FamilyHealthCard extends StatelessWidget {
  const _FamilyHealthCard();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // The main card container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: AppSpacing.space32, // Space for the stacked avatars
            bottom: AppSpacing.space16,
            left: AppSpacing.space12,
            right: AppSpacing.space12,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6678).withOpacity(0.1),
                offset: const Offset(0, 3),
                blurRadius: 7,
              ),
              BoxShadow(
                color: const Color(0xFFFF6678).withOpacity(0.09),
                offset: const Offset(0, 12),
                blurRadius: 12,
              ),
              BoxShadow(
                color: const Color(0xFFFF6678).withOpacity(0.05),
                offset: const Offset(0, 27),
                blurRadius: 16,
              ),
              BoxShadow(
                color: const Color(0xFFFF6678).withOpacity(0.01),
                offset: const Offset(0, 48),
                blurRadius: 19,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Take Care of your',
                style: AppTypography.body3.copyWith(
                  color: AppColors.neutral400,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Family\u2019s Health',
                style: AppTypography.body3.copyWith(
                  color: AppColors.pink950,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // Stacked avatars positioned on top of the card
        Positioned(
          top: -30,
          child: _OverlappingPhotos(),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Overlapping family photo thumbnails
// ═══════════════════════════════════════════════════════════

/// Two small overlapping tilted photos above the "Family's Health" text.
class _OverlappingPhotos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 80,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Photo 1 — tilted left
          Positioned(
            left: 0,
            child: Transform.rotate(
              angle: -0.173, // -9.95 degrees
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/Overview 1 small image 1.png',
                    width: 36,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Photo 2 — tilted right, overlapping
          Positioned(
            right: 0,
            child: Transform.rotate(
              angle: 0.174, // 10 degrees
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/Overview 1 small image 2.png',
                    width: 36,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Floating pill badge widget
// ═══════════════════════════════════════════════════════════

/// A floating pill-shaped badge with an SVG icon + label text.
/// Used for "Reminders", "Reports", "AI Assistance" (Figma nodes 59:501, 61:541, 61:552).
/// Has a subtle drop shadow matching the Onboarding Pill Drop Shadow style.
class _FloatingPill extends StatelessWidget {
  final String iconPath;
  final String label;

  const _FloatingPill({
    required this.iconPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space12),
      decoration: BoxDecoration(
        color: AppColors.amber25,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(color: AppColors.white, width: 1),
        boxShadow: [
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
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              AppColors.pink400,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: AppSpacing.space8),
          Text(
            label,
            style: AppTypography.label3.copyWith(
              color: AppColors.pink950,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
