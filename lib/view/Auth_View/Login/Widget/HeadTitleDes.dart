import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../helper/Dark/SettingsController.dart';

class HeadFirstTitle extends StatelessWidget {
  final SettingsController settingsController = Get.find();

  String title;
  String des;

  HeadFirstTitle({Key? key, required this.title, required this.des})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
              title,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: settingsController.isDarkMode.value
                  ? Colors.white
                  : Colors.black),
        )),
        SizedBox(
          height: 8.h,
        ),
        Center(
            child: Text(
              des,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: settingsController.isDarkMode.value
                  ? Colors.white
                  : Colors.grey),
        )),
      ],
    );
  }
}
