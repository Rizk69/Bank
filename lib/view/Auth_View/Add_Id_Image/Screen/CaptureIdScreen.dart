import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../on_bording_screen/Widget/buttom_.dart';
import '../../Login/Widget/HeadTitleDes.dart';
import '../Controller/CaptureIdController.dart';

class CameraScreenId extends StatelessWidget {
  final CameraIdController controller = Get.put(CameraIdController());

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
                'from front',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              )),
              SizedBox(height: 80.h),
              Container(
                height: 350.h,
                width: 200.w,
                child: Image.asset('Assets/images/Id recognition.png'),
              ),
              Spacer(),
              Buttoms(
                text: "Take Front Photo",
                color: Colors.black,
                onPressed: () {
                  controller.takePictureFront(ImageSource.camera);
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

class BackImageScreen extends StatelessWidget {
  final CameraIdController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
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
                  title: 'Take a photo for your ID',
                  des: 'Take a photo for your personal ID',
                ),
                Center(
                  child: Text(
                    'from back',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Container(
                  height: 350.h,
                  width: 200.w,
                  child: Image.asset('Assets/images/Id recognition.png'),
                ),
                Spacer(),
                controller.backImage.value == null ||
                        controller.backImage.value!.path.isEmpty
                    ? Buttoms(
                        text: "Take Back Photo",
                        color: Colors.black,
                        onPressed: () {
                          controller.takePictureBack(ImageSource.camera);
                        },
                        colorText: Colors.white,
                      )
                    : SizedBox(),
                SizedBox(height: 16),
                if (controller.isSubmitting.isTrue)
                  CircularProgressIndicator(), // Show loading indicator
                SizedBox(height: 16),
                Buttoms(
                  text: "Submit",
                  color: Colors.black,
                  onPressed: () {
                    controller.sendImagesToAPI();
                  },
                  colorText: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CameraScreen extends StatelessWidget {
  final CameraController controller = Get.put(CameraController());

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
                  title: 'Take a photo for you ',
                  des: 'please take a clear photo of '),
              Center(
                  child: Text(
                'your face ',
                style: TextStyle(
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
                      'Click here to take a selfie ',
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
                text: "Continue",
                color: Colors.black,
                onPressed: () {
                  controller.takePhotoAndSendToAPI();
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
