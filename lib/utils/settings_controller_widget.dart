import 'package:flutter/material.dart';
import 'package:flutter_art_project/main.dart';

class SettingsControllerWidget extends StatefulWidget {
  const SettingsControllerWidget({
    super.key,
  });

  @override
  State<SettingsControllerWidget> createState() => _SettingsControllerWidgetState();
}

class _SettingsControllerWidgetState extends State<SettingsControllerWidget> {
  bool isAutomatic = true;
  AnimationController? get controller => ControllerProvider.of(context)?.controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isAutomatic,
                  onChanged: (value) {
                    setState(() {
                      isAutomatic = value ?? true;
                      if (isAutomatic) {
                        controller?.repeat();
                      } else {
                        controller?.stop();
                      }
                    });
                  },
                ),
                const Text('Automatic Animation'),
              ],
            ),
            if (!isAutomatic)
              Slider(
                value: controller?.value ?? 0,
                onChanged: (value) {
                  setState(() {
                    controller?.value = value;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
