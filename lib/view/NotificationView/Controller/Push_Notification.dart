import 'package:MBAG/view/Transaction/Screen/Account_transaction_details.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/cache_helper.dart';
import '../../../Core/http_helper.dart';
import '../../Transaction/model/transaction_model.dart';

class NotificationController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late TransactionDetails transactionDetails;

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
      String title = message.notification?.title ?? '';
      String body = message.notification?.body ?? '';
      String type = message.data['type'] ?? "";
      String userId = message.data['user_id'] ?? "";
      String transId = message.data['trans_id'] ?? "";

      print("Title: $title");
      print("Body: $body");
      print("Type: $type");
      print("User ID: $userId");
      print("Transaction ID: $transId");

      if (type == 'transformation') {
        getTransactionsDetails(id: int.parse(transId));
      } else {
        Get.toNamed('/HomeScreen');
      }
    });
  }

  void initForegroundNotificationListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = message.notification?.title ?? '';
      String body = message.notification?.body ?? '';
      String type = message.data['type'] ?? "";
      String userId = message.data['user_id'] ?? "";
      String transId = message.data['trans_id'] ?? "";

      print("Title: $title");
      print("Body: $body");
      print("Type: $type");
      print("User ID: $userId");
      print("Transaction ID: $transId");

      Get.snackbar(title ?? "", body ?? "",
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.TOP, onTap: (getSnackBar) {
        if (type == 'transformation') {
          getTransactionsDetails(id: int.parse(transId));
        } else {
          Get.toNamed('/HomeScreen');
        }
      });
    });
  }

  Future<void> getTransactionsDetails({required int id}) async {
    print(id);
    try {
      final response =
          await HttpHelper.postData(endpoint: "get_transactionn/$id", body: {});
      if (response["status"] == true && response["transaction"] != null) {
        transactionDetails =
            TransactionDetails.fromJson(response["transaction"]);
        print(response);
        update();
        Get.offAll(() => AccountTransActonDetails(
              transactionDetails: transactionDetails,
              notification: true,
            ));
      } else {
        print("Transaction details not found or status is false");
      }
    } catch (error) {
      print("Error fetching transaction details: $error");
    } finally {}
  }
}
