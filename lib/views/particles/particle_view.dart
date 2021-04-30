import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'my_painter.dart';
import 'particle.dart';

class ParticleView extends StatefulWidget {
  ParticleView({Key? key}) : super(key: key);

  @override
  ParticleViewState createState() => ParticleViewState();
}

class ParticleViewState extends State<ParticleView> {
  List<Particle> particles = [];
  int total = 10;

  @override
  void initState() {
    super.initState();
    final rng = math.Random(DateTime.now().millisecondsSinceEpoch);

    particles = List.generate(
      total,
      (index) => Particle(
        color: getRandomColor(rng),
        speed: rng.nextDouble() * 0.2,
        theta: rng.nextDouble() * 2 * math.pi,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainterClass(),
      child: Container(
        color: Colors.white38,
      ),
    );
  }

  Color getRandomColor(math.Random rng) {
    final a = rng.nextInt(255);
    final r = rng.nextInt(255);
    final g = rng.nextInt(255);
    final b = rng.nextInt(255);

    return Color.fromARGB(a, r, g, b);
  }
}
