import 'dart:math';
import 'dart:ui';

class RgnModel {
  final rng = Random(DateTime.now().millisecondsSinceEpoch);

  Color getRandomColor() {
    final a = rng.nextInt(255);
    final r = rng.nextInt(255);
    final g = rng.nextInt(255);
    final b = rng.nextInt(255);

    return Color.fromARGB(a, r, g, b);
  }

  double getDouble([double multi = 1]) {
    return rng.nextDouble() * multi;
  }

  Color getColorBlender(double d, double a) {
    final a = 255;
    final r = (sin(d * 2 * pi) * 127 + 127).toInt();
    final g = (cos(d * 2 * pi) * 127 + 127).toInt();
    final b = rng.nextInt(255);
    return Color.fromARGB(a, r, g, b);
  }
}
