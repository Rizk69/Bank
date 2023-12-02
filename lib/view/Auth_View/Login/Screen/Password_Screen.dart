import 'package:bank/view/Auth_View/Login/Controller/Login_Controller.dart';
import 'package:bank/view/Auth_View/Login/Controller/PinController.dart';
import 'package:bank/view/Auth_View/Login/Widget/ButtomsNotBorder.dart';
import 'package:bank/view/Auth_View/Login/Widget/PinDisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PasswordScreen extends StatelessWidget {
  final PinputController controllerPin = Get.put(PinputController());
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController;
  final LoginController controller = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PasswordScreen({Key? key, required this.emailController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 70.h),
            Center(
              child: Text(
                'Enter your 6 digital ',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Text(
                'PIN',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            PinputPassword(),
            Spacer(),
            Center(
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
                color: Color(0XFFD9D9D9),
                onPressed: () {
                  String pin = controllerPin.pinController.text;
                  String email = emailController.text;
                  controller.signIn(
                      phone: email, password: pin, context: context);
                },
                colorText: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
