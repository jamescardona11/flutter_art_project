import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_art_project/model/particle.dart';
import 'package:flutter_art_project/model/rgn_model.dart';
import 'package:flutter_art_project/utils.dart';

class SphereParticlesView extends StatefulWidget {
  const SphereParticlesView({
    Key? key,
  }) : super(key: key);

  @override
  _SphereParticlesViewState createState() => _SphereParticlesViewState();
}

class _SphereParticlesViewState extends State<SphereParticlesView>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final RgnModel rgn = RgnModel();

  List<Particle> particles = [];

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
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
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SpherePainter(particles),
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
    while (particles.length > particlesCount * 2) {
      particles.removeAt(0);
    }
  }

  Particle newParticle(Offset origin) => Particle(
        color: Colors.grey,
        radius: 100,
        position: origin + getRandomPosition(100),
        theta: rgn.getDouble(2 * pi),
        speed: 1,
      );

  Offset getRandomPosition(double radius) {
    final t = rgn.getDouble(2 * pi);
    return polarToCartesian(radius, t);
  }
}

class _SpherePainter extends CustomPainter {
  _SpherePainter(this.particles);

  final List<Particle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..blendMode = BlendMode.colorBurn;
    // ..blendMode = BlendMode.xor

    particles.forEach((p) {
      paint..color = p.color;
      canvas.drawCircle(p.position, p.radius, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
