import 'package:flutter/material.dart';

class ClassicProvider with ChangeNotifier {
  String iconTitle = 'Cones';
  String sizeTitle = 'Small';

  String get getClassicDetails => '$iconTitle, $sizeTitle';
  void setIconTitle(String title) {
    iconTitle = title;
    notifyListeners();
  }

  void setSizeTitle(String title) {
    sizeTitle = title;
    notifyListeners();
  }
}
