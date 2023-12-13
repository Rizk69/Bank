import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasePinputController extends GetxController {
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

class PinputControllerLogin extends BasePinputController {
  // Additional specific functionality for login if needed
}

class PinputControllerSinUp extends BasePinputController {
  // Additional specific functionality for sign up if needed
}

class PinputControllerSinInCheckEmail extends BasePinputController {
  // Additional specific functionality for sign up if needed
}

class PinputControllerSinUpCheckEmail extends BasePinputController {
  // Additional specific functionality for sign up if needed
}

class PinputControllerFastLoginCheckEmail extends BasePinputController {
  // Additional specific functionality for sign up if needed
}
