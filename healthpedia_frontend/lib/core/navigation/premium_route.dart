import 'package:flutter/material.dart';

/// A custom PageRouteBuilder that implements a premium fade-through transition
/// as requested in the Premium Kinetic UX standards.
class PremiumPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  PremiumPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curve = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );
            
            return FadeTransition(
              opacity: curve,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );
}

/// Helper extension to simplify navigation calls with premium transitions
extension PremiumNavigation on BuildContext {
  Future<T?> pushPremium<T>(Widget page) {
    return Navigator.of(this).push<T>(PremiumPageRoute(page: page));
  }
}
