import 'package:MBAG/helper/Dark/SettingsController.dart';
import 'package:MBAG/view/Auth_View/Add_Id_Image/Controller/CaptureIdController.dart';
import 'package:MBAG/view/Auth_View/Login/Widget/HeadTitleDes.dart';
import 'package:MBAG/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CameraScreen extends StatelessWidget {
  final CameraController controller = Get.put(CameraController());

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

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
                  title: 'Take a photo for you'.tr,
                  des: 'please take a clear photo of'.tr),
              Center(
                  child: Text(
                'your face'.tr,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              )),
              SizedBox(height: 100.h),
              InkWell(
                onTap: () {
                  controller.takePhotoAndSendToAPI();
                },
                child: Column(
                  children: [
                    Container(
                      height: 200.h,
                      width: 200.w,
                      child: Image.asset('Assets/images/face recognition.png'),
                    ),
                    SizedBox(height: 10.h),
                    Center(
                        child: Text(
                      'Click here to take a selfie'.tr,
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    )),
                  ],
                ),
              ),
              Spacer(),
              Buttoms(
                text: 'Continue'.tr,
                color: settingsController.isDarkMode.value
                    ? Colors.white
                    : Colors.black,
                onPressed: () {
                  controller.takePhotoAndSendToAPI();
                },
                colorText: settingsController.isDarkMode.value
                    ? Colors.black
                    : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
