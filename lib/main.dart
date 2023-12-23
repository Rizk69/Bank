import 'package:MBAG/view/Home_View/Screens/home_screen.dart';
import 'package:MBAG/view/splash_screen/Splash_View.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Core/cache_helper.dart';
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
        getPages: [
          GetPage(
            name: '/HomeScreen',
            page: () => HomeScreen(),
          ),
        ],
      ),
    );
  }
}

