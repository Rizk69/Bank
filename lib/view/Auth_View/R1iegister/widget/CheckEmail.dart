import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../helper/Dark/SettingsController.dart';
import '../../Login/Controller/PinController.dart';
import '../../Login/Controller/TimerController.dart';
import '../../Login/Widget/HeadTitleDes.dart';
import '../../Login/Widget/PinDisplay.dart';
import '../controllers/register_controller.dart';

class CheckEmail extends StatelessWidget {
  CheckEmail({Key? key}) : super(key: key);
  PinputControllerSinUpCheckEmail controllerSinUpCheckEmail =
      Get.put(PinputControllerSinUpCheckEmail());
  var registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();
    final MyTimerControllerRegisterEmail controllerTimer =
        Get.put(MyTimerControllerRegisterEmail());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              registerController.navigBack();
            },
            icon: Icon(Icons.arrow_back)),
        Center(
          child: HeadFirstTitle(
              title: 'Check your Email ',
              des: 'Check your email address and enter the '),
        ),
        Center(
          child: Text(
            "verification code we had sent",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: settingsController.isDarkMode.value
                    ? Colors.white
                    : Colors.grey),
          ),
        ),
        SizedBox(height: 30.h),
        Center(
            child: PinputPassword(
          controller: controllerSinUpCheckEmail,
        )),
        SizedBox(height: 30.h),
        Obx(() => Center(
            child: Text(
                'Resend a code after ${controllerTimer.counter.value} s',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF6A6969))))),
      ],
    );
  }
}
