import 'package:bank/Core/cache_helper.dart';
import 'package:bank/Core/http_helper.dart';
import 'package:bank/view/Auth_View/Login/Screen/Password_Screen.dart';
import 'package:bank/view/Home_View/Screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screen/SecurtyCode.dart';

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();

  var signInLoading = false.obs;
  late SharedPreferences sharedPreferences;
  var idControllerSignUp = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initialize sharedPreferences when the controller is initialized
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    await CacheHelper.init();
  }

  Future<void> checkEmail({
    required String phone,
    required BuildContext context,
  }) async {
    print('start');
    signInLoading.value = true;

    // Ensure that sharedPreferences is initialized before using it
    await initializeSharedPreferences();

    try {
      final response = await HttpHelper.postData(
        endpoint: "check_login",
        body: {
          'email_phone': phone,
        },
      );
      if (response["status"] == true) {
        print(response.toString());
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
        Get.to(SecurityCodeScreen(
          email: email,
        ));
        await CacheHelper.saveDataSharedPreference(
          key: "user_id",
          value: response['user_id'],
        );
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

  Future<void> checkCodeEmail({
    required String code,
    required BuildContext context,
  }) async {
    print('start');
    signInLoading.value = true;

    // Ensure that sharedPreferences is initialized before using it
    await initializeSharedPreferences();

    try {
      final response = await HttpHelper.postData(
        endpoint: "check_code_login",
        body: {
          'phone_code': code,
          'user_id': CacheHelper.getDataSharedPreference(key: 'user_id')
        },
      );
      if (response["status"] == true) {
        print(response.toString());

        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
        Get.to(PasswordScreen());
        await CacheHelper.saveDataSharedPreference(
          key: "user_id",
          value: response['user_id'],
        );
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

  Future<void> checkPassword({
    required String password,
    required BuildContext context,
  }) async {
    print('start');
    signInLoading.value = true;

    // Ensure that sharedPreferences is initialized before using it
    await initializeSharedPreferences();

    try {
      final response = await HttpHelper.postData(
        endpoint: "password_login",
        body: {
          'password': password,
          'user_id': CacheHelper.getDataSharedPreference(key: 'user_id')
        },
      );
      if (response["status"] == true) {
        print(response.toString());

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
