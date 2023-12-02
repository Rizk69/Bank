import 'package:bank/Core/cache_helper.dart';
import 'package:bank/view/Home_View/Screens/home_screen.dart';

import 'package:bank/view/on_bording_screen/Widget/buttom_.dart';
import 'package:bank/view/splash_screen/Splash_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'helper/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init(); // Initialize CacheHelper
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: Binding(),
        home: SplashScreen(),
      ),
    );
  }
}

class ScreenFour extends StatelessWidget {
  const ScreenFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Screen Four'),
      ),
    );
  }
}

class ScreenFive extends StatelessWidget {
  const ScreenFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Buttoms(
            color: Colors.red,
            text: 'LOG OUT',
            onPressed: () {
              CacheHelper.removeData(key: 'token');
            },
            colorText: Colors.white),
      ),
    );
  }
}
