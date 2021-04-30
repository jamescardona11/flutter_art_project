import 'dart:math';

import 'package:flutter/material.dart';

import 'my_painter.dart';
import 'particle.dart';

class ParticleView extends StatefulWidget {
  ParticleView({Key? key}) : super(key: key);

  @override
  ParticleViewState createState() => ParticleViewState();
}

class ParticleViewState extends State<ParticleView> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late Random rgn;

  List<Particle> particles = [];
  int total = 100;
  double maxRadius = 6;
  double maxSpeed = 0.5;
  double maxTetha = 2 * pi;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
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

    rgn = Random(DateTime.now().millisecondsSinceEpoch);
    initParticles();
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

  Color getRandomColor(Random rng) {
    final a = rng.nextInt(255);
    final r = rng.nextInt(255);
    final g = rng.nextInt(255);
    final b = rng.nextInt(255);

    return Color.fromARGB(a, r, g, b);
  }

  void initParticles() {
    particles = List.generate(
      total,
      (index) => Particle(
        color: getRandomColor(rgn),
        speed: rgn.nextDouble() * maxSpeed,
        theta: rgn.nextDouble() * maxTetha,
        radius: rgn.nextDouble() * maxRadius,
      ),
    );
  }
}
