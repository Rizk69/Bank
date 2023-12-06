import 'package:bank/view/Auth_View/Login/Controller/PinController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Login/Widget/HeadTitleDes.dart';
import '../../Login/Widget/PinDisplay.dart';
import '../controllers/register_controller.dart';

class SecurityCodeSignUp extends StatelessWidget {
  final PinputControllerSinUp controllerPin = Get.put(PinputControllerSinUp());

  var registerController = Get.put(RegisterController());

  SecurityCodeSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                registerController.navigBack();
              },
              icon: Icon(Icons.arrow_back)),
          HeadFirstTitle(
              title: 'Enter security code',
              des: 'Enter the 6 digital sent to phone number '),
          // Center(
          //   child: Text(
          //     registerController.emailControllerSignUpOne.text,
          //     style: Styles.textStyleTitle18.copyWith(color: Colors.grey),
          //   ),
          // ),
          SizedBox(height: 30.h),
          Center(
              child: PinputPassword(
            controller: controllerPin,
          )),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
