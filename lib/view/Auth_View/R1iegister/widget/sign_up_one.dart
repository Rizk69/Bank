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
    _countryController.getCountry();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadFirstTitle(
          title: 'Sign up',
          des: 'Sign up with email address or phone number',
        ),
        SizedBox(height: 30.h),
        FutureBuilder(
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

              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomListPickerField(
                      label: "Country",
                      isRequired: true,
                      itemsCode: countryCodes,
                      itemsImage: countryImages,
                      itemsName: countryNames,
                      onChanged: (value) {
                        final selectedCountry = _countryController
                            .countryModel.country
                            .firstWhere((country) => country.code == value);
                        _countryController.selectCountry(selectedCountry);
                        registerController.idControllerSignUp.text =
                            selectedCountry.id.toString();
                        print("Selected Country ID: ${selectedCountry.id}");
                      },
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Obx(() {
                      var selectedCountryId =
                          _countryController.selectedCountry.value?.id;

                      var maxLength = 11;

                      if (selectedCountryId != null &&
                          selectedCountryId >= 0 &&
                          selectedCountryId <
                              _countryController.countryModel.country.length) {
                        maxLength = _countryController
                            .countryModel.country[selectedCountryId - 1].count;
                      }

                      return CustomTextFormField(
                        maxLength: maxLength,
                        hintText: 'Enter phone number',
                        prefix: const Icon(Icons.phone_outlined,
                            color: Colors.black),
                        textInputType: TextInputType.phone,
                        controller:
                            registerController.mobileNumberControllerSignUp,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone number is empty'; // Updated the validation message
                          }
                          return null;
                        },
                      );
                    }),
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
