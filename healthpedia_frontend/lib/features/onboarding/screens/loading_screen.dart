import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'package:healthpedia_frontend/features/main/screens/main_scaffold.dart';

/// The final Loading Screen sequence finalizing onboarding setup and preparing to enter the main app.
/// Features a custom pink background, rotating flower graphic, and a beautifully calculated physics petal drop loop animation.
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _fallController;

  @override
  void initState() {
    super.initState();
    // Continuous rotation for the central 3D flower asset
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    // Continuous falling sequence simulating drifting petal aerodynamics over exactly 4 seconds
    _fallController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Advance automatically into the Main Home App Scaffold after exactly 3 seconds 
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScaffold()),
        );
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _fallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFB3661), // High contrast coral-pink mapped from Figma metadata
      body: Stack(
        children: [
          // ── Simulated Drifting Petals ──────────
          // The petals are synthetically generated utilizing the squashed, tinted flower asset 
          // layered with backdrop flutter blur to simulate the soft lens effect.
          ..._buildPetals(context),
          
          // ── Central Composition ──────────
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _rotationController,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _rotationController.value * 2 * math.pi,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/Flower.png',
                    width: 140, // Scaled slightly to fit well
                    height: 140,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Charging up your\nAi Powered Health Assistant...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20, // H6 Equivalent
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Geist',
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Calculates individual falling petals utilizing a sine wave offset for aerodynamic drifting effect
  List<Widget> _buildPetals(BuildContext context) {
    // 8 Independent petals generated with deterministic random sweeps to match the snapshot composition exactly
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return List.generate(8, (index) {
      final double distributionStart = ((index + 1) * (screenWidth / 8) + (index * 23)) % screenWidth; 
      final double delayOffset = (index * 0.175) % 1.0; 
      
      return AnimatedBuilder(
        animation: _fallController,
        builder: (context, child) {
          double progress = (_fallController.value + delayOffset) % 1.0;
          double yPos = -100 + (screenHeight + 200) * progress; // Dropping mathematically from out of frame
          double xWobble = math.sin((progress * math.pi * 3) + index) * 45; // Wafting left to right during drop
          
          return Positioned(
            left: distributionStart + xWobble,
            top: yPos,
            child: Opacity(
              opacity: (1.0 - (progress * 0.5)).clamp(0.0, 1.0), // Fading alpha seamlessly into the canvas
              child: Transform.rotate(
                angle: progress * math.pi * 6 + index, // Multi-axis tumble
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0), // Adds standard graphical depth focus
                  child: SizedBox(
                    width: 45,
                    height: 25, // Squashed to mimic dropping isolated petals organically 
                    child: Image.asset(
                      'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Icons/Flower.png',
                      color: Colors.white.withOpacity(0.4),
                      colorBlendMode: BlendMode.srcIn, // Flattening into purely a pink/white semi transparent vector petal shape
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
