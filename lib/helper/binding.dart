import 'package:bank/view/Auth_View/Login/Controller/ControllerFastLogin.dart';
import 'package:bank/view/Auth_View/Login/Controller/Login_Controller.dart';
import 'package:bank/view/Auth_View/Login/Controller/PinController.dart';
import 'package:bank/view/Auth_View/Login/Controller/TimerController.dart';
import 'package:bank/view/Auth_View/R1iegister/controllers/CountryController.dart';
import 'package:bank/view/Home_View/controller/contoller_home.dart';
import 'package:bank/view/Location/Controller/Location_Controller.dart';
import 'package:bank/view/Money_Transfer/Controller/AmountSendController.dart';
import 'package:bank/view/Money_Transfer/Controller/ContactControllerSendRequest.dart';
import 'package:bank/view/Money_Transfer/Controller/NestedTapController.dart';
import 'package:bank/view/QrTransaction/Controller/QrController.dart';
import 'package:bank/view/QrTransaction/Controller/ReceiveQrPaymentController.dart';
import 'package:bank/view/Transaction/controller/transaction_controller.dart';
import 'package:get/get.dart';

import '../view/Home_View/Screens/first_screen.dart';
import '../view/Money_Transfer/Controller/ContactControllerSend.dart';
import '../view/Money_Transfer/Controller/MbagNumberController.dart';
import '../view/Trader/Controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => BasePinputController());
    Get.lazyPut(() => TransactionController());
    Get.lazyPut(() => QRCodeScannerController());
    Get.lazyPut(() => NestedTabBarController());
    Get.lazyPut(() => CountryController());
    Get.lazyPut(() => BaseMyTimerController());
    Get.lazyPut(() => FastLoginController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => TraderController());
    Get.lazyPut(() => FirstScreen());
    Get.lazyPut(() => HomeControllerGetData());
    Get.lazyPut(() => LocationController());
    Get.lazyPut(() => ReceiveQrPaymentController());
    Get.lazyPut(() => AmountSendController());
    Get.lazyPut(() => ContactControllerSend());
    Get.lazyPut(() => ContactControllerSendRequest());
    Get.lazyPut(() => MbagNumberController());
  }
}
