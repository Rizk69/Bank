import 'package:flutter/material.dart';
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
          height: 200,
          color: settingsController.isDarkMode.value
              ? Colors.orange.shade100
              : Colors.yellow.shade700,
        ),
        Positioned(
          bottom: 0,
          child: Text(
            'Send money for free, at \n\t\t\t\t\t\t lightning speed.',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: settingsController.isDarkMode.value
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ],
    );
  }
}
