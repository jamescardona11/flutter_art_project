import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_art_project/art_provider.dart';
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

typedef MovingParticlesState = (int, double, double);

class _MovingParticlesPageState extends State<MovingParticlesPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final RgnModel rgn = RgnModel();

  // (total, maxRadius, maxSpeed)
  MovingParticlesState painterState = (100, 6, 0.5);
  List<Particle> particles = [];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    controller.repeat();

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
              painter: _MovingPainter(particles, rgn),
              child: Container(),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: ArtProvider(),
          builder: (context, child) {
            final item = ArtProvider().getItem();
            final showSettings = ArtProvider().showControllerSettings;

            if (item.hasSettingsView && showSettings) {
              return MovingParticlesSettings(
                controller: controller,
                painterState: painterState,
                setPainterState: setPainterState,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  void setPainterState((int, double, double) value) {
    painterState = value;
    initParticles();

    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initParticles() {
    particles = List.generate(
      painterState.$1,
      (index) => Particle(
        color: rgn.getRandomColor(),
        theta: rgn.getDouble(2 * pi),
        radius: rgn.getDouble(painterState.$2),
        speed: rgn.getDouble(painterState.$3),
      ),
    );
  }
}

class _MovingPainter extends CustomPainter {
  _MovingPainter(this.particles, this.rgn);

  final List<Particle> particles;
  final RgnModel rgn;

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
