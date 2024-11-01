import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  AnimationController? _controller;
  bool _isAutomatic = true;
  Duration _duration = const Duration(milliseconds: 300);

  void setController(AnimationController? value) {
    _controller = value;
    notifyListeners();
  }

  void setIsAutomatic(bool value) {
    _isAutomatic = value;
    notifyListeners();
  }

  void setDuration(int milliseconds) {
    _duration = Duration(milliseconds: milliseconds);
    notifyListeners();
  }

  void setAnimationValue(double value) {
    if (_controller == null) return;
    _controller!.value = value;
    notifyListeners();
  }

  AnimationController? get controller => _controller;
  bool get isAutomatic => _isAutomatic;
  Duration get duration => _duration;
}
