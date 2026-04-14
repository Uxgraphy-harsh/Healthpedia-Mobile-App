import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';

/// A premium button widget implementing "Apple Glass" (glassmorphism) effects.
/// Uses BackdropFilter for blur and custom gradients for glass reflections.
class GlassButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double blurSigma;
  final Color borderColor;
  final double? width;
  final double height;

  const GlassButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor = Colors.white10,
    this.blurSigma = 15.0,
    this.borderColor = Colors.white24,
    this.width,
    this.height = 52.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              splashColor: Colors.white.withValues(alpha: 0.1),
              highlightColor: Colors.white.withValues(alpha: 0.05),
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  border: Border.all(color: borderColor, width: 0.8),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.15),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.08),
                    ],
                    stops: const [0.0, 0.4, 1.0],
                  ),
                ),
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
