import 'dart:async';
import 'package:get/get.dart';

import '../../R1iegister/controllers/register_controller.dart';
import 'Login_Controller.dart';

class BaseMyTimerController extends GetxController {
  final LoginController controller = Get.put(LoginController());

  late RxBool isTimerRunning;
  late RxBool isTimerPaused;

  var counter = 0.obs;
  late Timer _timer;
  static const int resendDelayInSeconds = 60; // Adjust as needed

  @override
  void onInit() {
    super.onInit();
    // Initialize the flags
    isTimerRunning = false.obs;
    isTimerPaused = false.obs;

    // Initialize the timer
    startTimer(() {
      // Initial logic when the timer starts
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopTimer();
  }

  void startTimer(Function onResend) {
    // Set code as visible initially

    const duration = Duration(seconds: 1); // Set the timer to run every second
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (!isTimerPaused.value) {
          counter.value++;

          // If you want to stop the timer after a certain condition, you can add that logic here.
          if (counter.value == resendDelayInSeconds) {
            timer.cancel();
            onResend();
            counter.value = 0;
          }
        }
      },
    );
    // Set the flag to indicate that the timer is running
    isTimerRunning.value = true;
  }

  void stopTimer() {
    _timer.cancel();
    isTimerRunning.value = false;
  }

  void restartTimer(Function onResend) {
    // Stop the timer if it's already running
    if (isTimerRunning.value) {
      stopTimer();
    }

    // Reset the counter
    counter.value = 0;

    // Start the timer again
    startTimer(onResend);
  }

  void pauseTimer() {
    // Set the flag to indicate that the timer is paused
    isTimerPaused.value = true;
  }

  void resumeTimer() {
    // Set the flag to indicate that the timer is resumed
    isTimerPaused.value = false;
  }

  @override
  void onClose() {
    // Stop the timer when the controller is closed
    stopTimer();
    super.onClose();
  }
}

class MyTimerControllerLogin extends BaseMyTimerController {
  void onClose() {
    stopTimer(); // Stop the timer when the screen changes
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

class MyTimerControllerRegister extends BaseMyTimerController {
  final RegisterController controllerRegister = Get.put(RegisterController());

  @override
  void onClose() {
    stopTimer(); // Stop the timer when the screen changes
    super.onClose();
  }

  @override
  void startTimer(Function onResend) {
    // Check the status before starting the timer
    checkPhoneStatus(onResend);
  }

  void checkPhoneStatus(Function onResend) async {
    try {
      final response = await checkPhone();

      if (response["status"] == true) {
        stopTimer();
      } else {
        // If status is false, call the parent startTimer method
        super.startTimer(() {
          resendCode();
        });
      }
    } catch (error) {
      print(error);
    }
  }

  // Replace this with your actual resendCode implementation
  void resendCode() {
    controllerRegister.resendCode();
  }

  // Replace this with your actual implementation of checkPhone
  Future<Map<String, dynamic>> checkPhone() async {
    // Assuming you have an implementation for checking phone status
    return {}; // Return a map with the response
  }
}
