import 'package:flutter/material.dart';

/// A custom PageRouteBuilder that implements a premium fade-through transition
/// as requested in the Premium Kinetic UX standards.
class PremiumPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  PremiumPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // High-end Uber-style kinetic transition
            // Standard cubic bezier for premium feel [0.2, 0, 0, 1]
            const curve = Cubic(0.2, 0.0, 0.0, 1.0);
            
            // 1. Slide from right
            final slideAnimation = Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: curve,
            ));

            // 2. Subtle Scale-in
            final scaleAnimation = Tween<double>(
              begin: 0.92,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: curve,
            ));

            // 3. Parallax effect for the outgoing page (the page being overlapped)
            final parallaxAnimation = Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-0.25, 0.0),
            ).animate(CurvedAnimation(
              parent: secondaryAnimation,
              curve: curve,
            ));

            // 4. Fade transition for smooth entry
            final fadeAnimation = CurvedAnimation(
              parent: animation,
              curve: Interval(0.0, 0.6, curve: curve),
            );

            return SlideTransition(
              position: parallaxAnimation,
              child: FadeTransition(
                opacity: Tween<double>(begin: 1.0, end: 0.8).animate(secondaryAnimation),
                child: SlideTransition(
                  position: slideAnimation,
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: FadeTransition(
                      opacity: fadeAnimation,
                      child: child,
                    ),
                  ),
                ),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 500),
        );
}

/// Helper extension to simplify navigation calls with premium transitions
extension PremiumNavigation on BuildContext {
  Future<T?> pushPremium<T>(Widget page) {
    return Navigator.of(this).push<T>(PremiumPageRoute(page: page));
  }

  Future<T?> pushReplacementPremium<T, TO>(Widget page) {
    return Navigator.of(this).pushReplacement<T, TO>(PremiumPageRoute(page: page));
  }
}
