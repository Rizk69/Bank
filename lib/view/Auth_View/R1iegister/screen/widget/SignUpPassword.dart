import 'package:bank/Core/widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Login/Widget/HeadTitleDes.dart';
import '../../../Login/Widget/PinDisplay.dart';
import '../../controllers/register_controller.dart';

class PasswordSignUp extends StatelessWidget {
  var registerController = Get.put(RegisterController());
  var formKey = GlobalKey<FormState>();

  PasswordSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadFirstTitle(
              title: 'Enter security code',
              des: 'Enter the 6 digital sent to phone number '),
          Text(
            registerController.emailControllerSignUpOne.text,
            style: Styles.textStyleTitle18.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 30.h),
          Center(child: PinputPassword()),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}