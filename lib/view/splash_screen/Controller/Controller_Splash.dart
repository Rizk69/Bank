import 'dart:ui';

import 'package:get/get.dart';

import '../../../ConrollerMain.dart';
import '../../../Core/cache_helper.dart';
import '../../Auth_View/Login/Screen/FastLogin.dart';
import '../../Home_View/Screens/home_screen.dart';
import '../../on_bording_screen/Screen/OnbordingScreen.dart';

class SplashController extends GetxController {
  AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    super.onInit();
    navigateToNextScreen();
  }

  void navigateToNextScreen() {
    Future.delayed(const Duration(seconds: splashDelaySeconds), () {
      var token = CacheHelper.getDataSharedPreference(key: 'token');
      print('token ===> $token');

      if (token == null) {
        Get.off(() => CupertinoOnboardingScreen());
      } else {
        final notificationType = authController.notification?.runtimeType;
        if (notificationType == AppLifecycleState.detached.runtimeType ||
            notificationType == AppLifecycleState.resumed.runtimeType ||
            notificationType == null) {
          Get.off(() => FastLogin());
        } else {
          Get.off(() => HomeScreen());
        }
      }
    });
  }

  static const splashDelaySeconds = 3;
}
