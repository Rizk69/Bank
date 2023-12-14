import 'dart:io';
import 'package:bank/view/Home_View/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Core/http_helper.dart';
import '../../../on_bording_screen/Widget/buttom_.dart';
import '../../Login/Widget/HeadTitleDes.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _frontImage;
  File? _backImage;
  bool _isSubmitting = false;

  Future<void> _takePicture(ImageSource source) async {
    if (_isSubmitting) {
      return;
    }

    var status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          if (_frontImage == null) {
            _frontImage = File(pickedFile.path!);
          } else {
            _backImage = File(pickedFile.path!);
          }
        });

        if (_frontImage != null && _backImage != null) {
          _submitImagesToApi();
        }
      }
    } else {
      print('Camera permission denied');
    }
  }

  Future<String> _analyzeImage(File image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final visionText = await textRecognizer.processImage(inputImage);
    String text = visionText.text;
    return text.trim();
  }

  Future<void> _submitImagesToApi() async {
    setState(() {
      _isSubmitting = true;
    });

    String frontImageResult = await _analyzeImage(_frontImage!);
    String backImageResult = await _analyzeImage(_backImage!);

    bool isIDCard = frontImageResult.contains('ID card') &&
        backImageResult.contains('ID card');

    if (isIDCard) {
      _sendIdCardImages(_frontImage!, _backImage!);
    } else {
      setState(() {
        _frontImage = null;
        _backImage = null;
        _isSubmitting = false;
      });
      Get.snackbar("Warning!", 'Images do not contain ID card',
          backgroundColor: Colors.red);
      print('Images do not contain ID card');
    }
  }

  Future<void> _sendIdCardImages(
      File frontImageResult, File backImageResult) async {
    try {
      final response = await HttpHelper.postMultipart(
        endpoint: "add_id",
        fields: {
          'frout_id': frontImageResult,
          'back_id': backImageResult,
        },
        files: [
          _frontImage!,
          _backImage!,
        ],
      );

      print(response.toString());

      if (response["status"] == true) {
        Get.offAll(HomeScreen());
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _frontImage = null;
        _backImage = null;
        _isSubmitting = false;
      });
    }
  }

  // ... (الأجزاء الأخرى من الكود لم تتغير)

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
                  _takePicture(ImageSource.camera);
                },
                colorText: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
