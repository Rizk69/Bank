import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController with WidgetsBindingObserver {
  Rx<AppLifecycleState?> _notification =
      Rx<AppLifecycleState?>(AppLifecycleState.resumed);

  AppLifecycleState? get notification => _notification.value;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    // يتم تحديث الـ notification إلى null بعد فترة زمنية قصيرة (يمكنك تعديل الوقت حسب الحاجة)
    Future.delayed(Duration(seconds: 1), () {
      _notification.value = null;
    });
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _notification.value = state;
    // قم بتنفيذ المنطق الإضافي إذا لزم الأمر عند تغيير حالة التطبيق.
  }
}
