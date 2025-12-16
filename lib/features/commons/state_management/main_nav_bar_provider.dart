import 'package:flutter/material.dart';

class MainNavBarProvider extends ChangeNotifier {
  int _index = 0;

  int get getSelectedIndex => _index;

  void changeIndex(int index) {
    if (_index != index) {
      _index = index;
      notifyListeners();
    }
  }
}
