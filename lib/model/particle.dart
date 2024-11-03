import 'package:flutter/material.dart';
import 'package:flutter_art_project/model/rgn_model.dart';
import 'package:flutter_art_project/utils/utils.dart';

class Particle {
  Offset position;
  Offset origin;
  final Color color;

  final double speed;
  final double theta;
  double alpha;
  double radius;

  Particle({
    this.position = const Offset(-1, -1),
    this.color = Colors.deepPurple,
    this.radius = 0,
    this.speed = 0,
    this.theta = 0,
    this.alpha = 0,
  }) : origin = position;

  void validateAndUpdate(RgnModel rgn, Size size, double value) {
    final velocity = polarToCartesian(speed, theta);
    double dx = position.dx + velocity.dx;
    double dy = position.dy + velocity.dy;

    if (position.dx < 0 || position.dx > size.width) {
      dx = rgn.getDouble(size.width * value);
    }

    if (position.dy < 0 || position.dy > size.height) {
      dy = rgn.getDouble(size.height * value);
    }

    position = Offset(dx, dy);
  }

  @override
  String toString() {
    return 'Position ${position.toString()}';
  }
}
