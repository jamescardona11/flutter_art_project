import 'package:flutter/material.dart';

import 'settings_iw.dart';
import 'settings_provider.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({
    super.key,
  });

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  SettingsProvider get provider => SettingsInheritedWidget.of(context).provider;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: provider,
      builder: (context, child) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: provider.isAutomatic,
                    onChanged: (value) {
                      provider.setIsAutomatic(value ?? true);
                    },
                  ),
                  const Text('Automatic Animation'),
                ],
              ),
              if (!provider.isAutomatic)
                Slider(
                  value: provider.controller?.value ?? 0,
                  onChanged: (value) {
                    provider.setAnimationValue(value);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
