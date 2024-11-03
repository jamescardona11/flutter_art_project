import 'package:flutter/material.dart';

import 'pages/effect/cone_effect_view.dart';
import 'pages/effect/plasma_effect_view.dart';
import 'pages/moving_particles/moving_particles_page.dart';
import 'pages/particles/cloud_particles_view.dart';
import 'pages/particles/sphere_particles_view.dart';

class ArtProvider extends ChangeNotifier {
  ArtProvider._();
  factory ArtProvider() {
    _instance ??= ArtProvider._();
    return _instance!;
  }

  static ArtProvider? _instance;

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool _showControllerSettings = false;

  void setCurrentPage(int value) {
    _currentPage = value;
    _showControllerSettings = false;
    _pageController.jumpToPage(value);
    notifyListeners();
  }

  void setShowControllerSettings() {
    _showControllerSettings = !_showControllerSettings;
    notifyListeners();
  }

  PageController get pageController => _pageController;

  int get currentPage => _currentPage;

  int get length => _items.length;

  bool get showControllerSettings => _showControllerSettings;

  List<ArtPageItems> get items => _items;

  ArtPageItems getItem([int? index]) => _items[index ?? _currentPage];

  final List<ArtPageItems> _items = [
    ArtPageItems(
      title: 'Moving Particles',
      view: const MovingParticlesPage(),
      // settingsView: MovingParticlesSettings(controller: ),
    ),
    ArtPageItems(
      title: 'Cloud Particles',
      view: const CloudParticlesView(),
    ),
    ArtPageItems(
      title: 'Sphere Particles',
      view: const SphereParticlesView(),
    ),
    ArtPageItems(
      title: 'Cone Effect',
      view: const ConeEffectView(),
    ),
    ArtPageItems(
      title: 'Plasma Effect',
      view: const PlasmaEffectView(),
    ),
  ];
}

class ArtPageItems {
  final String title;
  final Widget view;
  final Widget? settingsView;

  ArtPageItems({
    required this.title,
    required this.view,
    this.settingsView,
  });

  bool get hasSettingsView => settingsView != null;
}
