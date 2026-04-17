import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/features/onboarding/widgets/overview_hero_image.dart';
import 'package:healthpedia_frontend/features/onboarding/widgets/overview_2_hero.dart';
import 'package:healthpedia_frontend/features/onboarding/widgets/overview_3_hero.dart';
import 'package:healthpedia_frontend/features/onboarding/widgets/overview_page_indicator.dart';
import 'package:healthpedia_frontend/features/onboarding/screens/basic_details_screen.dart';
import 'package:healthpedia_frontend/core/navigation/premium_route.dart';

/// Overview carousel screen — final production version with floral background and robust CTAs.
class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Background Floral Watermark (Global) ──
          Positioned(
            left: -546,
            top: -942,
            width: 1482,
            height: 1482,
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  'assets/Figma MCP Assets/Onboarding Screens/Flower.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── Carousel area ───────────────────────
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    children: const [
                      _Overview1Page(), // Track health (Yoga)
                      _Overview2Page(), // Record symptoms (Flower Background)
                      _Overview3Page(), // Timely reminders (Phone)
                    ],
                  ),
                ),

                // ── Page indicator dots ─────────────────
                OverviewPageIndicator(
                  currentPage: _currentPage,
                  totalPages: 3,
                ),

                const SizedBox(height: AppSpacing.space32),

                // ── Bottom buttons ──────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space24,
                  ),
                  child: Column(
                    children: [
                      _GoogleSignInButton(
                        onPressed: () {
                          context.pushPremium(const BasicDetailsScreen());
                        },
                      ),
                      const SizedBox(height: AppSpacing.space12),
                      _ExploreAsGuestButton(
                        onPressed: () {
                          context.pushPremium(const BasicDetailsScreen());
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.space16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// UI Components
// ═══════════════════════════════════════════════════════════

class _GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _GoogleSignInButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/Onboarding/Google Icon.png',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: AppSpacing.space12),
            Text(
              'Sign in with Google',
              style: AppTypography.body2.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreAsGuestButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ExploreAsGuestButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: InkWell(
            onTap: onPressed,
            child: Center(
              child: Text(
                'Explore as Guest',
                style: AppTypography.body2.copyWith(
                  color: AppColors.pink950,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Pages
// ═══════════════════════════════════════════════════════════

class _Overview1Page extends StatelessWidget {
  const _Overview1Page();
  @override
  Widget build(BuildContext context) {
    return _BasePage(
      hero: const OverviewHeroImage(),
      title: 'Track and manage\nyour loved one\u2019s\nhealth with AI',
    );
  }
}

class _Overview2Page extends StatelessWidget {
  const _Overview2Page();
  @override
  Widget build(BuildContext context) {
    return _BasePage(
      hero: const Overview2Hero(),
      title: 'Record symptoms\nfor your next\nappointment',
    );
  }
}

class _Overview3Page extends StatelessWidget {
  const _Overview3Page();
  @override
  Widget build(BuildContext context) {
    return _BasePage(
      hero: const Overview3Hero(),
      title: 'Timely reminders\nfor those you love.',
    );
  }
}

class _BasePage extends StatelessWidget {
  final Widget hero;
  final String title;
  const _BasePage({required this.hero, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hero,
              const SizedBox(height: AppSpacing.space24),
              SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTypography.h4.copyWith(
                    color: AppColors.pink950,
                    fontWeight: FontWeight.w400,
                    fontSize: 32, // Slightly smaller to fit mobile screens better
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.space16),
            ],
          ),
        ),
      ),
    );
  }
}
