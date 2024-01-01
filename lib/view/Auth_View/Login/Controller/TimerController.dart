import 'dart:async';
import 'package:get/get.dart';

import '../../R1iegister/controllers/register_controller.dart';
import 'Login_Controller.dart';

class BaseMyTimerController extends GetxController {
  final LoginController controller = Get.put(LoginController());
  final RegisterController controllerRegister = Get.put(RegisterController());

  late RxBool isTimerRunning;
  late RxBool isTimerPaused;

  var counter = 60.obs;
  late Timer _timer;
  static const int resendDelayInSeconds = 0;

  @override
  void onInit() {
    super.onInit();
    isTimerRunning = false.obs;
    isTimerPaused = false.obs;

    startTimer(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopTimer();
  }

  void startTimer(Function onResend) {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (!isTimerPaused.value) {
          counter.value--;

          if (counter.value == resendDelayInSeconds) {
            timer.cancel();
            onResend();
            counter.value = 0;
          }
        }
      },
    );
    isTimerRunning.value = true;
  }

  void stopTimer() {
    _timer.cancel();
    isTimerRunning.value = false;
  }

  void restartTimer(Function onResend) {
    if (isTimerRunning.value) {
      stopTimer();
    }
    counter.value = 60;
    startTimer(onResend);
    update();
  }

  void pauseTimer() {
    isTimerPaused.value = true;
  }

  void resumeTimer() {
    isTimerPaused.value = false;
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }
}

class MyTimerControllerLogin extends BaseMyTimerController {
  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }

  @override
  void startTimer(Function onResend) {
    super.startTimer(() {
      resendCode();
    });
  }

  void resendCode() {
    controller.resendCode(phone: controller.email.text);
  }
}

class MyTimerControllerRegisterPhoneorEmail extends BaseMyTimerController {
  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }

  @override
  void startTimer(Function onResend) {
    super.startTimer(() {
      resendCodePhone();
    });
  }

  void resendCodePhone() {
    if (controllerRegister.userId == 0) {
      controllerRegister.resendCode();
    }
  }
}

class MyTimerControllerRegisterEmail extends BaseMyTimerController {
  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }

  @override
  void startTimer(Function onResend) {
    super.startTimer(() {
      resendCodeEmail();
    });
  }

  void resendCodeEmail() {
    if (controllerRegister.userId == 0) {
      controllerRegister.resendCodeEmail();
    }
  }
}
