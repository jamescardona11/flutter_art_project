import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'provider/art_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width * 0.4;
    final height = size.height * 0.8;

    return Scaffold(
      appBar: _AppBar(),
      drawer: _Drawer(),
      body: Center(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: _PageViewWidget(),
        ),
      ),
    );
  }
}

class _PageViewWidget extends StatefulWidget {
  const _PageViewWidget();

  @override
  State<_PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<_PageViewWidget> {
  final Completer<void> completer = Completer<void>();
  final duration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    Future.delayed(duration).then(completer.complete);
  }

  @override
  Widget build(BuildContext context) {
    final provider = ArtProvider();
    return PageView.builder(
        controller: provider.pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: provider.length,
        onPageChanged: (index) => provider.setCurrentPage(index),
        itemBuilder: (context, index) {
          final item = provider.getItem(index);

          if (kIsWeb) {
            return item.view;
          }

          return FutureBuilder(
            future: completer.future,
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
                    : item.view,
              );
            },
          );
        });
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final provider = ArtProvider();
    return AnimatedBuilder(
      animation: provider,
      builder: (context, child) {
        final item = provider.getItem();

        return AppBar(
          title: Text(item.title),
          actions: [
            if (item.hasSettingsView)
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: provider.setShowControllerSettings,
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
    final provider = ArtProvider();
    final currentPage = provider.currentPage;
    final itemsLength = provider.length;

    final targetPage = isNext ? (currentPage + 1) % itemsLength : (currentPage - 1 + itemsLength) % itemsLength;
    provider.pageController.jumpToPage(targetPage);
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    final provider = ArtProvider();
    return AnimatedBuilder(
      animation: provider,
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
            ...provider.items.mapIndexed((index, item) {
              return ListTile(
                leading: Icon(getRandomIcon(index)),
                title: Text(item.title),
                trailing: index == provider.currentPage
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
    ArtProvider().setCurrentPage(index);
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
