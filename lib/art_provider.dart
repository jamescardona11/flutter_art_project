import 'package:flutter/material.dart';

import 'pages/effect/cone_effect_view.dart';
import 'pages/effect/plasma_effect_view.dart';
import 'pages/particles/cloud_particles_view.dart';
import 'pages/particles/moving_particles_view.dart';
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

  List<(String, Widget)> get items => _items;

  (String, Widget) getItem([int? index]) => _items[index ?? _currentPage];

  final List<(String, Widget)> _items = [
    ('Moving Particles', const MovingParticlesView()),
    ('Cloud Particles', const CloudParticlesView()),
    ('Sphere Particles', const SphereParticlesView()),
    ('Cone Effect', const ConeEffectView()),
    ('Plasma Effect', const PlasmaEffectView()),
  ];
}
