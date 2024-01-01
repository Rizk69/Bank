import 'package:MBAG/view/Home_View/Screens/home_screen.dart';
import 'package:MBAG/view/NotificationView/Screen/NotificationScreens.dart';
import 'package:MBAG/view/splash_screen/Splash_View.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'view/NotificationView/Controller/Push_Notification.dart';
import 'Core/cache_helper.dart';
import 'firebase_options.dart';
import 'helper/Dark/SettingsController.dart';
import 'helper/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(NotificationController());
  String languageCode = prefs.getString('languageCode') ?? 'en';
  String countryCode = prefs.getString('countryCode') ?? 'US';
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  Get.put(SettingsController());

  runApp(MyApp(
    locale: Locale(languageCode, countryCode),
    isDarkMode: isDarkMode,
  ));
}

class MyApp extends StatelessWidget {
  final Locale locale;
  final bool isDarkMode;

  MyApp({super.key, required this.locale, this.isDarkMode = true});

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.find();
    return Obx(
      () => ScreenUtilInit(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: MyTranslations(),
          locale: locale,
          theme: _lightTheme,
          darkTheme: _darkTheme,
          themeMode: settingsController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          initialBinding: Binding(),
          home: SplashScreen(),
          getPages: [
            GetPage(
              name: '/HomeScreen',
              page: () => HomeScreen(),
            ),
            GetPage(
                name: '/NotificationScreen', page: () => NotificationScreen()),
          ],
        ),
      ),
    );
  }

  final ThemeData _lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
  );

  final ThemeData _darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
  );
}

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
        },
        'ar_SA': {
          'hello': 'مرحبا بالعالم',
        },
      };
}

// class Home extends StatelessWidget {
//   const Home({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('title'.tr),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.language),
//             onPressed: () => _showLanguageDialog(context),
//           ),
//           IconButton(
//             icon: Icon(Icons.brightness_4),
//             onPressed: () async {
//               await toggleDarkMode();
//               // إعادة تحميل التطبيق لتطبيق التغييرات
//               Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Text('hello'.tr),
//       ),
//     );
//   }
//
//   void _showLanguageDialog(BuildContext context) {
//     // عرض قائمة اللغات للمستخدم
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Choose Language'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 title: Text('English'),
//                 onTap: () => _changeLanguage('en', 'US', context),
//               ),
//               ListTile(
//                 title: Text('العربية'),
//                 onTap: () => _changeLanguage('ar', 'SA', context),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//   Future<void> toggleDarkMode() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
//     await prefs.setBool('isDarkMode', !isDarkMode);
//   }
//
//   void _changeLanguage(String langCode, String countryCode, BuildContext context) async {
//     // تغيير اللغة وتخزين الاختيار
//     var locale = Locale(langCode, countryCode);
//     Get.updateLocale(locale);
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('languageCode', langCode);
//     await prefs.setString('countryCode', countryCode);
//     Get.back(); // إغلاق الحوار
//   }
// }
