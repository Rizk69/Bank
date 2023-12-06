import 'package:bank/view/Auth_View/Login/Controller/Login_Controller.dart';
import 'package:bank/view/Auth_View/Login/Controller/PinController.dart';
import 'package:bank/view/Auth_View/Login/Controller/TimerController.dart';
import 'package:bank/view/Auth_View/Login/Widget/ButtomsNotBorder.dart';
import 'package:bank/view/Auth_View/Login/Widget/PinDisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SecurityCodeScreen extends StatelessWidget {
  TextEditingController email;
  final PinputControllerSinInCheckEmail controllerPin =
      Get.put(PinputControllerSinInCheckEmail());
  final LoginController controller = Get.put(LoginController());
  final MyTimerController controllerTimer = Get.put(MyTimerController());

  SecurityCodeScreen({Key? key, required this.email}) : super(key: key);

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
                'Enter security code',
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
                'Enter the 6 digital sent to phone number ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFF6A6969),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Text(
                email.text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFF6A6969),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            PinputPassword(
              controller: controllerPin,
            ),
            SizedBox(height: 30.h),
            Obx(() => Center(
                child: controllerTimer.isCodeVisible.value
                    ? Text(
                        'Resend a code after ${controllerTimer.counter.value} s',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF6A6969)))
                    : Container())),
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

                  controller.checkCodeEmail(context: context, code: pin);
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
