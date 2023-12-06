import 'dart:async';
import 'package:get/get.dart';

class MyTimerController extends GetxController {
  var counter = 0.obs;
  var isCodeVisible = false.obs;
  late Timer _timer;
  static const int resendDelayInSeconds = 150; // Adjust as needed

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    // Set code as visible initially
    isCodeVisible.value = true;

    const duration = Duration(seconds: 1); // Set the timer to run every second
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        counter.value++;

        // If you want to stop the timer after a certain condition, you can add that logic here.
        if (counter.value == resendDelayInSeconds) {
          timer.cancel();
          print('Code resent!');

          isCodeVisible.value = false;
          counter.value = 0; // Reset the counter for the next cycle
          startTimer(); // Start the timer again for the next cycle
        }
      },
    );
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
