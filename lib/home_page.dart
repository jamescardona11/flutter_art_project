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
  final PageController _pageController = PageController(initialPage: 0);

  final List<(String, Widget)> items = [
    ('Moving Particles', const MovingParticlesView()),
    ('Cloud Particles', const CloudParticlesView()),
    ('Sphere Particles', const SphereParticlesView()),
    ('Cone Effect', const ConeEffectView()),
    ('Plasma Effect', const PlasmaEffectView()),
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(
        title: items[_currentPage].$1,
        onBackPressed: () => _onArrowPressed(false),
        onForwardPressed: () => _onArrowPressed(true),
      ),
      drawer: _Drawer(
        items: items,
        onListTilePressed: _onListTilePressed,
        currentPage: _currentPage,
      ),
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) {
            return _PageViewWidget(items: items, index: index);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onListTilePressed(int index) {
    _pageController.jumpToPage(index);
    Navigator.pop(context);
  }

  // Circular navigation
  void _onArrowPressed(bool isNext) {
    final targetPage = isNext ? (_currentPage + 1) % items.length : (_currentPage - 1 + items.length) % items.length;
    _pageController.jumpToPage(targetPage);
  }
}

class _PageViewWidget extends StatelessWidget {
  const _PageViewWidget({
    required this.items,
    required this.index,
  });

  final List<(String, Widget)> items;
  final int index;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 300)),
      builder: (context, snapshot) {
        final (_, child) = items[index];

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
              : child,
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    required this.title,
    required this.onBackPressed,
    required this.onForwardPressed,
  });

  final String title;
  final VoidCallback onBackPressed;
  final VoidCallback onForwardPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBackPressed,
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: onForwardPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    required this.items,
    required this.onListTilePressed,
    required this.currentPage,
  });

  final List<(String, Widget)> items;
  final ValueChanged<int> onListTilePressed;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            final (title, _) = item;
            return ListTile(
              leading: Icon(getRandomIcon(index)),
              title: Text(title),
              trailing: index == currentPage
                  ? const Icon(
                      Icons.circle,
                      size: 10,
                      color: Colors.blue,
                    )
                  : null,
              onTap: () => onListTilePressed(index),
            );
          }),
        ],
      ),
    );
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
