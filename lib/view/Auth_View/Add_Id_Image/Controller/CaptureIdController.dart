import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import '../../../../Core/cache_helper.dart';
import '../../../Home_View/Screens/home_screen.dart';
import '../Screen/CaptureIdScreen.dart';

// class CameraIdController extends GetxController {
//   final picker = ImagePicker();
//   final isSubmitting = RxBool(false);
//   final frontImage = Rx<File?>(null);
//   final backImage = Rx<File?>(null);
//   final currentPage = RxInt(1);
//
//   Future<void> takePictureFront(ImageSource source) async {
//     try {
//       var status = await Permission.camera.request();
//       if (status.isGranted) {
//         final pickedFile = await picker.pickImage(
//           source: source,
//           imageQuality: 50,
//         );
//
//         if (pickedFile != null) {
//           isSubmitting.value = true;
//
//           frontImage.value ??= File(pickedFile.path);
//           Get.to(()=>BackImageScreen());
//
//         }
//       } else {
//         print('Camera permission denied');
//       }
//     } catch (error) {
//       print('Error taking picture: $error');
//     } finally {
//       isSubmitting.value = false;
//     }
//   }
//   Future<void> takePictureBack(ImageSource source) async {
//     try {
//       var status = await Permission.camera.request();
//       if (status.isGranted) {
//         final pickedFile = await picker.pickImage(
//           source: source,
//           imageQuality: 50,
//         );
//
//         if (pickedFile != null) {
//           isSubmitting.value = true;
//
//           frontImage.value ??= File(pickedFile.path);
//           Get.to(()=>ViewImagesScreen());
//
//
//         }
//       } else {
//         print('Camera permission denied');
//       }
//     } catch (error) {
//       print('Error taking picture: $error');
//     } finally {
//       isSubmitting.value = false;
//     }
//   }
//
//
//   Future<void> sendIdCardImages() async {
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('https://wallet.acwad-it.com/api/add_id'),
//       );
//
//       if (frontImage.value != null) {
//         List<int> frontImageBytes = await frontImage.value!.readAsBytes();
//         request.files.add(
//           http.MultipartFile.fromBytes(
//             'front_id', // Use 'front_id' for front image
//             frontImageBytes,
//           ),
//         );
//       }
//
//       if (backImage.value != null) {
//         List<int> backImageBytes = await backImage.value!.readAsBytes();
//         request.files.add(
//           http.MultipartFile.fromBytes(
//             'back_id', // Use 'back_id' for back image
//             backImageBytes,
//           ),
//         );
//       }
//
//       var token = await CacheHelper.getDataSharedPreference(key: 'token');
//       request.headers.addAll({
//         'Accept': 'application/json',
//         'Accept-Language': 'en',
//         'Authorization': 'Bearer $token',
//       });
//
//       var response = await request.send();
//
//       if (response.statusCode == 201) {
//         Get.offAll(() => HomeScreen());
//         print('Images uploaded successfully');
//         print('Response: ${await response.stream.bytesToString()}');
//       } else {
//         print('Error uploading images. Status Code: ${response.statusCode}');
//         print('Response: ${await response.stream.bytesToString()}');
//       }
//     } catch (error) {
//       print('Error: $error');
//     }
//   }
// }
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

          frontImage.value ??= File(pickedFile.path);
          Get.to(() => BackImageScreen());
        }
      } else {
        print('Camera permission denied');
      }
    } catch (error) {
      print('Error taking picture: $error');
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

          backImage.value ??= File(pickedFile.path);
        }
      } else {
        print('Camera permission denied');
      }
    } catch (error) {
      print('Error taking picture: $error');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> sendImagesToAPI() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://wallet.acwad-it.com/api/add_id'),
      );

      if (frontImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath('frout_id', frontImage.value!.path),
        );
      }

      if (backImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath('back_id', backImage.value!.path),
        );
      }

      var token = await CacheHelper.getDataSharedPreference(key: 'token');
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Accept-Language': 'en',
      });

      var response = await request.send();

      if (response.statusCode == 201) {
        Get.offAll(() => HomeScreen());
        print('Images uploaded successfully');
        print('Response: ${await response.stream.bytesToString()}');
      } else {
        print('Error uploading images. Status Code: ${response.statusCode}');
        print('Response: ${await response.stream.bytesToString()}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

class CameraController extends GetxController {
  final picker = ImagePicker();
  final bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

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
          Uri.parse('https://wallet.acwad-it.com/api/add_img'),
        );

        // Attach the picked image file to the request
        request.files.add(
          await http.MultipartFile.fromPath('img', pickedFile.path),
        );

        // Add headers to the request, including the authorization token
        request.headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Accept-Language': 'en',
        });

        // Send the request and handle the response
        var response = await request.send();

        if (response.statusCode == 200) {
          print('Image uploaded successfully');
          print('Response: ${await response.stream.bytesToString()}');
          Get.snackbar("  Done", '', backgroundColor: Colors.blue);
          Get.off(() => HomeScreen());
        } else {
          Get.snackbar("Warning!", response.reasonPhrase ?? '',
              backgroundColor: Colors.red);
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
}
