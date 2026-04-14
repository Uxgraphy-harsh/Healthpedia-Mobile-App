// App entry point

import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/features/splash/screens/splash_screen.dart';

void main() {
  runApp(const HealthpediaApp());
}

class HealthpediaApp extends StatelessWidget {
  const HealthpediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthpedia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      // Setting the initial route directly to the Splash Screen for prototyping
      home: const SplashScreen(),
    );
  }
}
