import 'package:MBAG/helper/HelperScreenNerst.dart';
import 'package:MBAG/view/Home_View/Screens/first_screen.dart';
import 'package:MBAG/view/MBAG_Card_Screen/Screen/MBAG_Card_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
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
        _currentScreen = SlideDownTextAnimation(
          appBarView: false,
        );
        break;
      case 4:
        _currentScreen = SlideDownTextAnimation(
          appBarView: false,
        );
        //MBAGCardScreen();
        break;
      default:
        _currentScreen = FirstScreen();
        break;
    }

    update();
  }
}

