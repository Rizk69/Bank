import 'package:bank/Core/cache_helper.dart';
import 'package:bank/view/on_bording_screen/Widget/buttom_.dart';
import 'package:bank/view/splash_screen/Splash_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import 'ConrollerMain.dart';
import 'helper/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init(); // Initialize CacheHelper
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialBinding: Binding(),
            home:
                // Obx(() {
                //   final notificationType = authController.notification?.runtimeType;
                //
                //   // Check the type of the notification and show SplashScreen accordingly
                //   if (notificationType == AppLifecycleState.detached.runtimeType&&notificationType == AppLifecycleState.resumed.runtimeType) {
                //     return FastLogin();
                //   } else {
                // Return your default widget or null if you don't want to show anything
                // return
                SplashScreen()
            // }
            //}
            ));
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

// class MyApp1 extends StatefulWidget {
//   const MyApp1({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp1> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp1> {
//   final LocalAuthentication auth = LocalAuthentication();
//   bool _isAuthenticating = false;
//
//   Future<void> _authenticate() async {
//     try {
//       bool canCheckBiometrics = await auth.canCheckBiometrics;
//       if (!canCheckBiometrics) {
//         print('Biometric authentication not available on this device.');
//         return;
//       }
//
//       bool authenticated = await auth.authenticate(
//         localizedReason: 'Let OS determine authentication method',
//       );
//       print('Authentication Result: $authenticated');
//     } catch (e) {
//       print('Authentication Error: $e');
//     } finally {
//       setState(() {
//         _isAuthenticating = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Biometric Authentication Example'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 _isAuthenticating = true;
//               });
//               _authenticate();
//             },
//             child: _isAuthenticating
//                 ? const CircularProgressIndicator()
//                 : const Text('Authenticate'),
//           ),
//         ),
//       ),
//     );
//   }
// }
