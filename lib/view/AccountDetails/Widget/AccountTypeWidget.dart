import 'package:MBAG/helper/Dark/SettingsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/widgets/Styles.dart';

class AccountTypeWidget extends StatelessWidget {
  SettingsController settingsController;
  String typeText;

  AccountTypeWidget(
      {super.key, required this.settingsController, required this.typeText});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color:
              settingsController.isDarkMode.value ? Colors.black : Colors.white,
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account Type', style: Styles.textStyleTitle12),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  typeText,
                  style: Styles.textStyleTitle14.copyWith(fontSize: 20),
                ),
              ],
            ),
            const Icon(
              Icons.keyboard_arrow_down_sharp,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
