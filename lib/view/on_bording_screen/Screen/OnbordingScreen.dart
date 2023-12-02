import 'package:bank/view/Auth_View/Login/Screen/Login_Screen.dart';
import 'package:bank/view/Auth_View/R1iegister/screen/sign_up_screen.dart';
import 'package:bank/view/on_bording_screen/Controller/On_Bording_Controller.dart';
import 'package:bank/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Widget/onbording_logo_title.dart';

class CupertinoOnboardingScreen extends StatelessWidget {
  final CupertinoOnBoardingController controller =
      Get.put(CupertinoOnBoardingController());

  final List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
        "Welcome",
        "send money 24/7 without fees to any MBAG account or IBAN . Request money from any one. set up recurring transfers for your regular payments",
        "Assets/images/onbordingimage.png"),
    OnBoardingModel(
        "Discover",
        "send money 24/7 without fees to any MBAG account or IBAN . Request money from any one. set up recurring transfers for your regular payments",
        "Assets/images/onbordingimage.png"),
    OnBoardingModel(
        "Shop",
        "send money 24/7 without fees to any MBAG account or IBAN . Request money from any one. set up recurring transfers for your regular payments",
        "Assets/images/onbordingimage.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<CupertinoOnBoardingController>(
        init: CupertinoOnBoardingController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    PageView.builder(
                      itemCount: onBoardingList.length,
                      onPageChanged: (index) {
                        controller.changeSelectIndex(index);
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const OnBordingLogoAndTitle(),
                            Image.asset(
                              onBoardingList[index].imageUrl,
                              height: 180,
                            ),
                            SizedBox(height: 40),
                            Text(
                              onBoardingList[index].description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Positioned(
                      bottom: 140.h,
                      left: 135.w,
                      child: buildIndicatorArea(),
                    ),
                  ],
                ),
              ),
              Buttoms(
                text: controller.selectedIndex == 2 ? 'Get Start' : 'Login',
                color: Colors.white,
                onPressed: () {
                  if (controller.selectedIndex == onBoardingList.length - 1) {
                    Get.offAll(() => LoginScreen());
                  } else {
                    controller.changeSelectIndex(controller.selectedIndex + 1);
                    controller.update();
                  }
                },
                colorText: Colors.black,
              ),
              SizedBox(
                height: 15,
              ),
              Buttoms(
                text: 'Create Account',
                color: Colors.black,
                onPressed: () {
                  if (controller.selectedIndex == onBoardingList.length - 1) {
                    Get.offAll(() => SignUpScreen());
                  } else {
                    controller.changeSelectIndex(controller.selectedIndex + 1);
                    controller.update();
                  }
                },
                colorText: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicatorArea() {
    return GetBuilder(
      init: CupertinoOnBoardingController(),
      builder: (controller) => Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            onBoardingList.length,
            (index) => GestureDetector(
              onTap: () {
                controller.changeSelectIndex(index);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  shape: BoxShape.circle,
                  color: controller.selectedIndex == index
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
