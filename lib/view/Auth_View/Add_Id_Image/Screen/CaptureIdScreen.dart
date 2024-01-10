import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../helper/Dark/SettingsController.dart';
import '../../../on_bording_screen/Widget/buttom_.dart';
import '../../Login/Widget/HeadTitleDes.dart';
import '../Controller/CaptureIdController.dart';

class CameraScreenId extends StatelessWidget {
  final CameraIdController controller = Get.put(CameraIdController());

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                    title: 'Take a photo for your ID'.tr,
                    des: 'take a photo for your personal id'.tr),
                Center(
                    child: Text(
                  'from front'.tr,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                )),
                SizedBox(height: 60.h),
                Container(
                  height: 350.h,
                  width: 200.w,
                  child: Image.asset('Assets/images/Id recognition.png'),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Buttoms(
                  text: "Take Front Photo".tr,
                  color: settingsController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                  onPressed: () {
                    controller.takePictureFront(ImageSource.camera);
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
    );
  }
}
