import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helper/Dark/SettingsController.dart';

class OnBordingLogoAndTitle extends StatelessWidget {
  const OnBordingLogoAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Stack(
      children: [
        Image.asset(
          'Assets/images/Logo Mbag without background.png',
          height: 220.h,
          color: settingsController.isDarkMode.value
              ? Colors.orange.shade100
              : Colors.yellow.shade700,
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.1,
            child: Text(
              "on_Boarding_Title".tr,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: settingsController.isDarkMode.value
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
