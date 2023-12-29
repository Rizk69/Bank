import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Controller/ControllerFastLogin.dart';
import '../Controller/PinController.dart';
import '../Widget/ButtomsNotBorder.dart';
import '../Widget/HeadTitleDes.dart';
import '../Widget/PinDisplay.dart';

class FastLogin extends StatelessWidget {
  final FastLoginController controller = Get.put(FastLoginController());
  final PinputControllerFastLoginCheckEmail controllerPin =
      Get.put(PinputControllerFastLoginCheckEmail());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FastLogin({super.key}); // Initialized formKey

  RxBool get isFormValid => RxBool(formKey.currentState?.validate() ?? true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100.h,
          ),
          HeadFirstTitle(
            title: 'Fast Login',
            des: 'Log in with Password ',
          ),
          SizedBox(
            height: 60.h,
          ),
          Center(
            child: PinputPassword(
              controller: controllerPin,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 30, right: 30),
            child: ButtomsNotBorder(
              text: 'Continue',
              color: Colors.black,
              onPressed: () {
                String pin = controllerPin.pinController.text;
                controller.checkPassword(password: pin, context: context);
              },
              colorText: Colors.white,
              isFormValid: isFormValid,
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
