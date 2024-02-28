import 'dart:math';

import 'package:flutter/material.dart';

class BackgroundArcs extends StatelessWidget {
  final Color color;

  BackgroundArcs(this.color);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: BackgroundArcsPainter(color),
      ),
    );
  }
}

class BackgroundArcsPainter extends CustomPainter {
  final Color color;

  BackgroundArcsPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the center of the arcs
    final center = Offset(size.width, size.height * -0.1);

    // Calculate the radius of the arcs
    final radius = min(size.width * 0.8, size.height * 0.95);

    // Draw the first arc
    final arcPaint1 = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi / 2,
      3 * pi / 4,
      false,
      arcPaint1,
    );
    final center2 = Offset(size.width, size.height * -0.1);

    // Calculate the radius of the arcs
    final radius1 = min(size.width, size.height) * 0.4;

    // Draw the second arc
    // final arcPaint2 = Paint()
    //   ..color = Colors.pink.withOpacity(0.3)
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 20;
    //
    canvas.drawArc(
      Rect.fromCircle(center: center2, radius: radius1),
      pi / 2,
      3 * pi / 4,
      true,
      arcPaint1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
