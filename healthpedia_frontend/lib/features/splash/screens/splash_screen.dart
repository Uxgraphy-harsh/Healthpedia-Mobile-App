import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';

// Splash Screen
// Displays the Healthpedia branding logo over a dynamic background
// Translates Figma design 59:250
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
            
            // Layer 2: Center Lotus Logo
            // User specifically requested the PNG replacement
            Image.asset(
              'assets/Figma MCP Assets/Onboarding Screens/Repeat group 1_inner.png',
              width: 150, 
              height: 150,
              semanticLabel: 'Healthpedia Logo',
            ),
          ],
        ),
      ),
    );
  }
}
