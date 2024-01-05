import 'package:MBAG/view/Auth_View/Login/Controller/TimerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Core/cache_helper.dart';
import '../../../../Core/http_helper.dart';
import '../../../Home_View/Screens/home_screen.dart';
import '../Screen/Password_Screen.dart';
import '../Screen/SecurtyCode.dart';

class ApiEndpoints {
  static const String checkLogin = "check_login";
  static const String checkCodeLogin = "check_code_login";
  static const String passwordLogin = "password_login";
  static const String sendAmount = 'send_amount';
  static const String getQrClient = 'get_qr_client';
}

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isFormValid = true.obs;
  final RxBool signInLoading = false.obs;
  int _userId = 0;

  @override
  void onInit() {
    super.onInit();
    // initializeSharedPreferences();
  }

  //
  // Future<void> initializeSharedPreferences() async {
  //   await CacheHelper.init();
  // }

  Future<void> checkEmail({
    required String phone,
    required BuildContext context,
  }) async {
    print('Checking email for phone: $phone');
    signInLoading.value = true;

    // await initializeSharedPreferences();

    try {
      final response = await HttpHelper.postData(
        endpoint: ApiEndpoints.checkLogin,
        body: {'email_phone': phone},
      );

      if (response.containsKey("status")) {
        if (response["status"]) {
          showSuccessSnackbar(response['message']);
          print(response);
          _userId = response['user_id'];
          try {
            await CacheHelper.saveDataSharedPreference(
              key: "user_id",
              value: response['user_id'],
            );
            if (_userId == 0) {
            } else {
              navigateToSecurityCodeScreen();
            }
          } catch (e) {
            print("Error saving user ID: $e");
          }
        } else {
          showWarningSnackbar(response['message']);
        }
      } else {
        showErrorSnackbar("Invalid server response structure.");
      }
    } catch (error) {
      showErrorSnackbar("An error occurred while checking email.");
      print("Error in checkEmail: $error");
    } finally {
      signInLoading.value = false;
    }
  }

  Future<void> resendCode({
    required String phone,
  }) async {
    signInLoading.value = true;

    try {
      final response = await HttpHelper.postData(
        endpoint: ApiEndpoints.checkLogin,
        body: {'email_phone': phone},
      );

      if (response["status"]) {
        showSuccessSnackbar(response['message']);
        print("Resend$response");
        await CacheHelper.saveDataSharedPreference(
          key: "user_id",
          value: response['user_id'],
        );
        navigateToSecurityCodeScreen();
      } else {
        showWarningSnackbar(response['message']);
      }
    } catch (error) {
      showErrorSnackbar("An error occurred while checking email.");
    } finally {
      signInLoading.value = false;
    }
  }

  Future<void> checkCodeEmail({
    required String code,
    required BuildContext context,
  }) async {
    signInLoading.value = true;

    // await initializeSharedPreferences();

    try {
      final response = await HttpHelper.postData(
        endpoint: ApiEndpoints.checkCodeLogin,
        body: {'phone_code': code, 'user_id': _userId},
      );

      if (response["status"]) {
        showSuccessSnackbar(response['message']);
        navigateToPasswordScreen();
        await CacheHelper.saveDataSharedPreference(
          key: "user_id",
          value: response['user_id'],
        );
      } else {
        showWarningSnackbar(response['message']);
      }
    } catch (error) {
      showErrorSnackbar("An error occurred while checking security code.");
    } finally {
      signInLoading.value = false;
    }
  }

  Future<void> checkPassword({
    required String password,
    required BuildContext context,
  }) async {
    signInLoading.value = true;

    var device_token = CacheHelper.getDataSharedPreference(key: 'fcmToken');

    try {
      print(device_token);
      final response = await HttpHelper.postData(
        endpoint: ApiEndpoints.passwordLogin,
        body: {
          'password': password,
          'user_id': CacheHelper.getDataSharedPreference(key: 'user_id'),
          'device_token': device_token
        },
      );

      if (response["status"]) {
        await CacheHelper.saveDataSharedPreference(
          key: "token",
          value: response['token'],
        );
        Get.offAll(() => HomeScreen());
      } else {
        showWarningSnackbar(response['message']);
      }
    } catch (error) {
      showErrorSnackbar("An error occurred while checking password.");
    } finally {
      signInLoading.value = false;
    }
  }

  void showSuccessSnackbar(String message) {
    Get.snackbar("Success!", message, backgroundColor: Colors.green);
  }

  void showWarningSnackbar(String message) {
    Get.snackbar("Warning!", message,
        backgroundColor: Colors.red, duration: Duration(seconds: 3));
  }

  void showErrorSnackbar(String message) {
    Get.snackbar("Error!", message,
        backgroundColor: Colors.red, duration: Duration(seconds: 3));
  }

  void navigateToSecurityCodeScreen() {
    Get.to(() => SecurityCodeScreen(email: email));
  }

  void navigateToPasswordScreen() {
    Get.to(() => PasswordScreen());
  }
}

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
  }

  void login() {
    updateAuthStatus(true);
  }

  void logout() {
    updateAuthStatus(false);
  }

  Future<void> updateAuthStatus(bool status) async {
    isLoggedIn.value = status;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', status);
  }
}
