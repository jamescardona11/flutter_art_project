import 'dart:math';

import 'package:flutter_art_project/model/particle.dart';
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
    final dx1 = canvasSize.width / 2 - w / 2;
    final dy1 = canvasSize.height / 2 - w / 2;

    final dx2 = canvasSize.width / 2 + w / 2;
    final dy2 = canvasSize.height / 2 - w / 2;

    particles.forEach((p) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5 //remove thsi for floating example
        ..blendMode = BlendMode.xor
        ..color = p.color;

      canvas.drawCircle(p.position + offset, p.radius, paint);

      final p1 = p.origin + Offset(dx1, dy1);
      final p2 = p.origin + Offset(dx2, dy2);
      canvas.drawLine(p1, p.position + offset, paint);
      canvas.drawLine(p2, p.position + offset, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
