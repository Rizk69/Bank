import 'package:MBAG/view/Auth_View/Login/Controller/PinController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Login/Controller/TimerController.dart';
import '../../Login/Widget/HeadTitleDes.dart';
import '../../Login/Widget/PinDisplay.dart';
import '../controllers/register_controller.dart';

class SecurityCodeSignUp extends StatelessWidget {
  final PinputControllerSinUp controllerPin = Get.put(PinputControllerSinUp());

  RegisterController registerController = Get.find();

  SecurityCodeSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyTimerControllerRegisterPhoneorEmail controllerTimer =
        Get.put(MyTimerControllerRegisterPhoneorEmail());
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                registerController.navigBack();
              },
              icon: Icon(Icons.arrow_back)),
          HeadFirstTitle(
              title: 'Enter security code'.tr,
              des: 'Enter the 6 digits sent to phone number '.tr),
          // Center(
          //   child: Text(
          //     registerController.emailControllerSignUpOne.text,
          //     style: Styles.textStyleTitle18.copyWith(color: Colors.grey),
          //   ),
          // ),
          SizedBox(height: 30.h),
          Center(
              child: PinputPassword(
            controller: controllerPin,
          )),
          SizedBox(height: 30.h),
          Obx(() => Center(
              child: Text(
                  'resend_code'
                      .trArgs([controllerTimer.counter.value.toString()]),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF6A6969))))),
        ],
      ),
    );
  }
}
