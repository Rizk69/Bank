import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helper/Dark/SettingsController.dart';
import '../Controller/TraderController.dart';

class TermsUserScreen extends StatelessWidget {
  TermsUserScreen({Key? key}) : super(key: key);
  final TermsController termsController = Get.put(TermsController());

  @override
  Widget build(BuildContext context) {
    termsController.getTermsData();

    final SettingsController settingsController = Get.find();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 10,
                ),
                Text(
                  'Terms & conditions',
                  style: Styles.textStyleTitle24,
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text('Please read this terms&conditions carefully',
                style: Styles.textStyleTitle14.copyWith(
                    color: settingsController.isDarkMode.value
                        ? Colors.white
                        : Color(0XFF6A6969),
                    fontWeight: FontWeight.w400)),
            Text('before pressing Agree ',
                style: Styles.textStyleTitle14.copyWith(
                    color: settingsController.isDarkMode.value
                        ? Colors.white
                        : Color(0XFF6A6969),
                    fontWeight: FontWeight.w400)),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: Obx(
                () => Text(termsController.terms.value ?? '',
                    style: Styles.textStyleTitle18.copyWith(
                        color: settingsController.isDarkMode.value
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w400)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
