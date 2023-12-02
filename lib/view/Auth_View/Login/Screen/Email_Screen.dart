import 'package:bank/view/Auth_View/Login/Screen/Password_Screen.dart';
import 'package:bank/view/Auth_View/Login/Widget/ButtomsNotBorder.dart';
import 'package:bank/view/Auth_View/Login/Widget/HeadTitleDes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmailScreen extends StatelessWidget {
  TextEditingController controller;
  GlobalKey<FormState> formKey;
  bool empty = true;

  EmailScreen({super.key, required this.controller, required this.formKey});

  get isFormValid => formKey.currentState?.validate() ?? true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 70.h,
          ),
          HeadFirstTitle(
              title: 'Log in',
              des: 'Log in with email address or phone number '),
          SizedBox(
            height: 30.h,
          ),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.phone,
            validator: (value) {
              // Validate email or phone number
              if (value == null || value.isEmpty) {
                return 'Please enter a valid email or phone number';
              }
              // You can add more specific validation if needed
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
          Spacer(),
          Center(
              child: Text(
            'Having a trouble ? ',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
          )),
          SizedBox(
            height: 27.h,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: ButtomsNotBorder(
              text: 'Countinue',
              color: isFormValid ? Color(0XFFD9D9D9) : Colors.lightBlueAccent,
              onPressed: () {
                // if (formKey.currentState?.validate() ?? false) {
                // Only submit if the form is valid
                Get.to(PasswordScreen(
                  emailController: controller,
                ));
              },
              colorText: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
