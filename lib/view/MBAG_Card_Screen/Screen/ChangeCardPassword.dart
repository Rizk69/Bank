import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Auth_View/Login/Controller/PinController.dart';
import '../../Auth_View/Login/Widget/ButtomsNotBorder.dart';
import '../../Auth_View/Login/Widget/HeadTitleDes.dart';
import '../../Auth_View/Login/Widget/PinDisplay.dart';

class ChangeCardPassword extends StatelessWidget {
  final PinputControllerChangeCardPassword controllerPin =
      Get.put(PinputControllerChangeCardPassword());
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // Initialized formKey

  RxBool get isFormValid => RxBool(formKey.currentState?.validate() ?? true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 80.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                )),
          ),
          SizedBox(
            height: 20.h,
          ),
          HeadFirstTitle(
            title: 'Change Card Password',
            des: 'Please enter the password you want to use on ',
          ),
          Center(
              child: Text(
            'your card',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
          )),
          SizedBox(
            height: 60.h,
          ),
          Center(
            child: PinputPassword(
              controller: controllerPin,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 30, right: 30),
            child: ButtomsNotBorder(
              text: 'Continue',
              color: Color(0XFFD9D9D9),
              onPressed: () {
                String pin = controllerPin.pinController.text;
                print(pin);
              },
              colorText: Colors.white,
              isFormValid: isFormValid,
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
