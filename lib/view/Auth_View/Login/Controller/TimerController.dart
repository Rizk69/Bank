import 'dart:async';
import 'package:get/get.dart';

class BaseMyTimerController extends GetxController {
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
    // Set the flag to indicate that the timer is not running
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
    _timer.cancel();
    super.onClose();
  }
}

class MyTimerControllerLogin extends BaseMyTimerController {
  void startTimer(Function onResend) {
    // Call the parent startTimer method
    super.startTimer(() {
      // Call the resendCode method from the RegisterController
      resendCode();
    });
  }

  // Replace this with your actual resendCode implementation
  void resendCode() {
    print('Resending code...');
  }
}

class MyTimerControllerRegister extends BaseMyTimerController {
  void startTimer(Function onResend) {
    // Call the parent startTimer method
    super.startTimer(() {
      // Call the resendCode method from the RegisterController
      resendCode();
    });
  }

  // Replace this with your actual resendCode implementation
  void resendCode() {
    print('Resending code...');
  }
}
