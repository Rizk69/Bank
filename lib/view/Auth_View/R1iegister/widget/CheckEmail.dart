import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Login/Controller/PinController.dart';
import '../../Login/Widget/HeadTitleDes.dart';
import '../../Login/Widget/PinDisplay.dart';
import '../controllers/register_controller.dart';

class CheckEmail extends StatelessWidget {
  CheckEmail({Key? key}) : super(key: key);
  PinputControllerSinUpCheckEmail controllerSinUpCheckEmail =
      Get.put(PinputControllerSinUpCheckEmail());
  var registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              registerController.navigBack();
            },
            icon: Icon(Icons.arrow_back)),
        HeadFirstTitle(
            title: 'Check your Email ',
            des:
                'Check your email address and enter the \nverification code we had sent'),
        // Center(
        //   child: Text(
        //     registerController.emailControllerSignUpOne.text,
        //     style: Styles.textStyleTitle18.copyWith(color: Colors.grey),
        //   ),
        // ),
        SizedBox(height: 30.h),
        Center(
            child: PinputPassword(
          controller: controllerSinUpCheckEmail,
        )),
        SizedBox(height: 2.h),
      ],
    );
  }
}
