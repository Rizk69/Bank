import 'package:MBAG/view/Auth_View/Add_Id_Image/Controller/CaptureIdController.dart';
import 'package:MBAG/view/Auth_View/Login/Controller/ControllerFastLogin.dart';
import 'package:MBAG/view/Auth_View/Login/Controller/Login_Controller.dart';
import 'package:MBAG/view/Auth_View/Login/Controller/PinController.dart';
import 'package:MBAG/view/Auth_View/Login/Controller/TimerController.dart';
import 'package:MBAG/view/Auth_View/R1iegister/controllers/CountryController.dart';
import 'package:MBAG/view/Home_View/controller/HomeGetData.dart';
import 'package:MBAG/view/Home_View/controller/contoller_home.dart';
import 'package:MBAG/view/Location/Controller/Location_Controller.dart';
import 'package:MBAG/view/Money_Transfer/Controller/AmountSendController.dart';
import 'package:MBAG/view/Money_Transfer/Controller/ContactControllerSendRequest.dart';
import 'package:MBAG/view/Money_Transfer/Controller/NestedTapController.dart';
import 'package:MBAG/view/QrTransaction/Controller/QrController.dart';
import 'package:MBAG/view/QrTransaction/Controller/ReceiveQrPaymentController.dart';
import 'package:MBAG/view/SelectCard/Controller/CardSelectionController.dart';
import 'package:MBAG/view/Transaction/controller/transaction_controller.dart';
import 'package:get/get.dart';

import '../view/NotificationView/Controller/Push_Notification.dart';
import '../view/AccountDetails/Controller/AccountDetailsController.dart';
import '../view/Home_View/Screens/first_screen.dart';
import '../view/Money_Transfer/Controller/ContactControllerSend.dart';
import '../view/Money_Transfer/Controller/MbagNumberController.dart';
import '../view/Trader/Controller.dart';
import 'Dark/SettingsController.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SettingsController());
    Get.lazyPut(() => HomeControllerGetData());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => NotificationController());
    Get.lazyPut(() => BasePinputController());
    Get.lazyPut(() => BaseMyTimerController());
    Get.lazyPut(() => TransactionController());
    Get.lazyPut(() => QRCodeScannerController());
    Get.lazyPut(() => NestedTabBarController());
    Get.lazyPut(() => CountryController());
    Get.lazyPut(() => FastLoginController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => TraderController());
    Get.lazyPut(() => FirstScreen());
    Get.lazyPut(() => LocationController());
    Get.lazyPut(() => ReceiveQrPaymentController());
    Get.lazyPut(() => AmountSendController());
    Get.lazyPut(() => ContactControllerSend());
    Get.lazyPut(() => ContactControllerSendRequest());
    Get.lazyPut(() => MbagNumberController());
    Get.lazyPut(() => AccountDetailsController());
    Get.lazyPut(() => CameraIdController());
    Get.lazyPut(() => CardController());
  }
}
