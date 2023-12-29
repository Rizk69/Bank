import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:MBAG/view/Auth_View/Login/Widget/HeadTitleDes.dart';
import 'package:MBAG/view/Auth_View/R1iegister/widget/CustomPicker.dart';
import '../../../../../Core/widgets/custom_text_form_field.dart';
import '../controllers/CountryController.dart';
import '../controllers/register_controller.dart';

class SignUpOne extends StatelessWidget {
  SignUpOne({Key? key}) : super(key: key);

  final CountryController _countryController = Get.put(CountryController());
  final RegisterController registerController = Get.put(RegisterController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Initiate the country loading when the widget is built
    _countryController.getCountry();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadFirstTitle(
          title: 'Sign up',
          des: 'Sign up with email address or phone number',
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
                    List<String> countryCodes = _countryController
                        .countryModel.country
                        .map((country) => country.code)
                        .toList();
                    List<String> countryNames = _countryController
                        .countryModel.country
                        .map((country) => country.name)
                        .toList();
                    List<String> countryImages = _countryController
                        .countryModel.country
                        .map((country) => country.img)
                        .toList();

                    return CustomListPickerField(
                      label: "Country",
                      isRequired: true,
                      itemsCode: countryCodes,
                      itemsImage: countryImages,
                      // Updated to countryImages
                      itemsName: countryNames,
                      onChanged: (value) {
                        final selectedCountry = _countryController
                            .countryModel.country
                            .firstWhere((country) => country.code == value);
                        registerController.idControllerSignUp.text =
                            selectedCountry.id.toString();
                        print("Selected Country ID: ${selectedCountry.id}");
                      },
                    );
                  } else {
                    return SizedBox
                        .shrink(); // Use SizedBox.shrink for a more appropriate placeholder
                  }
                },
              ),
            ),
            Expanded(
              flex: 4,
              child: CustomTextFormField(
                maxLength: 11,
                hintText: 'Enter phone number',
                prefix: const Icon(Icons.phone_outlined, color: Colors.black),
                textInputType: TextInputType.phone,
                controller: registerController.mobileNumberControllerSignUp,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone number is empty'; // Updated the validation message
                  }
                  return null;
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
