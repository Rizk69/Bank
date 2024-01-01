import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/cache_helper.dart';

class NotificationController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    super.onInit();

    requestNotificationPermission();
    initPushNotification();
    initForegroundNotificationListener();
  }

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final fcmToken = await _firebaseMessaging.getToken();
      await CacheHelper.saveDataSharedPreference(
        key: "fcmToken",
        value: fcmToken,
      );

      print(CacheHelper.getDataSharedPreference(key: "fcmToken"));
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      Future.delayed(Duration.zero, () {
        Get.snackbar(
          'إشعارات معطلة', // Title
          'يرجى تفعيل الإشعارات لتحسين تجربتك مع التطبيق.', // Message
          snackPosition: SnackPosition.TOP,
          // Position of the Snackbar
          backgroundColor: Colors.red,
          // Background color
          colorText: Colors.white,
          // Text color
          duration: const Duration(seconds: 3),
          // Duration of the Snackbar
          borderRadius: 10,
          // Border radius for the Snackbar
          margin: EdgeInsets.all(10),
          // Margin around the Snackbar
          icon: Icon(Icons.notifications_off, color: Colors.white),
          // Leading icon
          shouldIconPulse: false,
          // Controls if the icon should pulse
          barBlur: 20,
          // Blur effect for the background
          isDismissible: true,
          // Allows the Snackbar to be dismissed by swiping
          forwardAnimationCurve:
              Curves.easeOutBack, // Animation curve for Snackbar entrance
        );
      });
    }
  }

  Future<void> initPushNotification() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Get.toNamed('/NotificationScreen', arguments: message);
    });
  }

  void initForegroundNotificationListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Get.snackbar(
        'إشعار جديد',
        message.notification?.body ?? 'لديك إشعار جديد',
        snackPosition: SnackPosition.TOP,
      );
    });
  }
}
