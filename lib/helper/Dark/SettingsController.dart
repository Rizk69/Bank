import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Core/http_helper.dart';

class SettingsController extends GetxController {
  RxBool isDarkMode = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
  }

  Future<void> toggleDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = !isDarkMode.value;
    await prefs.setBool('isDarkMode', isDarkMode.value);
    if (isDarkMode.value) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
  }

  Future<void> changeLanguage(String langCode, String countryCode) async {
    var locale = Locale(langCode, countryCode);
    Get.updateLocale(locale);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', langCode);
    await prefs.setString('countryCode', countryCode);
    HttpHelper.updateLanguageHeader(langCode);

    Get.back();
    Get.offAllNamed('/HomeScreen');
  }
}
