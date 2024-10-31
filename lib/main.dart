import 'package:flutter/material.dart';
import 'package:flutter_art_project/pages/effect/cone_effect_view.dart';

import 'pages/effect/plasma_effect_view.dart';
import 'pages/particles/cloud_particles_view.dart';
import 'pages/particles/moving_particles_view.dart';
import 'pages/particles/sphere_particles_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final Map<String, Widget> items = {
    'Cone Effect': const ConeEffectView(),
    'Plasma Effect': const PlasmaEffectView(),
    'Cloud Particles': const CloudParticlesView(),
    'Moving Particles': const MovingParticlesView(),
    'Sphere Particles': const SphereParticlesView(),
  };

  String _currentPage = 'Effect Section';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My art project'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Art Project Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            for (var item in items.entries)
              ListTile(
                leading: const Icon(Icons.palette),
                title: Text(item.key),
                onTap: () {
                  setState(() {
                    _currentPage = item.key;
                  });
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
      body: SafeArea(
        child: items[_currentPage] ?? const SizedBox(),
      ),
    );
  }
}
