import 'package:MBAG/view/Auth_View/Login/Controller/Login_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Email_Screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: EmailScreen(controller: controller.email),
      ),
    );
  }
}