import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:MBAG/view/Auth_View/Login/Controller/Login_Controller.dart';
import 'package:MBAG/view/Auth_View/Login/Controller/PinController.dart';
import 'package:MBAG/view/Auth_View/Login/Widget/ButtomsNotBorder.dart';
import 'package:MBAG/view/Auth_View/Login/Widget/PinDisplay.dart';

import '../../../../helper/Dark/SettingsController.dart';

class PasswordScreen extends StatelessWidget {
  final PinputControllerLogin controllerPin = Get.put(PinputControllerLogin());
  final LoginController controller = Get.put(LoginController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 70.h),
              Center(
                child: Text(
                  'Enter your 6 digital'.tr,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: settingsController.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  'PIN'.tr,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: settingsController.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              PinputPassword(controller: controllerPin),
              const Spacer(),
              Center(
                child: Text(
                  'Having trouble?'.tr,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 27.h),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: ButtomsNotBorder(
                  text: 'Continue'.tr,
                  color: settingsController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                  onPressed: () {
                    String pin = controllerPin.pinController.text;
                    controller.checkPassword(context: context, password: pin);
                  },
                  colorText: settingsController.isDarkMode.value
                      ? Colors.black
                      : Colors.white,
                  isFormValid: controller.isFormValid,
                  context: context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}