import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Core/widgets/Button.dart';
import '../../../../Core/widgets/Styles.dart';
import '../controllers/register_controller.dart';
import '../widget/CheckEmail.dart';
import '../widget/SecurityCode.dart';
import '../widget/sign_up_one.dart';
import '../widget/sign_up_two.dart';

List<Widget> screenRegister = [
  SignUpOne(),
  SecurityCodeSignUp(),
  SignUpTwo(),
  CheckEmail()
];

class SignUpScreen extends StatelessWidget {
  var registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  SizedBox(
                    height: 600.h,
                    child: PageView.builder(
                      onPageChanged: (int index) {
                        registerController.currentIndex.value = index;
                      },
                      controller: registerController.bordcontroller,
                      physics: NeverScrollableScrollPhysics(),
                      // NeverScrollableScrollPhysics(), // Use PageScrollPhysics for snapping effect
                      itemBuilder: (context, index) => screenRegister[index],
                      itemCount: screenRegister.length,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Having a trouble ? ',
                          style: Styles.textStyleTitle18,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Obx(
                          () => registerController.currentIndex.value < 4
                              ? Button(
                                  textButton: "Continue",
                                  function: () async {
                                    if (registerController.currentIndex.value ==
                                        0) {
                                      await registerController.registerPhone();
                                    }
                                    if (registerController.currentIndex.value ==
                                        1) {
                                      await registerController.checkPhone();
                                    }
                                    if (registerController.currentIndex.value ==
                                        2) {
                                      await registerController
                                          .completeRegister();
                                    }
                                    if (registerController.currentIndex.value ==
                                        3) {
                                      await registerController.checkEmail();
                                    }
                                  },
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
