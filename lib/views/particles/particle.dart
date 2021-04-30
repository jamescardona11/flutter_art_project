import 'package:flutter/material.dart';
import 'dart:math';

class Particle {
  Offset position;
  final Color color;

  final double speed;
  final double theta;
  final double radius;

  Particle({
    this.position = const Offset(-1, -1),
    this.color = Colors.deepPurple,
    required this.speed,
    required this.radius,
    required this.theta,
  });

  void validateAndUpdate(Random rgn, Size size) {
    final velocity = polarToCartesian(speed, theta);
    double dx = position.dx + velocity.dx;
    double dy = position.dy + velocity.dy;

    if (position.dx < 0 || position.dx > size.width) {
      dx = rgn.nextDouble() * size.width;
    }

    if (position.dy < 0 || position.dy > size.height) {
      dy = rgn.nextDouble() * size.height;
    }

    position = Offset(dx, dy);
  }

  Offset polarToCartesian(double speed, double theta) =>
      Offset(speed * cos(theta), speed * sin(theta));

  @override
  String toString() {
    return 'Position ${position.toString()}';
  }
}
