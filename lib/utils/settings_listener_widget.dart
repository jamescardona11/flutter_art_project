import 'package:flutter/material.dart';
import 'package:flutter_art_project/provider/art_provider.dart';

class SettingsListenerWidget extends StatelessWidget {
  const SettingsListenerWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ArtProvider(),
      builder: (context, child) {
        final item = ArtProvider().getItem();
        final showSettings = ArtProvider().showControllerSettings;

        if (item.hasSettingsView && showSettings) {
          return child!;
        }

        return const SizedBox.shrink();
      },
      child: child,
    );
  }
}
