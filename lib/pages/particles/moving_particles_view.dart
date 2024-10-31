import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_art_project/model/particle.dart';
import 'package:flutter_art_project/model/rgn_model.dart';

class MovingParticlesView extends StatefulWidget {
  const MovingParticlesView({
    super.key,
  });

  @override
  _MovingParticlesViewState createState() => _MovingParticlesViewState();
}

class _MovingParticlesViewState extends State<MovingParticlesView> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final RgnModel rgn = RgnModel();

  List<Particle> particles = [];
  int total = 100;
  double maxRadius = 6;
  double maxSpeed = 0.5;
  double maxTetha = 2 * pi;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();

    initParticles();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MovingPainter(particles, animation.value, rgn),
      child: Container(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initParticles() {
    particles = List.generate(
      total,
      (index) => Particle(
        color: rgn.getRandomColor(),
        speed: rgn.getDouble(maxSpeed),
        theta: rgn.getDouble(maxTetha),
        radius: rgn.getDouble(maxRadius),
      ),
    );
  }
}

class _MovingPainter extends CustomPainter {
  _MovingPainter(this.particles, this.animValue, this.rgn);

  final List<Particle> particles;
  final RgnModel rgn;
  final double animValue;

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      p.validateAndUpdate(rgn, size);
    }

    for (var p in particles) {
      final paint = Paint()..color = p.color;
      canvas.drawCircle(p.position, p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
