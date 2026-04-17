import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';

class InsuranceTypeVisual {
  const InsuranceTypeVisual({
    required this.backgroundColor,
    required this.glyph,
  });

  final Color backgroundColor;
  final Widget glyph;
}

class InsuranceIconTile extends StatelessWidget {
  const InsuranceIconTile({
    super.key,
    required this.visual,
    this.size = 60,
    this.borderRadius = 15,
  });

  final InsuranceTypeVisual visual;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: visual.backgroundColor),
            Positioned(
              left: -(size * 0.0333),
              top: size * 0.3125,
              child: _InsuranceDecorCircle(
                size: size * 1.6875,
                color: visual.backgroundColor,
              ),
            ),
            Positioned(
              left: -(size * 0.0333),
              top: size * 0.625,
              child: _InsuranceDecorCircle(
                size: size * 1.6875,
                color: visual.backgroundColor,
              ),
            ),
            Center(
              child: SizedBox(
                width: size * 0.75,
                height: size * 0.75,
                child: visual.glyph,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InsuranceDecorCircle extends StatelessWidget {
  const _InsuranceDecorCircle({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.9),
        shape: BoxShape.circle,
      ),
    );
  }
}

class InsuranceTypeVisuals {
  static InsuranceTypeVisual byLabel(String label) {
    switch (label) {
      case 'Health':
      case 'Health Insurance':
        return const InsuranceTypeVisual(
          backgroundColor: Color(0xFFD1FAE5),
          glyph: Icon(
            Icons.favorite_rounded,
            size: 36,
            color: Color(0xFF10B981),
          ),
        );
      case 'Life':
      case 'Life Insurance':
        return InsuranceTypeVisual(
          backgroundColor: const Color(0xFFFEE2E2),
          glyph: SvgPicture.asset(
            'assets/Figma MCP Assets/CommonAssets/Icons/ecg_heart.svg',
            width: 36,
            height: 36,
            colorFilter: const ColorFilter.mode(
              Color(0xFFEF4444),
              BlendMode.srcIn,
            ),
          ),
        );
      case 'Term':
      case 'Term Insurance':
        return const InsuranceTypeVisual(
          backgroundColor: Color(0xFFF3E8FF),
          glyph: Icon(
            Icons.verified_user_rounded,
            size: 36,
            color: Color(0xFFA855F7),
          ),
        );
      case 'Vehicle':
      case 'Vehicle Insurance':
        return const InsuranceTypeVisual(
          backgroundColor: Color(0xFFFFFBEB),
          glyph: Icon(
            Icons.no_crash_rounded,
            size: 36,
            color: Color(0xFFF59E0B),
          ),
        );
      case 'Travel':
        return const InsuranceTypeVisual(
          backgroundColor: Color(0xFFE0F2FE),
          glyph: Icon(
            Icons.flight_takeoff_rounded,
            size: 36,
            color: Color(0xFF0284C7),
          ),
        );
      default:
        return const InsuranceTypeVisual(
          backgroundColor: AppColors.neutral100,
          glyph: Icon(
            Icons.shield_outlined,
            size: 36,
            color: AppColors.neutral500,
          ),
        );
    }
  }
}

class InsuranceIconAssetTile extends StatelessWidget {
  const InsuranceIconAssetTile({
    super.key,
    required this.assetPath,
    this.size = 32,
    this.borderRadius = 8,
  });

  final String assetPath;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: SvgPicture.asset(
          assetPath,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class InsuranceTypeAssets {
  static String byLabel(String label) {
    switch (label) {
      case 'Health':
      case 'Health Insurance':
        return 'assets/Figma MCP Assets/CommonAssets/Icons/Insurance/Health Insurance Icon.svg';
      case 'Life':
      case 'Life Insurance':
        return 'assets/Figma MCP Assets/CommonAssets/Icons/Insurance/Life Insurance Icon.svg';
      case 'Term':
      case 'Term Insurance':
        return 'assets/Figma MCP Assets/CommonAssets/Icons/Insurance/Term Insurance Icon.svg';
      case 'Vehicle':
      case 'Vehicle Insurance':
        return 'assets/Figma MCP Assets/CommonAssets/Icons/Insurance/Vehicle Insurance Icon.svg';
      case 'Travel':
      case 'Travel Insurance':
        return 'assets/Figma MCP Assets/CommonAssets/Icons/Insurance/Travel Insurance Icon.svg';
      default:
        return 'assets/Figma MCP Assets/CommonAssets/Icons/Insurance/Other Insurance Icon.svg';
    }
  }
}
