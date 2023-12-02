import 'package:bank/Core/widgets/Button.dart';
import 'package:bank/Core/widgets/Navigation/navigation.dart';
import 'package:bank/view/Auth_View/Login/Screen/Login_Screen.dart';
import 'package:bank/view/Auth_View/R1iegister/controllers/confirm_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../Core/widgets/Styles.dart';
import '../../../../Core/widgets/custom_text_form_field.dart';

class ConfirmEmailScreen extends StatelessWidget {
  ConfirmEmailScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var confirmController = Get.put(ConfirmController());
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/imagess/img_constraction.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Stack(
                children: [
                  // const MyAnimatedBackground(
                  //     path1: "assets/images/img_inner_60_146x149.png",
                  //     path2: "assets/images/img_inner_60_155x156.png"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .10),
                      // customHeadScreen(),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Phone Verification',
                          style: Styles.textStyleTitle20,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Code',
                        style: Styles.textStyleTitle14,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                          hintText: 'xxxxxx',
                          prefix:
                              const Icon(Icons.code, color: Color(0xffC19843)),
                          textInputType: TextInputType.text,
                          controller: codeController,
                          maxLength: 6,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Code is  empty';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(height: 20.h),
                      Obx(
                        () => confirmController.isLoading.value
                            ? Center(
                                child: Lottie.asset(
                                    "assets/images/bg_payment.json",
                                    height: 100.h),
                              )
                            : Button(
                                textButton: 'Confirm Phone',
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    confirmController.confirmSMS(
                                        code: codeController.text,
                                        context: context);
                                  }
                                },
                              ),
                      ),
                      SizedBox(height: 10.h),
                      Obx(
                        () => confirmController.isLoadingResend.value
                            ? Center(
                                child: Lottie.asset(
                                    "assets/images/bg_payment.json",
                                    height: 100.h),
                              )
                            : Button(
                                textButton: 'Resend Code',
                                function: () {
                                  confirmController.resendSMSCode();
                                },
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: Styles.textStyleTitle18,
                          ),
                          TextButton(
                            onPressed: () {
                              navigatofinsh(context, LoginScreen(), false);
                            },
                            child: Text('Sign In',
                                style: Styles.textStyleTitle20
                                    .copyWith(color: Color(0xffEEBB49))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
