import 'package:bank/Core/cache_helper.dart';
import 'package:bank/view/Home_View/Screens/home_screen.dart';
import 'package:bank/view/on_bording_screen/Screen/OnbordingScreen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  void navigateToOnboarding() async {
    var token = CacheHelper.getDataSharedPreference(key: 'token');
    print('token===>$token');
    if (token == null) {
      await Future.delayed(Duration(seconds: 3));
      Get.off(() => CupertinoOnboardingScreen());
    } else {
      await Future.delayed(Duration(seconds: 3));
      Get.off(() => HomeScreen());
    }
  }
}
