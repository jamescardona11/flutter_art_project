import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'cone_effect_view.dart';
import 'plasma_effect_view.dart';

class EffectPage extends StatefulWidget {
  const EffectPage({
    Key? key,
  }) : super(key: key);

  @override
  _EffectPageState createState() => _EffectPageState();
}

class _EffectPageState extends State<EffectPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          ConeEffectView(),
          PlasmaEffectView(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.first_page_rounded),
              title: const Text("Cone"),
              selectedColor: Colors.purple,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.confirmation_number_sharp),
              title: const Text("Plasma"),
              selectedColor: Colors.pink,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.stream),
              title: const Text("Sphere"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
