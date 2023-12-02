import 'dart:convert';
import 'dart:io';
import 'package:bank/Core/widgets/Navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker_nm/country.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../screen/confirm_email_screen.dart';

class RegisterController extends GetxController {
  var bordcontroller = PageController();
  var emailControllerSignUpOne = TextEditingController();
  var keyFormSignUpOne = GlobalKey<FormState>();
  var passwordControllerSignUpOne = TextEditingController();
  var passwordConfirmControllerSignUpOne = TextEditingController();
  var firstNameControllerSignUpTwo = TextEditingController();
  var keyFormSignUpTwo = GlobalKey<FormState>();
  var lastNameControllerSignUpTwo = TextEditingController();
  var idNumberControllerSignUpTwo = TextEditingController();
  var mobileNumberControllerSignUpTwo = TextEditingController();

  late Country selected;

  void navig() {
    bordcontroller.nextPage(
      duration: const Duration(
        milliseconds: 750,
      ),
      curve: Curves.easeInCubic,
    );
  }

  var currentIndex = 0.obs;
  var isLoading = false.obs;

  // register
  Future<void> register({
    required String email,
    required String password,
    required String password_confirmation,
    required String first_name,
    required String last_name,
    required String id_number,
    required String country_id,
    required String phone,
    required File img,
    required File frout_id,
    required File back_id,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://wallet.acwad-it.com/api/register'), // Update with your server URL
      );
      request.headers['Authorization'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Accept-Language'] = 'en';
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['password_confirmation'] = password_confirmation;
      request.fields['first_name'] = first_name;
      request.fields['last_name'] = last_name;
      request.fields['id_number'] = id_number;
      request.fields['country_id'] = country_id;
      request.fields['phone'] = phone;
      request.files.add(
        http.MultipartFile.fromBytes('img', File(img.path).readAsBytesSync(),
            filename: img.path),
      );
      request.files.add(
        http.MultipartFile.fromBytes(
            'frout_id', File(frout_id.path).readAsBytesSync(),
            filename: frout_id.path),
      );
      request.files.add(
        http.MultipartFile.fromBytes(
            'back_id', File(back_id.path).readAsBytesSync(),
            filename: back_id.path),
      );
      var response = await request.send();
      if (response.statusCode == 201) {
        // Successfully uploaded
        var responseBody =
            await response.stream.bytesToString(); // Decode the response body
        var parsedResponse =
            json.decode(responseBody); // Parse the JSON response if applicable
        if (parsedResponse['status'] == true) {
          Get.snackbar("Success!", "send message to your email",
              backgroundColor: Colors.blue);
          navigatofinsh(context, ConfirmEmailScreen(), false);
          // empty controllers
          emailControllerSignUpOne.text = "";
          passwordControllerSignUpOne.text = "";
          passwordConfirmControllerSignUpOne.text = "";
          firstNameControllerSignUpTwo.text = "";
          lastNameControllerSignUpTwo.text = "";
          idNumberControllerSignUpTwo.text = "";
          mobileNumberControllerSignUpTwo.text = "";
          print('File uploaded successfully');
        } else {
          Get.snackbar("Warning!", parsedResponse['message']);
          print('File uploaded successfully');
        }
        isLoading.value = false;
        print('Server Response: $parsedResponse');
      } else {
        // Handle errors
        var responseBody =
            await response.stream.bytesToString(); // Decode the response body
        var parsedResponse =
            json.decode(responseBody); // Parse the JSON response if applicable
        Get.snackbar("Error!", parsedResponse['message'],
            backgroundColor: Colors.red);
        print('File upload failed with status ${response.statusCode}');
        print('Error Response: $responseBody');
        isLoading.value = false;
      }
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      print(error);
    }
  }

  // alert
  void showAlert(
      {required BuildContext context,
      required VoidCallback camera,
      required VoidCallback gallary}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose'),
          actions: <Widget>[
            TextButton(
              onPressed: camera,
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: gallary,
              child: const Text('Gallary'),
            ),
          ],
        );
      },
    );
  }
}
