import 'package:bank/view/splash_screen/Controller/Controller_Splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = SplashController();

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Your splash screen UI here
    splashController.navigateToOnboarding(); // Trigger navigation here

    return Scaffold(
      body: Center(
        child: Image.asset('Assets/images/Logo Mbag.png'),
      ),
    );
  }
}
