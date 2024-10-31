import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_art_project/pages/effect/cone_effect_view.dart';

import 'pages/effect/plasma_effect_view.dart';
import 'pages/particles/cloud_particles_view.dart';
import 'pages/particles/moving_particles_view.dart';
import 'pages/particles/sphere_particles_view.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final List<(String, Widget)> items = [
    ('Moving Particles', const MovingParticlesView()),
    ('Cloud Particles', const CloudParticlesView()),
    ('Sphere Particles', const SphereParticlesView()),
    ('Cone Effect', const ConeEffectView()),
    ('Plasma Effect', const PlasmaEffectView()),
  ];

  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(items[_currentPage].$1),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _onArrowPressed(false),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => _onArrowPressed(true),
          ),
        ],
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
            ...items.mapIndexed((index, item) {
              return ListTile(
                leading: Icon(getRandomIcon(index)),
                title: Text(item.$1),
                onTap: () => _onListTilePressed(index),
              );
            }),
          ],
        ),
      ),
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 300)),
              builder: (context, snapshot) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: snapshot.connectionState != ConnectionState.done
                      ? const Center(
                          key: ValueKey('loader'),
                          child: CircularProgressIndicator(),
                        )
                      : items[index].$2,
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _onListTilePressed(int index) {
    _pageController.jumpToPage(index);
    Navigator.pop(context);
  }

  void _onArrowPressed(bool isNext) {
    late int targetPage;
    if (isNext) {
      targetPage = 0;
      if (_currentPage < items.length - 1) {
        targetPage = _currentPage + 1;
      }
    } else {
      targetPage = items.length - 1;
      if (_currentPage > 0) {
        targetPage = _currentPage - 1;
      }
    }
    _pageController.jumpToPage(targetPage);
  }

  IconData getRandomIcon(int index) {
    final List<IconData> icons = [
      Icons.star,
      Icons.favorite,
      Icons.palette,
      Icons.brush,
      Icons.color_lens,
      Icons.auto_awesome,
      Icons.bubble_chart,
      Icons.blur_on,
      Icons.gesture,
      Icons.grain,
      Icons.circle,
      Icons.circle_outlined,
      Icons.lens,
      Icons.lens_blur,
      Icons.blur_circular,
      Icons.blur_linear,
      Icons.waves,
      Icons.water_drop,
      Icons.light_mode,
      Icons.brightness_7,
      Icons.flare,
      Icons.filter_drama,
      Icons.filter_vintage,
      Icons.scatter_plot,
      Icons.motion_photos_on,
      Icons.animation,
      Icons.auto_fix_high,
      Icons.diamond
    ];

    return icons[index % icons.length];
  }
}
