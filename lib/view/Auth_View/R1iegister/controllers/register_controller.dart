import 'package:bank/view/Auth_View/Login/Controller/PinController.dart';
import 'package:bank/view/Auth_View/R1iegister/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker_nm/country.dart';
import 'package:get/get.dart';

import '../../../../Core/cache_helper.dart';
import '../../../../Core/http_helper.dart';
import '../../../Home_View/Screens/home_screen.dart';

class RegisterController extends GetxController {
  var bordcontroller = PageController();
  var emailControllerSignUp = TextEditingController();
  var idControllerSignUp = TextEditingController();
  var keyFormSignUpOne = GlobalKey<FormState>();
  var passwordControllerSignUpOne = TextEditingController();
  var firstNameControllerSignUpTwo = TextEditingController();
  var keyFormSignUpTwo = GlobalKey<FormState>();
  var lastNameControllerSignUpTwo = TextEditingController();
  var mobileNumberControllerSignUp = TextEditingController();
  final PinputControllerSinUp controllerPin = Get.put(PinputControllerSinUp());
  final PinputControllerSinUpCheckEmail controllerPinCheckEmail =
      Get.put(PinputControllerSinUpCheckEmail());

  @override
  void onInit() {
    super.onInit();
    // Initialize sharedPreferences when the controller is initialized
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    await CacheHelper.init();
  }

  late Country selected;
  Rx<bool> agreedToTerms = false.obs;
  Rx<bool> agreedToTerms1 = false.obs;

  void changAgree(bool value) {
    agreedToTerms.value = value;
    update();
  }

  void changAgree1(bool value) {
    agreedToTerms1.value = value;
    update();
  }

  bool isLast = false;
  dynamic index = 0;
  int textButton = 0;

  dynamic ChangeIndex(index) {
    textButton = index;
    if (index == screenRegister.length - 1) {
      isLast = true;
      print("true");
    } else {
      isLast = false;
    }
  }

  void navigNext() {
    bordcontroller.nextPage(
      duration: const Duration(
        milliseconds: 750,
      ),
      curve: Curves.easeInCubic,
    );
  }

  void navigBack() {
    bordcontroller.previousPage(
      duration: const Duration(
        milliseconds: 750,
      ),
      curve: Curves.easeInCubic,
    );
  }

  var currentIndex = 0.obs;
  var isLoading = false.obs;

  // register
  Future<void> registerPhone() async {
    print('start');
    print(mobileNumberControllerSignUp.text);
    isLoading.value = true;

    try {
      final response = await HttpHelper.postData(
        endpoint: "register_phone",
        body: {
          'phone': mobileNumberControllerSignUp.text,
          'country_id': idControllerSignUp.value.text
        },
      );
      print(response.toString());
      if (response["status"] == true) {
        navigNext();
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkPhone() async {
    print('start');
    // print(mobileNumberControllerSignUpTwo.text);
    isLoading.value = true;

    try {
      final response = await HttpHelper.postData(
        endpoint: "check_phone",
        body: {
          'phone': mobileNumberControllerSignUp.text,
          'country_id': idControllerSignUp.text,
          'phone_code': controllerPin.pinController.text
        },
      );
      print(response.toString());
      if (response["status"] == true) {
        await CacheHelper.saveDataSharedPreference(
          key: "user_id",
          value: response['user_id'],
        );
        navigNext();
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> completeRegister() async {
    print('start');
    // print(mobileNumberControllerSignUpTwo.text);
    isLoading.value = true;

    try {
      var _userid = CacheHelper.getDataSharedPreference(key: 'user_id');

      final response = await HttpHelper.postData(
        endpoint: "complete_register",
        body: {
          'user_id': _userid.toString(),
          'first_name': firstNameControllerSignUpTwo.text,
          'last_name': lastNameControllerSignUpTwo.text,
          'email': emailControllerSignUp.text,
          'password': passwordControllerSignUpOne.text,
        },
      );
      print(response.toString());
      if (response["status"] == true) {
        navigNext();
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkEmail() async {
    print('start');
    isLoading.value = true;
    await initializeSharedPreferences();

    try {
      final response = await HttpHelper.postData(
        endpoint: "check_email_register",
        body: {
          'email': emailControllerSignUp.text,
          'email_code': controllerPinCheckEmail.pinController.text,
        },
      );
      print(response.toString());
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
      isLoading.value = false;
    }
  }

  // alert
  void showAlert(
      {required BuildContext context,
      required VoidCallback camera,
      required VoidCallback gallary}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose'),
          actions: <Widget>[
            TextButton(
              onPressed: camera,
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: gallary,
              child: const Text('Gallary'),
            ),
          ],
        );
      },
    );
  }
}
