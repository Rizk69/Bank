import 'package:bank/view/Auth_View/Login/Widget/HeadTitleDes.dart';
import 'package:bank/view/Auth_View/Login/Widget/PinDisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Core/widgets/custom_text_form_field.dart';
import '../../controllers/register_controller.dart';

class SignUpOne extends StatelessWidget {
  SignUpOne({super.key});

  var registerController = Get.put(RegisterController());
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadFirstTitle(
              title: 'Sign up',
              des: 'Sign up with email address or phone number '),
          SizedBox(height: 30.h),
          CustomTextFormField(
              hintText: 'Enter phone number ',
              prefix: const Icon(Icons.email, color: Colors.black),
              textInputType: TextInputType.emailAddress,
              controller: registerController.emailControllerSignUpOne,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'email is  empty';
                } else {
                  return null;
                }
              }),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
//Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SizedBox(
//             height: 70.h,
//           ),
//           Center(
//               child: Text(
//                 'Log in',
//                 style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//               )),
//           SizedBox(
//             height: 8.h,
//           ),
//           Center(
//               child: Text(
//                 'Log in with email address or phone number ',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey),
//               )),
//           SizedBox(
//             height: 30.h,
//           ),
//           TextFormField(
//             controller: controller,
//             keyboardType: TextInputType.emailAddress,
//             validator: (value) {
//               // Validate email or phone number
//               if (value == null || value.isEmpty) {
//                 return 'Please enter a valid email or phone number';
//               }
//               // You can add more specific validation if needed
//               return null;
//             },
//             decoration: InputDecoration(
//               labelText: 'Email address or phone number',
//               focusColor: Colors.grey,
//               focusedBorder: InputBorder.none,
//               hintText: '',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//           Spacer(),
//           Center(
//               child: Text(
//                 'Having a trouble ? ',
//                 style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black),
//               )),
//           SizedBox(
//             height: 27.h,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 25),
//             child: ButtomsNotBorder(
//               text: 'Countinue',
//               color: Color(0XFFD9D9D9),
//               onPressed: () {
//                 // if (formKey.currentState?.validate() ?? false) {
//                   // Only submit if the form is valid
//                    Get.to(PasswordScreen(emailController: controller,));
//
//               },
//               colorText: Colors.white,
//             ),
//           ),
//         ],
//       )
// Text(
//   'password',
//   style: Styles.textStyleTitle18,
// ),
// SizedBox(height: 10.h),
// CustomTextFormField(
//   hintText: '************',
//   controller: registerController.passwordControllerSignUpOne,
//   textInputType: TextInputType.number,
//   maxLength: 6,
//   validator: (value) {
//     if (value!.isEmpty) {
//       return 'Password is to short';
//     } else {
//       return null;
//     }
//   },
//   prefix: Icon(Icons.lock_outline, color: Color(0xffC19843)),
// ),
// Text(
//   'Confirm password',
//   style: Styles.textStyleTitle18,
// ),
// SizedBox(height: 5.h),
// CustomTextFormField(
//   hintText: '************',
//   controller: registerController.passwordConfirmControllerSignUpOne,
//   textInputType: TextInputType.number,
//   maxLength: 6,
//   validator: (value) {
//     if (value!.isEmpty) {
//       return 'Password is to short';
//     } else {
//       return null;
//     }
//   },
//   prefix: const Icon(Icons.lock_outline, color: Color(0xffC19843)),
// ),
