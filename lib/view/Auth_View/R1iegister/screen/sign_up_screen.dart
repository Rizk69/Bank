import 'package:bank/Core/cache_helper.dart';
import 'package:bank/view/Auth_View/Login/Screen/Login_Screen.dart';
import 'package:bank/view/Auth_View/R1iegister/screen/widget/SignUpPassword.dart';
import 'package:bank/view/Auth_View/R1iegister/screen/widget/sign_up_four.dart';
import 'package:bank/view/Auth_View/R1iegister/screen/widget/sign_up_one.dart';
import 'package:bank/view/Auth_View/R1iegister/screen/widget/sign_up_three.dart';
import 'package:bank/view/Auth_View/R1iegister/screen/widget/sign_up_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../Core/widgets/Button.dart';
import '../../../../Core/widgets/Navigation/navigation.dart';
import '../../../../Core/widgets/Styles.dart';
import '../controllers/register_controller.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

List<Widget> screenRegister = [
  SignUpOne(),
  PasswordSignUp(),
  SignUpTwo(),
  SignUpThree(),
  SignUpFour(),
];

class SignUpScreen extends StatelessWidget {
  var registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/img_constraction.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80.h,
                        ),
                        SizedBox(
                          height: 600.h,
                          child: PageView.builder(
                            onPageChanged: (int index) {
                              registerController.currentIndex.value = index;
                              BlocProvider.of<RegisterCubit>(context)
                                  .ChangeIndex(
                                      BlocProvider.of<RegisterCubit>(context)
                                          .index);
                            },
                            controller: registerController.bordcontroller,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                screenRegister[index],
                            itemCount: screenRegister.length,
                          ),
                        ),
                        Obx(
                          () => registerController.currentIndex.value == 3
                              ? registerController.isLoading.value
                                  ? Center(
                                      child: Lottie.asset(
                                          "assets/images/bg_payment.json",
                                          height: 100.h),
                                    )
                                  : Button(
                                      textButton: "Done",
                                      function: () {
                                        if (BlocProvider.of<RegisterCubit>(
                                                    context)
                                                .Image ==
                                            null) {
                                          Get.snackbar("Warning!",
                                              "Please Take Your Image");
                                        } else {
                                          CacheHelper.saveDataSharedPreference(
                                              key: 'email',
                                              value: registerController
                                                  .emailControllerSignUpOne
                                                  .text);
                                          CacheHelper.saveDataSharedPreference(
                                              key: 'phone',
                                              value: registerController
                                                  .mobileNumberControllerSignUpTwo
                                                  .text);
                                          registerController.register(
                                            email: registerController
                                                .emailControllerSignUpOne.text,
                                            password: registerController
                                                .passwordControllerSignUpOne
                                                .text,
                                            password_confirmation:
                                                registerController
                                                    .passwordConfirmControllerSignUpOne
                                                    .text,
                                            first_name: registerController
                                                .firstNameControllerSignUpTwo
                                                .text,
                                            last_name: registerController
                                                .lastNameControllerSignUpTwo
                                                .text,
                                            id_number: registerController
                                                .idNumberControllerSignUpTwo
                                                .text,
                                            country_id: "1",
                                            phone: registerController
                                                .mobileNumberControllerSignUpTwo
                                                .text,
                                            img: BlocProvider.of<RegisterCubit>(
                                                    context)
                                                .FrontId!,
                                            frout_id:
                                                BlocProvider.of<RegisterCubit>(
                                                        context)
                                                    .BackId!,
                                            back_id:
                                                BlocProvider.of<RegisterCubit>(
                                                        context)
                                                    .FrontId!,
                                            context: context,
                                          );
                                        }
                                      },
                                    )
                              : const SizedBox.shrink(),
                        ),
                        Column(
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
                                      function: () {
                                        registerController.navig();
                                      },
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
