import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_art_project/model/particle.dart';
import 'package:flutter_art_project/model/rgn_model.dart';

import 'moving_particles_settings.dart';

class MovingParticlesPage extends StatefulWidget {
  const MovingParticlesPage({
    super.key,
  });

  @override
  State<MovingParticlesPage> createState() => _MovingParticlesPageState();
}

class _MovingParticlesPageState extends State<MovingParticlesPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool automatic = true;
  final RgnModel rgn = RgnModel();

  List<Particle> particles = [];
  int total = 100;
  double maxRadius = 6;
  double maxSpeed = 0.5;
  double maxTheta = 2 * pi;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..addStatusListener((status) {
        if (automatic) {
          if (status == AnimationStatus.completed) {
            controller.repeat();
          } else if (status == AnimationStatus.dismissed) {
            controller.forward();
          }
        }
      });

    controller.forward();

    initParticles();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) => CustomPaint(
              painter: _MovingPainter(particles, rgn, controller.value),
              child: Container(),
            ),
          ),
        ),
        MovingParticlesSettings(controller: controller, automatic: automatic, setAutomatic: setAutomatic),
      ],
    );
  }

  void setAutomatic(bool value) {
    automatic = value;
    if (automatic) {
      controller.forward();
    } else {
      controller.stop();
    }

    setState(() {});
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
        theta: rgn.getDouble(maxTheta),
        radius: rgn.getDouble(maxRadius),
      ),
    );
  }
}

class _MovingPainter extends CustomPainter {
  _MovingPainter(this.particles, this.rgn, this.value);

  final List<Particle> particles;
  final RgnModel rgn;
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      p.validateAndUpdate(rgn, size, value);
    }

    for (var p in particles) {
      final paint = Paint()..color = p.color;
      canvas.drawCircle(p.position, p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
