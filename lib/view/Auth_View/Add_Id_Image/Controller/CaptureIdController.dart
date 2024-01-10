import 'dart:io';
import 'package:MBAG/Core/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import '../../../../Core/cache_helper.dart';
import '../../../Home_View/Screens/home_screen.dart';
import '../Screen/AddImage/ImageSubment.dart';

enum CurrentScreen {
  CameraScreen,
  BackImageScreen,
}

class CameraIdController extends GetxController {
  final picker = ImagePicker();
  final isSubmitting = RxBool(false);
  final frontImage = Rx<File?>(null);
  final backImage = Rx<File?>(null);
  final currentScreen = RxString(CurrentScreen.CameraScreen.toString());

  Future<void> takePictureFront(ImageSource source) async {
    try {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        final pickedFile = await picker.pickImage(
          source: source,
          imageQuality: 50,
        );

        if (pickedFile != null) {
          isSubmitting.value = true;
          frontImage.value = File(pickedFile.path);
          Get.to(() => BackImageScreen());
        } else {
          // Show Snackbar if no picture is taken
          Get.snackbar('Error', 'No picture taken. Please try again.');
        }
      } else {
        Get.snackbar('Permission Denied', 'Camera permission denied.');
      }
    } catch (error) {
      Get.snackbar('Error', 'Error taking picture: $error');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> takePictureBack(ImageSource source) async {
    try {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        final pickedFile = await picker.pickImage(
          source: source,
          imageQuality: 50,
        );

        if (pickedFile != null) {
          isSubmitting.value = true;
          backImage.value = File(pickedFile.path);
        } else {
          // Show Snackbar if no picture is taken
          Get.snackbar('Error', 'No picture taken. Please try again.');
        }
      } else {
        Get.snackbar('Permission Denied', 'Camera permission denied.');
      }
    } catch (error) {
      Get.snackbar('Error', 'Error taking picture: $error');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> sendImagesToAPI() async {
    if (frontImage.value == null || backImage.value == null) {
      // Show Snackbar if either image is missing
      Get.snackbar('Error', 'Please capture both front and back images.');
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://wallet.acwad-it.com/api/add_id'),
      );

      request.files.add(
        await http.MultipartFile.fromPath('frout_id', frontImage.value!.path),
      );
      request.files.add(
        await http.MultipartFile.fromPath('back_id', backImage.value!.path),
      );

      var token = await CacheHelper.getDataSharedPreference(key: 'token');
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Accept-Language': HttpHelper.languageCode,
      });

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.offAll(() => HomeScreen());
        print('Images uploaded successfully');
      } else {
        Get.snackbar('Error',
            'Error uploading images. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      Get.snackbar('Error', 'Error sending images: $error');
    }
  }
}

class CameraController extends GetxController {
  final picker = ImagePicker();
  final bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  Future<void> takePhotoAndSendToAPI() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        var token = await CacheHelper.getDataSharedPreference(key: 'token');

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://wallet.acwad-it.com/api/add_img'),
        );

        request.files.add(
          await http.MultipartFile.fromPath('img', pickedFile.path),
        );

        request.headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Accept-Language': HttpHelper.languageCode,
        });

        var response = await request.send();

        // تحديث التحقق من الرمز الحالي للاستجابة
        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Image uploaded successfully');
          print('Response: ${await response.stream.bytesToString()}');
          Get.snackbar('Successful'.tr, '', backgroundColor: Colors.blue);
          Get.offAll(() => HomeScreen());
        } else {
          var reason = response.reasonPhrase ?? 'Unknown error';
          Get.snackbar("Warning!", reason, backgroundColor: Colors.red);
          print('Error uploading image: $reason');
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
}
