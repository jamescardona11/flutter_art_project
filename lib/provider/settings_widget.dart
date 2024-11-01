import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({
    super.key,
  });

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [],
      ),
    );
    // return AnimatedBuilder(
    //   animation: provider,
    //   builder: (context, child) => Card(
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Row(
    //             children: [
    //               Checkbox(
    //                 value: provider.isAutomatic,
    //                 onChanged: (value) {
    //                   provider.setIsAutomatic(value ?? true);
    //                 },
    //               ),
    //               const Text('Automatic Animation'),
    //             ],
    //           ),
    //           if (!provider.isAutomatic)
    //             Slider(
    //               value: provider.controller?.value ?? 0,
    //               onChanged: (value) {
    //                 provider.setAnimationValue(value);
    //               },
    //             ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
