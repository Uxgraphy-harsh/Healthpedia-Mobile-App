import 'dart:math';
import 'package:flutter/material.dart';
import '../screens/main_scaffold.dart'; // To access ReminderStatus

class ReminderCheckbox extends StatelessWidget {
  final ReminderStatus status;
  final VoidCallback? onTap;

  const ReminderCheckbox({
    super.key,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 24,
        height: 24,
        child: _buildCheckbox(),
      ),
    );
  }

  Widget _buildCheckbox() {
    switch (status) {
      case ReminderStatus.pending:
        return CustomPaint(
          painter: DashedCirclePainter(color: const Color(0xFFF97316)),
        );
      case ReminderStatus.completed:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF3B82F6).withOpacity(0.1),
            border: Border.all(color: const Color(0xFF3B82F6), width: 1.5),
          ),
          child: const Center(
            child: Icon(
              Icons.check_rounded,
              size: 16,
              color: Color(0xFF3B82F6),
            ),
          ),
        );
      case ReminderStatus.missed:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFC2410C).withOpacity(0.1),
            border: Border.all(color: const Color(0xFFC2410C), width: 1.5),
          ),
          child: const Center(
            child: Icon(
              Icons.priority_high_rounded,
              size: 16,
              color: Color(0xFFC2410C),
            ),
          ),
        );
    }
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;

  DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2 - 0.75; // Subtract half stroke width
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 2.5;
    const double dashSpace = 3.5;
    final double circumference = 2 * pi * radius;
    final int dashCount = (circumference / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = (i * (dashWidth + dashSpace)) / radius;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        dashWidth / radius,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
