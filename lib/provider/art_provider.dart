import 'package:flutter/material.dart';

class ArtProvider extends ChangeNotifier {
  static ArtProvider? _instance;
  static ArtProvider get instance => _instance ??= ArtProvider();

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
  bool get showControllerSettings => _showControllerSettings;
}
