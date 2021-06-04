import 'dart:math';

import 'package:flutter_art_project/model/particle.dart';
import 'package:flutter/material.dart';

class MyPainterClass extends CustomPainter {
  MyPainterClass(this.particles, this.animValue, this.rgn);

  final List<Particle> particles;
  final Random rgn;
  final double animValue;

  @override
  void paint(Canvas canvas, Size size) {
    // particles.forEach((p) {
    //   p.validateAndUpdate(rgn, size);
    // });

    particles.forEach((p) {
      final paint = Paint()..color = p.color;
      canvas.drawCircle(p.position, p.radius, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
