import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_art_project/model/particle.dart';
import 'package:flutter_art_project/model/rgn_model.dart';

class ConeEffectView extends StatefulWidget {
  const ConeEffectView({super.key});

  @override
  State<ConeEffectView> createState() => ConeEffectViewState();
}

class ConeEffectViewState extends State<ConeEffectView> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final rgn = RgnModel();

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

    // initParticles();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConePainter(
        particles,
        animation.value,
        MediaQuery.of(context).size,
      ),
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
  double step = 5;
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
    for (var p in particles) {
      setParticle(p);
    }

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
    final dy = mapRange(perlin, 0, 1, -step.toDouble(), step.toDouble());
    final px = x + dx;
    final py = y + dy;

    p.position = Offset(px, py);
  }

  double mapRange(double value, double min1, double max1, double min2, double max2) {
    final range1 = min1 - max1;
    final range2 = min2 - max2;
    return min2 + range2 * value / range1;
  }
}

class ConePainter extends CustomPainter {
  ConePainter(this.particles, this.animValue, this.canvasSize) {
    offset = Offset(canvasSize.width / 2, canvasSize.height / 2 - w / 2);
  }

  final List<Particle> particles;

  final double animValue;
  final Size canvasSize;
  late Offset offset;

  final w = 600;

  @override
  void paint(Canvas canvas, Size size) {
    final dx1 = canvasSize.width / 2 - w / 2;
    final dy1 = canvasSize.height / 2 - w / 2;

    final dx2 = canvasSize.width / 2 + w / 2;
    final dy2 = canvasSize.height / 2 - w / 2;

    for (var p in particles) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5 //remove thsi for floating example
        ..blendMode = BlendMode.xor
        ..color = p.color;

      canvas.drawCircle(p.position + offset, p.radius, paint);

      final p1 = p.origin + Offset(dx1, dy1);
      final p2 = p.origin + Offset(dx2, dy2);
      canvas.drawLine(p1, p.position + offset, paint);
      canvas.drawLine(p2, p.position + offset, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
