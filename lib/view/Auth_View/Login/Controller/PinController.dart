import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinputController extends GetxController {
  final TextEditingController pinController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    pinController.addListener(_onPinChanged);
  }

  @override
  void onClose() {
    pinController.removeListener(_onPinChanged);
    pinController.dispose();
    super.onClose();
  }

  void _onPinChanged() {
    debugPrint('onChanged: ${pinController.text}');
  }

  void validatePin() {
    formKey.currentState?.validate();
  }
}
