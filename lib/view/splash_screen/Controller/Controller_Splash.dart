import 'dart:ui';

import 'package:get/get.dart';

import '../../../ConrollerMain.dart';
import '../../../Core/cache_helper.dart';
import '../../../Core/http_helper.dart';
import '../../Auth_View/Login/Screen/FastLogin.dart';
import '../../Home_View/Screens/home_screen.dart';
import '../../on_bording_screen/Screen/OnbordingScreen.dart';

class SplashController extends GetxController {
  AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    super.onInit();
    checkFirstRun();
    navigateToNextScreen();
  }

  Future<void> checkFirstRun() async {
    bool isFirstRun =
        await CacheHelper.getDataSharedPreference(key: 'isFirstRun') ?? true;
    if (isFirstRun) {
      await CacheHelper.removeData(key: 'token');
      await CacheHelper.saveDataSharedPreference(
          key: 'isFirstRun', value: false);
    }
  }

  void navigateToNextScreen() {
    Future.delayed(const Duration(seconds: splashDelaySeconds), () async {
      var token = await CacheHelper.getDataSharedPreference(key: 'token');
      print('token ===> $token');

      if (token == null || token.isEmpty) {
        Get.off(() => CupertinoOnboardingScreen());
      } else {
        bool isTokenValid = await checkTokenValidity(token);
        if (isTokenValid) {
          Get.off(() => FastLogin());
        } else {
          Get.off(() => CupertinoOnboardingScreen());
        }
      }
    });
  }

  Future<bool> checkTokenValidity(String token) async {
    print('Checking token: $token');
    try {
      final response = await HttpHelper.getData(
        endpoint: "token",
      );

      if (response["status"] == true) {
        print('Token is valid: ${response.toString()}');
        return true;
      } else {
        print('Token is invalid.');
        return false;
      }
    } catch (error) {
      print('Error occurred while validating token: $error');
      // Optionally, implement retry logic or different error handling here
      return false; // Assuming token is invalid if an error occurs
    }
  }

  // void navigateToNextScreen() {
  //   Future.delayed(const Duration(seconds: splashDelaySeconds), () {
  //     var token = CacheHelper.getDataSharedPreference(key: 'token');
  //     print('token ===> $token');
  //
  //     if (token == null) {
  //       Get.off(() => CupertinoOnboardingScreen());
  //     } else {
  //       final notificationType = authController.notification?.runtimeType;
  //       if (notificationType == AppLifecycleState.detached.runtimeType ||
  //           notificationType == AppLifecycleState.resumed.runtimeType ||
  //           notificationType == null) {
  //         Get.off(() => FastLogin());
  //       } else {
  //         Get.off(() => HomeScreen());
  //       }
  //     }
  //   });
  // }

  static const splashDelaySeconds = 3;
}
