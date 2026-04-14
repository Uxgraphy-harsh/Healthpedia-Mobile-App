import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/features/onboarding/screens/overview_screen.dart';
import 'dart:math' as math;

// Splash Screen
// Displays the Healthpedia branding logo over a dynamic background
// Translates Figma design 59:250
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    // Start continuous rotation
    _rotationController = AnimationController(
       vsync: this,
       duration: const Duration(seconds: 4),
    )..repeat();

    // Auto-advance to the Overview Screen mapping proper UX transition paths 
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OverviewScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.amber25,
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Layer 1: Background Watermark Pattern (Flower.png)
            // Centered and scaled with Transform to artificially force the pattern 
            // to bleed aggressively off the edges of the screen, mimicking the Figma reference.
            Transform.scale(
              scale: 1.8,
              child: Image.asset(
                'assets/Figma MCP Assets/Onboarding Screens/Flower.png',
                fit: BoxFit.cover,
                excludeFromSemantics: true,
              ),
            ),
            
            // Layer 2: Center Lotus Logo with Animation
            // User specifically requested the PNG replacement animating 
            AnimatedBuilder(
              animation: _rotationController,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _rotationController.value * 2 * math.pi,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/Figma MCP Assets/Onboarding Screens/Repeat group 1_inner.png',
                width: 150, 
                height: 150,
                semanticLabel: 'Healthpedia Logo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
