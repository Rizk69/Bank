import 'package:get/get.dart';

class MySwitchController extends GetxController {
  RxBool isSwitched = false.obs;
  RxBool isSwitched1 = false.obs;
  RxBool isSwitched2 = false.obs;

  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }

  void toggleSwitch1(bool value) {
    isSwitched.value = value;
  }

  void toggleSwitch2(bool value) {
    isSwitched.value = value;
  }
}
