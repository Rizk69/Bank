import 'package:bank/view/Auth_View/Login/Controller/Login_Controller.dart';
import 'package:bank/view/Auth_View/Login/Controller/PinController.dart';
import 'package:bank/view/Home_View/controller/contoller_home.dart';
import 'package:bank/view/Money_Transfer/Controller/NestedTapController.dart';
import 'package:bank/view/QrTransaction/Controller/QrController.dart';
import 'package:bank/view/Transaction/controller/transaction_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeControllerBottomNav());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => PinputController());
    Get.lazyPut(() => TransactionController());
    Get.lazyPut(() => QRCodeScannerController());
    Get.lazyPut(() => NestedTabBarController());
  }
}
