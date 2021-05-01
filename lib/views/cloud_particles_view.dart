import 'dart:math';

import 'package:art_project/utils.dart';
import 'package:flutter/material.dart';

import 'painter/my_painter.dart';
import '../model/particle.dart';

class CloudParticlesView extends StatefulWidget {
  CloudParticlesView({Key? key}) : super(key: key);

  @override
  CloudParticlesViewState createState() => CloudParticlesViewState();
}

class CloudParticlesViewState extends State<CloudParticlesView>
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

  void createBlobField() {
    final size = MediaQuery.of(context).size;
    final center = Offset(size.width / 2, size.height / 2);

    //* Number of blobs
    final nb = 5;

    final radius = size.width / nb;
    final alpha = 0.2;

    blobField(radius, nb, alpha, center);
  }

  void blobField(double radius, int nb, double alpha, Offset center) {
    if (radius < 10) return;

    // Angle of arc
    // Angle between child blob
    double theta = 0.0;
    final dTheta = 2 * pi / nb;
    for (int i = 0; i < nb; i++) {
      final pos = polarToCartesian(radius, theta) + center;
      //incrementing the angle
      particles.add(Particle(
        position: pos,
        theta: theta,
        radius: radius / 3,
        color: getColorBlender(rgn, i / nb, alpha),
      ));

      theta += dTheta;
      final f = 0.5;
      blobField(radius * f, nb, alpha * 1.5, pos);
    }
  }

  double t = 0.0;
  final dt = 0.01;
  final radiusFactor = 5;
  void updateBlobField() {
    t += dt;
    particles.forEach((p) {
      p.position = polarToCartesian(p.radius * radiusFactor, p.theta + t) + p.origin;
    });
  }
}
