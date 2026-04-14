// App entry point

import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/theme/app_theme.dart';
import 'package:healthpedia_frontend/features/splash/screens/splash_screen.dart';

void main() {
  runApp(const HealthpediaApp());
}

/// Root widget — applies our token-driven theme to the entire app.
class HealthpediaApp extends StatelessWidget {
  const HealthpediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthpedia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // Setting the initial route directly to the Splash Screen for prototyping
      home: const SplashScreen(),
    );
  }
}
