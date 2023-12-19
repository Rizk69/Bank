import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../Core/cache_helper.dart';
import '../../../Core/http_helper.dart';
import '../model/UserModel.dart';
import 'dart:io';

class AccountDetailsController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;
  var isLoading = false.obs;

  UserModel get userModel => _userModel.value;
  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    getDataUser();
  }

  Future<void> takePhotoAndSendToAPI() async {
    try {
      // Ensure camera permissions are granted
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50, // Adjust the quality as needed
      );

      if (pickedFile != null) {
        // Retrieve the token from shared preferences
        var token = await CacheHelper.getDataSharedPreference(key: 'token');

        // Create a multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://wallet.acwad-it.com/api/edit_img'),
        );

        // Attach the picked image file to the request
        request.files.add(
          await http.MultipartFile.fromPath('img', pickedFile.path),
        );

        // Add headers to the request, including the authorization token
        request.headers.addAll({
          'Accept': 'application/json',
          'Accept-Language': 'en',
          'Authorization': 'Bearer $token',
        });

        // Send the request and handle the response
        var response = await request.send();

        if (response.statusCode == 201) {
          print('Image uploaded successfully');
          print('Response: ${await response.stream.bytesToString()}');
          update();
        } else {
          print('Error uploading image: ${response.reasonPhrase}');
        }
      }
    } catch (error) {
      if (error is SocketException) {
        print('Network error: $error');
      } else {
        print('Error: $error');
      }
    }
  }

  Future<void> getDataUser() async {
    try {
      final response = await HttpHelper.getData(
        endpoint: "user",
      );
      if (response["status"] == true) {
        isLoading.value = true;

        _userModel.value = UserModel.fromJson(response);
        print(response.toString());
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
        isLoading.value = false;
      }
    } catch (error) {
      print(error);
    }
  }
}
