import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: ControllerProvider(
        controller: null,
        child: HomeWidget(),
      ),
    );
  }
}

class ControllerProvider extends InheritedWidget {
  final AnimationController? controller;

  const ControllerProvider({
    super.key,
    this.controller,
    required super.child,
  });

  static ControllerProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ControllerProvider>();
  }

  @override
  bool updateShouldNotify(ControllerProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}
