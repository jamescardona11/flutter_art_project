import 'package:flutter/material.dart';

import 'settings_provider.dart';

class SettingsInheritedWidget extends InheritedWidget {
  final SettingsProvider provider;

  const SettingsInheritedWidget({
    super.key,
    required this.provider,
    required super.child,
  });

  static SettingsInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SettingsInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(SettingsInheritedWidget oldWidget) {
    return provider != oldWidget.provider;
  }
}
