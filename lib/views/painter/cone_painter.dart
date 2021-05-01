import 'dart:math';

import 'package:art_project/model/particle.dart';
import 'package:flutter/material.dart';

class ConePainter extends CustomPainter {
  ConePainter(this.particles, this.animValue, this.rgn, this.canvasSize) {
    offset = Offset(canvasSize.width / 2, canvasSize.height / 2 - w / 2);
  }

  final List<Particle> particles;
  final Random rgn;
  final double animValue;
  final Size canvasSize;
  late Offset offset;

  final w = 600;

  @override
  void paint(Canvas canvas, Size size) {
    // particles.forEach((p) {
    //   p.validateAndUpdate(rgn, size);
    // });

    particles.forEach((p) {
      final paint = Paint()
        // ..style = PaintingStyle.stroke //remove thsi for floating example
        ..color = p.color;

      canvas.drawCircle(p.position + offset, p.radius, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
