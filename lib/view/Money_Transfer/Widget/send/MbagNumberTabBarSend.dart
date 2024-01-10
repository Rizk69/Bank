import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/Core/widgets/custom_text_form_field.dart';
import 'package:MBAG/helper/Dark/SettingsController.dart';
import 'package:MBAG/view/Money_Transfer/Controller/MbagNumberController.dart';
import 'package:MBAG/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MbagNumberTabBar extends StatelessWidget {
  MbagNumberTabBar({Key? key}) : super(key: key);
  MbagNumberController controller = Get.put(MbagNumberController());

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.find();

    return SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height / 1.4,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(1),
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            'MBAG number',
                            style: Styles.textStyleTitle20.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  textInputType: TextInputType.number,
                  hintText: 'MBAG NUMBER / IBAN ',
                  controller: controller.mbagNumberController,
                ),
                Spacer(),
                // Use FutureBuilder to handle loading state
                Buttoms(
                  text: 'Continue',
                  color: settingsController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                  onPressed: () async {
                    controller.mbagNumberController.isNull
                        ? Get.snackbar('', 'Please Enter Mbag Number',
                            backgroundColor: Colors.red)
                        : await controller.getMbagNumberClient();
                  },
                  colorText: settingsController.isDarkMode.value
                      ? Colors.black
                      : Colors.white,
                )
              ],
            )));
  }
}
