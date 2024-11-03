import 'package:flutter/material.dart';
import 'package:flutter_art_project/utils/input_value.dart';

class MovingParticlesSettings extends StatefulWidget {
  const MovingParticlesSettings({
    super.key,
    required this.controller,
    required this.automatic,
    required this.setAutomatic,
  });

  final AnimationController controller;
  final bool automatic;
  final void Function(bool) setAutomatic;

  @override
  State<MovingParticlesSettings> createState() => _MovingParticlesSettingsState();
}

class _MovingParticlesSettingsState extends State<MovingParticlesSettings> {
  int total = 100;
  double maxRadius = 6;
  double maxSpeed = 0.5;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Automatic'),
              value: widget.automatic,
              onChanged: widget.setAutomatic,
            ),
            if (!widget.automatic)
              AnimatedBuilder(
                animation: widget.controller,
                builder: (context, child) => Slider(
                  value: widget.controller.value,
                  onChanged: (value) {
                    widget.controller.value = value;
                  },
                ),
              ),
            Row(children: [
              Expanded(
                child: InputValue(
                  label: 'Number of particles',
                  value: total,
                  onChanged: (value) {
                    total = value.toInt();
                  },
                ),
              ),
              Expanded(
                child: InputValue(
                  label: 'Max radius',
                  value: maxRadius,
                  onChanged: (value) {
                    maxRadius = value.toDouble();
                  },
                ),
              ),
              Expanded(
                child: InputValue(
                  label: 'Speed',
                  value: maxSpeed,
                  onChanged: (value) {
                    maxSpeed = value.toDouble();
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
