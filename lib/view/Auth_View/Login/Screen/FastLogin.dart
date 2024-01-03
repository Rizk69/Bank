import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../helper/Dark/SettingsController.dart';
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

  FastLogin({super.key});

  RxBool get isFormValid => RxBool(formKey.currentState?.validate() ?? true);

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
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
                padding: const EdgeInsets.only(
                  bottom: 25,
                ),
                child: ButtomsNotBorder(
                  text: 'Continue',
                  color: settingsController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                  onPressed: () {
                    String pin = controllerPin.pinController.text;
                    controller.checkPassword(password: pin, context: context);
                  },
                  colorText: settingsController.isDarkMode.value
                      ? Colors.black
                      : Colors.white,
                  isFormValid: isFormValid,
                  context: context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
