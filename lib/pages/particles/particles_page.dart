import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'cloud_particles_view.dart';
import 'moving_particles_view.dart';

class ParticlesPage extends StatefulWidget {
  const ParticlesPage({
    Key? key,
  }) : super(key: key);

  @override
  _ParticlesPageState createState() => _ParticlesPageState();
}

class _ParticlesPageState extends State<ParticlesPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          MovingParticlesView(),
          CloudParticlesView(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.microwave_rounded),
              title: const Text("Moving"),
              selectedColor: Colors.purple,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.cloud),
              title: const Text("Cloud"),
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
