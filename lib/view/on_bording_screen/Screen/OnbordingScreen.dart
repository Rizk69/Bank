import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:MBAG/view/Auth_View/Login/Screen/Login_Screen.dart';
import 'package:MBAG/view/on_bording_screen/Controller/On_Bording_Controller.dart';
import 'package:MBAG/view/on_bording_screen/Widget/buttom_.dart';

import '../../../helper/Dark/SettingsController.dart';
import '../../Auth_View/R1iegister/screen/sign_up_screen.dart';
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

  CupertinoOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => FocusScope.of(context).unfocus());

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1.001,
          child: GetBuilder<CupertinoOnBoardingController>(
            init: CupertinoOnBoardingController(),
            builder: (controller) => Padding(
              padding: const EdgeInsets.all(16),
              child: buildBody(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: buildPageView(context),
        ),
        buildButtonsSection(),
      ],
    );
  }

  Widget buildPageView(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        buildPageViewBuilder(),
        Positioned(
          top: MediaQuery.of(context).size.height / 1.4,
          left: 140.w,
          child: buildIndicatorArea(context),
        ),
      ],
    );
  }

  Widget buildPageViewBuilder() {
    return PageView.builder(
      itemCount: onBoardingList.length,
      onPageChanged: (index) {
        controller.changeSelectIndex(index);
      },
      itemBuilder: (context, index) {
        return buildPageContent(index);
      },
    );
  }

  Widget buildPageContent(int index) {
    final SettingsController settingsController = Get.find();

    return Column(
      children: [
        const OnBordingLogoAndTitle(),
        Image.asset(
          onBoardingList[index].imageUrl,
          height: 180.h,
        ),
        SizedBox(height: 20.h),
        Text(
          onBoardingList[index].description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.h,
            color: settingsController.isDarkMode.value
                ? Colors.white
                : Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget buildButtonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Buttoms(
          text: controller.selectedIndex == 2 ? 'Get Start' : 'Login',
          color: Colors.white,
          onPressed: () {
            Get.to(() => LoginScreen());
          },
          colorText: Colors.black,
        ),
        SizedBox(height: 15.h),
        Buttoms(
          text: 'Create Account',
          color: Colors.black,
          onPressed: () {
            Get.to(() => SignUpScreen());
          },
          colorText: Colors.white,
        ),
      ],
    );
  }

  Widget buildIndicatorArea(BuildContext context) {
    return GetBuilder(
      init: CupertinoOnBoardingController(),
      builder: (controller) => Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
