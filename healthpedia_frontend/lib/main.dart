// App entry point

import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/theme/app_theme.dart';
import 'package:healthpedia_frontend/features/onboarding/screens/overview_screen.dart';

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
      // TODO: Replace with go_router once navigation is set up
      home: const OverviewScreen(),
    );
  }
}
