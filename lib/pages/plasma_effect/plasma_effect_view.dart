import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_art_project/model/particle.dart';

class PlasmaEffectView extends StatefulWidget {
  const PlasmaEffectView({super.key});

  @override
  PlasmaEffectViewState createState() => PlasmaEffectViewState();
}

class PlasmaEffectViewState extends State<PlasmaEffectView> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  List<Particle> particles = [];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        if (particles.isEmpty) {
          createBlobField();
        } else {
          setState(() {
            updateBlobField();
          });
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PlasmaPainter(particles, animation.value, MediaQuery.of(context).size),
      child: Container(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void createBlobField() {
    blobField();
  }

  final w = 600;
  final step = 20;

  void blobField() {
    for (var y = step; y < w; y += step) {
      for (var x = step; x < w; x += step) {
        final r = sqrt(x * x + y * y); // xxx + yyy

        final f = r / w; // varies from 0 to 1
        final angle = f * 2 * pi; // varies from 0 to 360 deg or 2pi radians
        final g = sin(angle); //varies from -1 to 1

        final p = Particle(
          position: Offset(x.toDouble(), y.toDouble()),
          radius: (g + 1) * 5,
          alpha: angle,
          color: Colors.black,
        );

        particles.add(p);
      }
    }
  }

  double t = 0;
  void updateBlobField() {
    for (var p in particles) {
      setParticle(p);
    }
  }

  final da = 0.01;
  void setParticle(Particle p) {
    p.alpha += da;
    p.radius = (sin(p.alpha) + 1.0) * 5;
  }
}

class _PlasmaPainter extends CustomPainter {
  _PlasmaPainter(this.particles, this.animValue, this.canvasSize);

  final List<Particle> particles;

  final double animValue;
  final Size canvasSize;

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 5
        ..color = p.color;

      canvas.drawCircle(p.position, p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
