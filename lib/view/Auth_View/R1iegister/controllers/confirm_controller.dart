// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mbag/MBAG/Core/cache_helper.dart';
// import 'package:mbag/MBAG/Core/http_helper.dart';
// import 'package:mbag/MBAG/Core/widgets/Navigation/navigation.dart';
// import 'package:mbag/MBAG/Presentation/sign_in/screens/sign_in_screen.dart';
//
// class ConfirmController extends GetxController {
//   // confirm email
//   var isLoading = false.obs;
//   void confirmEmail(
//       {required String code, required BuildContext context}) async {
//     try {
//       isLoading.value = true;
//       var email = CacheHelper.getDataFromSharedPreference(key: 'email');
//       final response = await HttpHelper.postData(
//         endpoint: "check_email_user",
//         body: {
//           'email': email,
//           'email_code': code,
//         },
//       );
//       if (response['status'] == true) {
//         CacheHelper.removeData(key: 'email');
//         Get.snackbar("Success!", response['message'],
//             backgroundColor: Colors.blue);
//         navigatofinsh(context, SignINScreen(), false);
//       } else {
//         Get.snackbar("Warning!", response['message']);
//       }
//       isLoading.value = false;
//     } catch (error) {
//       isLoading.value = false;
//       print(error);
//     }
//   }
//
//   // resend code
//   var isLoadingResend=false.obs;
//   void resendCode() async {
//     try {
//       isLoadingResend.value = true;
//       var email = CacheHelper.getDataFromSharedPreference(key: 'email');
//       final response = await HttpHelper.postData(
//         endpoint: "resend_email_user",
//         body: {
//           'email': email,
//         },
//       );
//       if (response['status'] == true) {
//         Get.snackbar("Success!", response['message'],
//             backgroundColor: Colors.blue);
//       } else {
//         Get.snackbar("Warning!", response['message']);
//       }
//       isLoadingResend.value = false;
//     } catch (error) {
//       isLoadingResend.value = false;
//
//       print(error);
//     }
//   }
// }
import 'package:bank/Core/cache_helper.dart';
import 'package:bank/Core/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmController extends GetxController {
  // confirm email
  var isLoading = false.obs;

  void confirmEmail(
      {required String code, required BuildContext context}) async {
    try {
      isLoading.value = true;
      var email = CacheHelper.getDataSharedPreference(key: 'email');
      final response = await HttpHelper.postData(
        endpoint: "check_email_user",
        body: {
          'email': email,
          'email_code': code,
        },
      );
      if (response['status'] == true) {
        CacheHelper.removeData(key: 'email');
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
        // navigatofinsh(context, SignINScreen(), false);
      } else {
        Get.snackbar("Warning!", response['message']);
      }
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      print(error);
    }
  }

  // resend code
  var isLoadingResend = false.obs;

  void resendCode() async {
    try {
      isLoadingResend.value = true;
      var email = CacheHelper.getDataSharedPreference(key: 'email');
      final response = await HttpHelper.postData(
        endpoint: "resend_email_user",
        body: {
          'email': email,
        },
      );
      if (response['status'] == true) {
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
      } else {
        Get.snackbar("Warning!", response['message']);
      }
      isLoadingResend.value = false;
    } catch (error) {
      isLoadingResend.value = false;
      print(error);
    }
  }

  // confirm SMS
  var isLoadingSMS = false.obs;

  void confirmSMS({required String code, required BuildContext context}) async {
    try {
      isLoadingSMS.value = true;
      // Modify the endpoint and body according to your API for SMS confirmation
      var phone = CacheHelper.getDataSharedPreference(key: 'phone');

      final response = await HttpHelper.postData(
        endpoint: "check_sms_user",
        body: {'phone': phone, 'phone_code': code},
      );
      if (response['status'] == true) {
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
        // You can add navigation logic or other actions here
      } else {
        Get.snackbar("Warning!", response['message']);
      }
      isLoadingSMS.value = false;
    } catch (error) {
      isLoadingSMS.value = false;
      print(error);
    }
  }

  // resend SMS code
  var isLoadingResendSMS = false.obs;

  void resendSMSCode() async {
    try {
      isLoadingResendSMS.value = true;
      var phone = CacheHelper.getDataSharedPreference(key: 'phone');
      print(phone);
      // Modify the endpoint and body according to your API for resending SMS code
      final response = await HttpHelper.postData(
        endpoint: "resend_sms_user",
        body: {'phone': phone},
      );
      if (response['status'] == true) {
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
      } else {
        Get.snackbar("Warning!", response['message']);
      }
      isLoadingResendSMS.value = false;
    } catch (error) {
      isLoadingResendSMS.value = false;
      print(error);
    }
  }
}
