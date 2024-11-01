import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_art_project/pages/effect/cone_effect_view.dart';

import 'pages/effect/plasma_effect_view.dart';
import 'pages/particles/cloud_particles_view.dart';
import 'pages/particles/moving_particles_view.dart';
import 'pages/particles/sphere_particles_view.dart';
import 'provider/art_provider.dart';
import 'provider/settings_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final List<(String, Widget)> artPages = [
    ('Moving Particles', const MovingParticlesView()),
    ('Cloud Particles', const CloudParticlesView()),
    ('Sphere Particles', const SphereParticlesView()),
    ('Cone Effect', const ConeEffectView()),
    ('Plasma Effect', const PlasmaEffectView()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(artPages: artPages),
      drawer: _Drawer(artPages: artPages),
      body: Stack(
        children: [
          _PageViewWidget(items: artPages),
          if (ArtProvider.instance.showControllerSettings)
            const Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SettingsWidget(),
            ),
        ],
      ),
    );
  }
}

class _PageViewWidget extends StatefulWidget {
  const _PageViewWidget({
    required this.items,
  });

  final List<(String, Widget)> items;

  @override
  State<_PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<_PageViewWidget> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: ArtProvider.instance.pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.items.length,
        onPageChanged: (index) => ArtProvider.instance.setCurrentPage(index),
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 300)),
            builder: (context, snapshot) {
              final (_, child) = widget.items[index];

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
        });
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    required this.artPages,
  });

  final List<(String, Widget)> artPages;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ArtProvider.instance,
      builder: (context, child) {
        final currentPage = ArtProvider.instance.currentPage;
        return AppBar(
          title: Text(artPages[currentPage].$1),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: ArtProvider.instance.setShowControllerSettings,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => onArrowPressed(false),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => onArrowPressed(true),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  // Circular navigation
  void onArrowPressed(bool isNext) {
    final currentPage = ArtProvider.instance.currentPage;
    final itemsLength = artPages.length;
    final targetPage = isNext ? (currentPage + 1) % itemsLength : (currentPage - 1 + itemsLength) % itemsLength;
    ArtProvider.instance.pageController.jumpToPage(targetPage);
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    required this.artPages,
  });

  final List<(String, Widget)> artPages;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ArtProvider.instance,
      builder: (context, child) => Drawer(
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
            ...artPages.mapIndexed((index, item) {
              final (title, _) = item;
              return ListTile(
                leading: Icon(getRandomIcon(index)),
                title: Text(title),
                trailing: index == ArtProvider.instance.currentPage
                    ? const Icon(
                        Icons.circle,
                        size: 10,
                        color: Colors.blue,
                      )
                    : null,
                onTap: () => onListTilePressed(context, index),
              );
            }),
          ],
        ),
      ),
    );
  }

  void onListTilePressed(BuildContext context, int index) {
    final provider = ArtProvider.instance;
    provider.setCurrentPage(index);
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
