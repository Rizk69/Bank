import 'package:bank/Core/widgets/Styles.dart';
import 'package:bank/view/QrTransaction/Screen/Recevive_Qr_Payment.dart';
import 'package:bank/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../QrTransaction/Screen/Qr_Scan_Screen.dart';
import '../controller/contoller_home.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerBottomNav>(
      init: HomeControllerBottomNav(),
      builder: (homeControllerBottomNav) => Scaffold(
        body: homeControllerBottomNav.currentScreen,
        bottomNavigationBar: bottomNavigationBar(context),
      ),
    );
  }

  Widget bottomNavigationBar(BuildContext context) {
    return GetBuilder<HomeControllerBottomNav>(
      init: HomeControllerBottomNav(),
      builder: (homeControllerBottomNav) => BottomNavigationBar(
        enableFeedback: true,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.black,
        currentIndex: homeControllerBottomNav.currentIndex,
        onTap: (index) {
          homeControllerBottomNav.changeIndex(index);
          if (index == 1) {
            _showBottomSheetQr(context, 'Bottom Sheet ${index + 1}');
          } else if (index == 2) {
            _showBottomSheet(context, 'Bottom Sheet ${index + 1}');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('Assets/images/Vector(1).png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('Assets/images/Vector(2).png')),
            label: 'QR Transaction ',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('Assets/images/Vector(3).png')),
            label: 'Money Transfer ',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('Assets/images/Vector(4).png')),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('Assets/images/Vector(5).png')),
            label: 'MBAG Card',
          ),
        ],
      ),
    );
  }

  void _showBottomSheetQr(BuildContext context, String content) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(QRCodeScannerView());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.qr_code_2_outlined,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Pay with QR code',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xffA6ABBD)),
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(const ReceiveQrPaymentScreen(idNumber: ''));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.qr_code_2_outlined,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Receive payment with QR code  ',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xffA6ABBD)),
                  ),
                  InkWell(
                      onTap: () {
                        // Get.to(QrPay());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.qr_code_2_outlined,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Withdraw cash from ATM',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Buttoms(
                  text: 'Cancel',
                  color: Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                  colorText: Colors.white),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, String content) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        // Get.to();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.send_outlined,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Send Money',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xffA6ABBD)),
                  ),
                  InkWell(
                      onTap: () {
                        // Get.to(QrPay());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.reply_all,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Request Money',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xffA6ABBD)),
                  ),
                  InkWell(
                      onTap: () {
                        // Get.to(QrPay());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.interpreter_mode,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'International Money transfer',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xffA6ABBD)),
                  ),
                  InkWell(
                      onTap: () {
                        // Get.to(QrPay());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.refresh_outlined,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Recurrig transfer',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Buttoms(
                  text: 'Cancel',
                  color: Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                  colorText: Colors.white),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        );
      },
    );
  }
}
