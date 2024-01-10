import 'package:MBAG/helper/Dark/SettingsController.dart';
import 'package:MBAG/view/Auth_View/Add_Id_Image/Controller/CaptureIdController.dart';
import 'package:MBAG/view/Auth_View/Login/Widget/HeadTitleDes.dart';
import 'package:MBAG/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BackImageScreen extends StatelessWidget {
  final CameraIdController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 60.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  HeadFirstTitle(
                    title: 'Take a photo for your ID'.tr,
                    des: 'take a photo for your personal id'.tr,
                  ),
                  Center(
                    child: Text(
                      'from back'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Container(
                    height: 350.h,
                    width: 200.w,
                    child: Image.asset('Assets/images/Id recognition.png'),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  controller.backImage.value == null ||
                          controller.backImage.value!.path.isEmpty
                      ? Buttoms(
                          text: "Take Back Photo".tr,
                          color: Colors.black,
                          onPressed: () {
                            controller.takePictureBack(ImageSource.camera);
                          },
                          colorText: Colors.white,
                        )
                      : SizedBox(),
                  SizedBox(height: 8),
                  if (controller.isSubmitting.isTrue)
                    CircularProgressIndicator(), // Show loading indicator
                  SizedBox(height: 16),
                  Buttoms(
                    text: 'Continue'.tr,
                    color: settingsController.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    onPressed: () {
                      controller.sendImagesToAPI();
                    },
                    colorText: settingsController.isDarkMode.value
                        ? Colors.black
                        : Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
