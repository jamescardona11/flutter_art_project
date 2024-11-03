import 'package:flutter/material.dart';
import 'package:flutter_art_project/utils/input_value.dart';

import 'moving_particles_page.dart';

class MovingParticlesSettings extends StatelessWidget {
  const MovingParticlesSettings({
    super.key,
    required this.controller,
    required this.painterState,
    required this.setPainterState,
  });

  final AnimationController controller;
  final MovingParticlesState painterState;
  final void Function(MovingParticlesState) setPainterState;

  @override
  Widget build(BuildContext context) {
    final (total, maxRadius, maxSpeed) = painterState;

    return Card(
      color: Colors.grey.shade200,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Expanded(
                child: InputValue(
                  label: 'Number of particles',
                  value: total,
                  onChanged: (value) {
                    setPainterState((value.toInt(), maxRadius, maxSpeed));
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InputValue(
                  label: 'Max radius',
                  value: maxRadius,
                  onChanged: (value) {
                    setPainterState((total, value.toDouble(), maxSpeed));
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InputValue(
                  label: 'Speed',
                  value: maxSpeed,
                  onChanged: (value) {
                    setPainterState((total, maxRadius, value.toDouble()));
                  },
                ),
              ),
            ]),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
