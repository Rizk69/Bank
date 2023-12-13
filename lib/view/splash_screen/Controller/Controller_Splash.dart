import 'package:bank/Core/cache_helper.dart';
import 'package:bank/view/Home_View/Screens/home_screen.dart';
import 'package:bank/view/on_bording_screen/Screen/OnbordingScreen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
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
        Get.off(() => HomeScreen());
      }
    });
  }

  static const splashDelaySeconds = 3;
}
