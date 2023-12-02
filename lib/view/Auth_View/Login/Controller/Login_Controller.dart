import 'package:bank/Core/cache_helper.dart';
import 'package:bank/Core/http_helper.dart';
import 'package:bank/view/Home_View/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var signInLoading = false.obs;
  late SharedPreferences sharedPreferences;

  @override
  void onInit() {
    super.onInit();
    // Initialize sharedPreferences when the controller is initialized
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    await CacheHelper.init();
  }

  Future<void> signIn({
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    print('start');
    signInLoading.value = true;

    // Ensure that sharedPreferences is initialized before using it
    await initializeSharedPreferences();

    try {
      final response = await HttpHelper.postData(
        endpoint: "login",
        body: {
          'phone': phone,
          'password': password,
        },
      );
      if (response["status"] == true) {
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
        await CacheHelper.saveDataSharedPreference(
          key: "token",
          value: response['token'],
        );
        Get.offAll(HomeScreen());
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
    } finally {
      signInLoading.value = false;
    }
  }
}
