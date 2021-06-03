import 'dart:math';

import 'package:flutter_art_project/model/particle.dart';
import 'package:flutter/material.dart';

class MovingPainterClass extends CustomPainter {
  MovingPainterClass(this.particles, this.animValue, this.rgn);

  final List<Particle> particles;
  final Random rgn;
  final double animValue;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..blendMode = BlendMode.colorBurn;
    // ..blendMode = BlendMode.xor

    particles.forEach((p) {
      paint..color = p.color;
      canvas.drawCircle(p.position, p.radius, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
