import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../helper/Dark/SettingsController.dart';
import 'Styles.dart';

class Button extends StatelessWidget {
  final String textButton;
  Function function;

  Button({super.key, required this.textButton, required this.function});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return InkWell(
      onTap: () {
        function();
      },
      child: Obx(
        () => Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: settingsController.isDarkMode.value
                ? Colors.white
                : Colors.black,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
              child: Text(
            textButton,
            style: (Styles.textStyleTitle20).copyWith(
                color: settingsController.isDarkMode.value
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
