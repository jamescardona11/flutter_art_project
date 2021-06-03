import 'dart:math';

import 'package:flutter_art_project/utils.dart';
import 'package:flutter/material.dart';

import 'painter/my_painter.dart';
import '../model/particle.dart';

class FloatingParticlePage extends StatefulWidget {
  FloatingParticlePage({Key? key}) : super(key: key);

  @override
  FloatingParticlePageState createState() => FloatingParticlePageState();
}

class FloatingParticlePageState extends State<FloatingParticlePage>
    with SingleTickerProviderStateMixin {
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
