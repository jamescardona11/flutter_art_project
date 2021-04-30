import 'package:flutter/material.dart';

class Particle {
  final Offset position;
  final Color color;

  final double speed;
  final double theta;

  Particle({
    this.position = const Offset(-1, -1),
    this.color = Colors.deepPurple,
    this.speed = 10,
    required this.theta,
  });
}
