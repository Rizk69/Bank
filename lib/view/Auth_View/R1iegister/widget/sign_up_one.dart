import 'package:MBAG/view/Auth_View/Login/Widget/HeadTitleDes.dart';
import 'package:MBAG/view/Auth_View/R1iegister/widget/CustomPicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Core/widgets/custom_text_form_field.dart';
import '../controllers/CountryController.dart';
import '../controllers/register_controller.dart';

class SignUpOne extends StatelessWidget {
  SignUpOne({Key? key});

  final CountryController _countryController = Get.put(CountryController());
  var registerController = Get.put(RegisterController());
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _countryController.getCountry();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadFirstTitle(
          title: 'Sign up',
          des: 'Sign up with email address or phone number ',
        ),
        SizedBox(height: 30.h),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: FutureBuilder(
                future: _countryController.getCountry(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Extracting only country codes as strings
                    List<String> countryCodes = _countryController
                        .countryModel.country
                        .map((country) => "${country.code}")
                        .toList();

                    return CustomListPickerField(
                      label: "Country",
                      isRequired: true,
                      items: countryCodes,
                      onChanged: (value) {
                        final selectedCountry =
                            _countryController.countryModel.country.firstWhere(
                          (country) => "${country.code}" == value,
                        );
                        registerController.idControllerSignUp.text =
                            selectedCountry.id.toString();

                        print(registerController.idControllerSignUp);

                        print("Selected Country ID: ${selectedCountry.id}");
                      },
                    );
                  } else {
                    return SizedBox.fromSize();
                  }
                },
              ),
            ),
            Expanded(
              flex: 4,
              child: CustomTextFormField(
                maxLength: 20,
                hintText: 'Enter phone number ',
                prefix: const Icon(Icons.phone_outlined, color: Colors.black),
                textInputType: TextInputType.phone,
                controller: registerController.mobileNumberControllerSignUp,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'email is  empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
