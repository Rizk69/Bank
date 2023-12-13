import 'dart:io';
import 'package:bank/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Login/Widget/HeadTitleDes.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _frontImage;
  File? _backImage;
  int _currentImage = 1; // 1 for front, 2 for back
  bool _isSubmitting =
      false; // Flag to track whether images are being submitted

  Future<void> _takePicture(ImageSource source) async {
    // Check if submitting is in progress
    if (_isSubmitting) {
      return;
    }

    // Request permission
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          if (_currentImage == 1) {
            _frontImage = File(pickedFile.path);
          } else {
            _backImage = File(pickedFile.path);
          }
          _currentImage++;
        });

        if (_currentImage <= 2) {
          // If there are still images to capture, allow the user to take another picture
          _showImageCaptureDialog();
        } else {
          // If both images are captured, proceed with API submission
          _submitImagesToApi();
        }
      }
    } else {
      // Handle denied permission
      print('Camera permission denied');
    }
  }

  void _submitImagesToApi() async {
    // Set submitting flag to true
    setState(() {
      _isSubmitting = true;
    });

    // API call logic here
    print('Submitting images to API');
    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));

    // Reset images after submission
    setState(() {
      _frontImage = null;
      _backImage = null;
      _currentImage = 1;
      _isSubmitting = false; // Set submitting flag to false
    });
  }

  void _showImageCaptureDialog() {
    // Show a dialog or perform any necessary UI update to inform the user to capture the next image
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Capture Image'),
          content: Text(
              'Capture the ${_currentImage == 1 ? "front" : "back"} image'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 60.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back)),
              ),
              HeadFirstTitle(
                  title: 'Take a photo for your ID',
                  des: 'take a photo for your personal id'),
              Center(
                  child: Text(
                'from front and back',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              )),
              SizedBox(height: 80.h),
              Container(
                height: 350.h,
                width: 200.w,
                child: Image.asset('Assets/images/unsplash_a4maTFz1QPc.png'),
              ),
              Spacer(),
              Buttoms(
                  text: "Continue",
                  color: Colors.black,
                  onPressed: () {
                    if (_frontImage == null) {
                      // If front image is not captured, capture it
                      _takePicture(ImageSource.camera);
                    } else if (_backImage == null) {
                      // If back image is not captured, capture it
                      _takePicture(ImageSource.camera);
                    } else {
                      // If both front and back images are captured, submit to API
                      _submitImagesToApi();
                    }
                  },
                  colorText: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
