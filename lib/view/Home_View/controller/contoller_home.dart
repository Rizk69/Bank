import 'package:bank/view/Home_View/Screens/first_screen.dart';
import 'package:bank/view/Home_View/model/HomeModel.dart';
import 'package:bank/view/MBAG_Card_Screen/Screen/MBAG_Card_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/http_helper.dart';
import '../../../main.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

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

class HomeControllerGetData extends GetxController {
  final Rx<HomeModel> _homeModel = HomeModel().obs;
  var isLoading = true.obs; // Start with loading as true

  HomeModel get homeModel => _homeModel.value;

  @override
  void onInit() {
    super.onInit();
    getDataHome();
  }

  @override
  Future<void> refresh() async {
    try {
      await getDataHome();
    } catch (error) {
      print('Error during refresh: $error');
    } finally {
      update();
    }
  }

  Future<void> getDataHome() async {
    try {
      final response = await HttpHelper.getData(
        endpoint: "home",
      );
      if (response["status"] == true) {
        if (response.containsKey("data")) {
          _homeModel.value = HomeModel.fromJson(response["data"]);
          isLoading.value = false;
          update();
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    } catch (error) {
      print('Error during data fetching: $error');
      isLoading.value = false;
    }
  }
}
