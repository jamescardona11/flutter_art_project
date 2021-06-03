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
}
