import 'dart:math';
import 'dart:ui';

Color getRandomColor(Random rng) {
  final a = rng.nextInt(255);
  final r = rng.nextInt(255);
  final g = rng.nextInt(255);
  final b = rng.nextInt(255);

  return Color.fromARGB(a, r, g, b);
}

Offset polarToCartesian(double speed, double theta) =>
    Offset(speed * cos(theta), speed * sin(theta));

Color getColorBlender(Random rng, double d, double a) {
  final a = 255;
  final r = (sin(d * 2 * pi) * 127 + 127).toInt();
  final g = (cos(d * 2 * pi) * 127 + 127).toInt();
  final b = rng.nextInt(255);
  return Color.fromARGB(a, r, g, b);
}
