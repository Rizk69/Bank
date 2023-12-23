import 'package:MBAG/view/on_bording_screen/Widget/buttom_.dart';
import 'package:MBAG/view/splash_screen/Controller/Controller_Splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Core/cache_helper.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = SplashController();

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Your splash screen UI here
    splashController.navigateToNextScreen(); // Trigger navigation here

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset('Assets/images/MBAG.png', height: 200.h),
          ),
          Positioned(
            top: 50,
            child: Buttoms(
                text: 'Clear',
                color: Colors.white,
                onPressed: () {
                  CacheHelper.clearData();
                },
                colorText: Colors.black),
          )
        ],
      ),
    );
  }
}
