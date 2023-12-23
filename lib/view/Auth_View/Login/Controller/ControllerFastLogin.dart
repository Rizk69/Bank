import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../Core/http_helper.dart';
import '../../../Home_View/Screens/home_screen.dart';

class FastLoginController extends GetxController {
  RxBool isLoggedIn = false.obs;

  void login() {
    // Your login logic here
    isLoggedIn.value = true;
  }

  void logout() {
    // Your logout logic here
    isLoggedIn.value = false;
  }

  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  void onInit() {
    super.onInit();
    // Initialize sharedPreferences when the controller is initialized
    authenticate();
  }

  Future<void> authenticate() async {
    try {
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        print('Biometric authentication not available on this device.');
        return;
      }

      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate for quick login',
      );

      if (authenticated) {
        print('User authenticated successfully!');
        // Use Get.to to navigate to the next screen or perform the desired action.
        Get.to(
            () => HomeScreen()); // Replace NextScreen with your desired screen.
      } else {
        print('Biometric authentication failed.');
      }
    } catch (e) {
      print('Authentication Error: $e');
    }
  }

  Future<void> checkPassword({
    required String password,
    required BuildContext context,
  }) async {
    print('start');

    try {
      final response = await HttpHelper.postData(
        endpoint: "fast_login",
        body: {
          'password': password,
        },
      );
      print(response.toString());
      if (response["status"] == true) {
        print(response.toString());

        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);

        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print(" FastLogin${error}");
    } finally {}
  }
}
