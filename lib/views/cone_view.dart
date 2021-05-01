import 'dart:math';

import 'package:art_project/utils.dart';
import 'package:art_project/views/painter/cone_painter.dart';
import 'package:art_project/views/painter/moving_painter.dart';
import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';

import 'painter/my_painter.dart';
import '../model/particle.dart';

class ConeParticleView extends StatefulWidget {
  ConeParticleView({Key? key}) : super(key: key);

  @override
  ConeParticleViewState createState() => ConeParticleViewState();
}

class ConeParticleViewState extends State<ConeParticleView>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late Random rgn;

  List<Particle> particles = [];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        if (particles.length == 0) {
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

    rgn = Random(DateTime.now().millisecondsSinceEpoch);
    // initParticles();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConePainter(particles, animation.value, rgn, MediaQuery.of(context).size),
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
  double step = 10;
  void blobField() {
    for (var y = 0; y < w / step; y++) {
      final x = 0.0;
      final p = Particle(
        position: Offset(x, y.toDouble()),
        radius: 5.0,
        color: Colors.grey,
      );

      particles.add(p);
    }
  }

  double t = 0;
  void updateBlobField() {
    particles.forEach((p) {
      setParticle(p);
    });

    t += 0.01;
  }

  var perlinNoise = PerlinNoise();

  void setParticle(Particle p) {
    final x = p.origin.dx;
    final y = p.origin.dy * step;

    final xx = x * 0.2;
    final yy = y * 0.01;
    final zz = t * 0.5;
    final perlin = perlinNoise.singlePerlin3(1942, xx, yy, zz);
    final dx = mapRange(perlin, 0, 1, -step.toDouble(), step.toDouble());
    final px = x + dx;
    final py = y;

    p.position = Offset(px, py);
  }

  double mapRange(double value, double min1, double max1, double min2, double max2) {
    final range1 = min1 - max1;
    final range2 = min2 - max2;
    return min2 + range2 * value / range1;
  }
}
