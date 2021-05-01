import 'dart:math';

import 'package:art_project/utils.dart';
import 'package:flutter/material.dart';

import 'painter/my_painter.dart';
import '../model/particle.dart';

class MovingParticleView extends StatefulWidget {
  MovingParticleView({Key? key}) : super(key: key);

  @override
  MovingParticleViewState createState() => MovingParticleViewState();
}

class MovingParticleViewState extends State<MovingParticleView>
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
      painter: MyPainterClass(particles, animation.value, rgn),
      child: Container(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int particlesCount = 50;
  late Size size;
  late Offset origin;
  late double radius;

  void createBlobField() {
    size = MediaQuery.of(context).size;
    origin = Offset(size.width / 2, size.height / 2);

    //* Number of blobs
    final nb = 4;
    radius = size.width / nb;

    blobField(origin, radius);
  }

  void blobField(Offset origin, double radius) {
    while (particles.length < particlesCount) {
      particles.add(newParticle(origin));
    }
  }

  double dy = 1;
  final dr = 0.1;

  void updateBlobField() {
    particles.forEach((p) {
      p.position += polarToCartesian(p.speed, p.theta);
    });

    particles.add(newParticle(origin));
    while (particles.length < particlesCount * 2) {
      particles.remove(0);
    }
  }

  double mapRange(double value, double min1, double max1, double min2, double max2) {
    final range1 = min1 - max1;
    final range2 = min2 - max2;
    return min2 + range2 * value / range1;
  }

  Particle newParticle(Offset origin) => Particle(
        color: Colors.grey,
        radius: 100,
        position: origin + getRandomPosition(100),
        theta: rgn.nextDouble() * 2 * pi,
        speed: 1,
      );

  Offset getRandomPosition(double radius) {
    final t = rgn.nextDouble() * 2 * pi;
    return polarToCartesian(radius, t);
  }
}
