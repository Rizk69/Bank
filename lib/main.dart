import 'package:MBAG/view/Home_View/Screens/home_screen.dart';
import 'package:MBAG/view/splash_screen/Splash_View.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Core/cache_helper.dart';
import 'helper/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init(); // Initialize CacheHelper
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init(); // Initialize CacheHelper
  SharedPreferences prefs = await SharedPreferences.getInstance();

  const int currentVersionCode = 1; // Set the current version code here
  int oldVersionCode = prefs.getInt('versionCode') ?? 1;
  print(oldVersionCode);

  if (currentVersionCode == oldVersionCode) {
  } else {
    await prefs.remove('token');
    await prefs.setInt('versionCode', currentVersionCode);
  }

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
