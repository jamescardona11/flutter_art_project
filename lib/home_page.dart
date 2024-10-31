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
        currentPage: _currentPage,
        pageController: _pageController,
        itemsLength: items.length,
      ),
      drawer: _Drawer(
        items: items,
        pageController: _pageController,
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
    required this.currentPage,
    required this.pageController,
    required this.itemsLength,
  });

  final String title;
  final int currentPage;
  final int itemsLength;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  // Circular navigation
  void _onArrowPressed(bool isNext) {
    final targetPage = isNext ? (currentPage + 1) % itemsLength : (currentPage - 1 + itemsLength) % itemsLength;
    pageController.jumpToPage(targetPage);
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    required this.items,
    required this.pageController,
    required this.currentPage,
  });

  final List<(String, Widget)> items;
  final PageController pageController;
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
              onTap: () => _onListTilePressed(context, index),
            );
          }),
        ],
      ),
    );
  }

  void _onListTilePressed(BuildContext context, int index) {
    pageController.jumpToPage(index);
    Navigator.pop(context);
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
