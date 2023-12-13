import 'package:bank/view/Home_View/Screens/first_screen.dart';
import 'package:bank/view/Home_View/model/HomeModel.dart';
import 'package:bank/view/MBAG_Card_Screen/Screen/MBAG_Card_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/http_helper.dart';
import '../../../main.dart';

class HomeController extends GetxController {
  late HomeModel _homeModel;

  HomeModel get homeModel => _homeModel;

  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
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
  Rx<HomeModel> _homeModel = HomeModel().obs;
  var isLoading = false.obs; // Start with loading as true

  HomeModel get homeModel => _homeModel.value;

  @override
  void onInit() {
    super.onInit();
    getDataHome();
  }

  Future<void> getDataHome() async {
    try {
      final response = await HttpHelper.getData(
        endpoint: "home",
      );
      if (response["status"] == true) {
        isLoading.value = true;

        _homeModel.value = HomeModel.fromJson(response);
        print(response.toString());
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
        isLoading.value = false;
      }
    } catch (error) {
      print(error);
    }
  }
}
