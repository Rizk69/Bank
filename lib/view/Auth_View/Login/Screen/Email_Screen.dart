import 'package:MBAG/view/Auth_View/Login/Controller/Login_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../helper/Dark/SettingsController.dart';
import '../Widget/ButtomsNotBorder.dart';
import '../Widget/HeadTitleDes.dart';

class EmailScreen extends StatelessWidget {
  final TextEditingController controller;
  final LoginController controllerLogin = Get.put(LoginController());

  EmailScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 70.h),
        HeadFirstTitle(
            title: 'Log in', des: 'Log in with email address or phone number '),
        SizedBox(height: 30.h),
        TextFormField(
          controller: controller,
          onChanged: (value) {
            value = controller.text;
          },
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid email or phone number';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: 'Email address or phone number',
            focusColor: Colors.grey,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 2.0,
              ),
            ),
            hintText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const Spacer(),
        const Center(
          child: Text(
            'Having trouble? ',
            style: TextStyle(
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
            text: 'Continue',
            color: settingsController.isDarkMode.value
                ? Colors.white
                : Colors.black,
            onPressed: () {
              print('Email Text: ${controllerLogin.email.text}');
              if (controllerLogin.email.text.isNotEmpty) {
                controllerLogin.checkEmail(
                  phone: controllerLogin.email.text,
                  context: context,
                );
              }
            },
            colorText: settingsController.isDarkMode.value
                ? Colors.black
                : Colors.white,
            isFormValid: controllerLogin.isFormValid,
            context: context,
          ),
        ),
      ],
    );
  }
}
