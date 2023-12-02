import 'package:bank/view/Home_View/Screens/first_screen.dart';
import 'package:bank/view/Home_View/Screens/home_screen.dart';
import 'package:bank/view/MBAG_Card_Screen/Screen/MBAG_Card_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class HomeControllerBottomNav extends GetxController {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  Widget _currentScreen = FirstScreen();

  get currentScreen => _currentScreen;

  void changeIndex(int index) {
    _currentIndex = index;

    switch (index) {
      case 0:
      case 1:
      case 2:
        _currentScreen = FirstScreen();
        break;
      case 3:
        _currentScreen = ScreenFour();
        break;
      case 4:
        _currentScreen = MBAGCardScreen();
        break;
      default:
        _currentScreen = FirstScreen();
        break;
    }

    update();
  }
}
