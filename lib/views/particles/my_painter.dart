import 'package:flutter/material.dart';

class MyPainterClass extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dx = size.width / 2;
    final dy = size.height / 2;
    final c = Offset(dx, dy);

    final radius = 100.0;
    final paint = Paint()..color = Colors.deepPurple;

    canvas.drawCircle(c, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
