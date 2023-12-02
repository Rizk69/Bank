import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_country_picker_nm/flutter_country_picker_nm.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Core/widgets/Button.dart';
import '../../../../../Core/widgets/Styles.dart';
import '../../../../../Core/widgets/custom_text_form_field.dart';
import '../../controllers/register_controller.dart';
import '../../cubit/register_cubit.dart';
import '../../cubit/register_state.dart';

class SignUpTwo extends StatefulWidget {
  SignUpTwo({super.key});

  @override
  State<SignUpTwo> createState() => _SignUpTwoState();
}

class _SignUpTwoState extends State<SignUpTwo> {
  var registerController = Get.put(RegisterController());

  var formKey = GlobalKey<FormState>();
  Country? _selected;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Personal Information',
                  style: Styles.textStyleTitle18,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                          hintText: 'First Name',
                          textInputType: TextInputType.name,
                          maxLength: 10,
                          controller:
                              registerController.firstNameControllerSignUpTwo,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name Required';
                            } else {
                              return null;
                            }
                          }),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      child: CustomTextFormField(
                          hintText: 'Last Name',
                          textInputType: TextInputType.name,
                          maxLength: 10,
                          controller:
                              registerController.lastNameControllerSignUpTwo,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name Required';
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ],
                ),
                Text(
                  'Cart Id',
                  style: Styles.textStyleTitle18,
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  hintText: '**************',
                  controller: registerController.idNumberControllerSignUpTwo,
                  textInputType: TextInputType.number,
                  maxLength: 11,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Id Number Required ';
                    } else {
                      return null;
                    }
                  },
                ),
                Text(
                  'Phone',
                  style: Styles.textStyleTitle18,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CountryPicker(
                        dense: false,
                        showFlag: true,
                        showCurrency: false,
                        showName: false,
                        showDialingCode: true,
                        onChanged: (Country country) {
                          setState(() {
                            _selected = country;
                            registerController.selected = country;
                          });
                        },
                        selectedCountry: _selected,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: CustomTextFormField(
                        hintText: '+90 (800) xxx-xxxx',
                        maxLength: 11,
                        controller:
                            registerController.mobileNumberControllerSignUpTwo,
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Id Number Required ';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 20.h),
                // Obx(
                //   () => registerController.currentIndex.value < 3
                //       ? Button(
                //           textButton: "Skip",
                //           function: () {
                //             if (formKey.currentState!.validate()) {
                //               registerController.navig();
                //             }
                //           },
                //         )
                //       : const SizedBox.shrink(),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
