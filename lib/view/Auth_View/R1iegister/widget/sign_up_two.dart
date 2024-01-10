import 'package:MBAG/view/Auth_View/R1iegister/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Core/widgets/custom_text_form_field.dart';
import '../../Login/Widget/HeadTitleDes.dart';

class SignUpTwo extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  SignUpTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    controller.navigBack();
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            HeadFirstTitle(title: 'Enter your information'.tr, des: ''),
            SizedBox(height: 50.h),
            CustomTextFormField(
                hintText: 'First name'.tr,
                controller: controller.firstNameControllerSignUpTwo,
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'email is  empty';
                  } else {
                    return null;
                  }
                }),
            SizedBox(height: 15.h),
            CustomTextFormField(
                hintText: 'Last name'.tr,
                controller: controller.lastNameControllerSignUpTwo,
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'email is  empty';
                  } else {
                    return null;
                  }
                }),
            SizedBox(height: 15.h),
            CustomTextFormField(
                hintText: 'Email'.tr,
                controller: controller.emailControllerSignUp,
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'email is  empty';
                  } else {
                    return null;
                  }
                }),
            SizedBox(height: 15.h),
            CustomTextFormField(
                maxLength: 6,
                hintText: 'Pin'.tr,
                controller: controller.passwordControllerSignUpOne,
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'email is  empty';
                  } else {
                    return null;
                  }
                }),
            const SizedBox(height: 16),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.agreedToTerms.value,
                    onChanged: (value) {
                      controller.changAgree(value ?? false);
                      controller.update();
                    },
                  ),
                ),
                Text('policy1'.tr),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.agreedToTerms1.value,
                    onChanged: (value) {
                      controller.changAgree1(value ?? false);
                      controller.update();
                    },
                  ),
                ),
                Text('policy2'.tr),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
