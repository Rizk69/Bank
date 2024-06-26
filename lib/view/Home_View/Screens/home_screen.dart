import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/helper/Dark/SettingsController.dart';
import 'package:MBAG/view/Home_View/controller/HomeGetData.dart';
import 'package:MBAG/view/Money_Transfer/Screen/Send_Money.dart';
import 'package:MBAG/view/QrTransaction/Screen/Recevive_Qr_Payment.dart';
import 'package:MBAG/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/HelperScreenNerst.dart';
import '../../Money_Transfer/Controller/ContactControllerSend.dart';
import '../../QrTransaction/Screen/Qr_Scan_Screen.dart';
import '../controller/contoller_home.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());
  final SettingsController settingsController = Get.find();
  final HomeControllerGetData _homeControllerGetData =
      Get.put(HomeControllerGetData());
  final ContactControllerSend contactController =
      Get.put(ContactControllerSend());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (homeController) => Scaffold(
        body: homeController.currentScreen,
        bottomNavigationBar: bottomNavigationBar(context),
      ),
    );
  }

  Widget bottomNavigationBar(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (homeControllerBottomNav) => Obx(
        () => BottomNavigationBar(
          elevation: 0,
          backgroundColor:
              settingsController.isDarkMode.value ? Colors.black : Colors.white,
          selectedItemColor:
              settingsController.isDarkMode.value ? Colors.white : Colors.grey,
          unselectedItemColor:
              settingsController.isDarkMode.value ? Colors.grey : Colors.black,
          currentIndex: homeControllerBottomNav.currentIndex,
          onTap: (index) {
            homeControllerBottomNav.changeIndex(index);
            if (index == 1) {
              _showBottomSheetQr(context, 'Bottom Sheet ${index + 1}');
            } else if (index == 2) {
              _showBottomSheet(context, 'Bottom Sheet ${index + 1}');
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('Assets/images/Vector(1).png')),
              label: 'Home'.tr,
            ),
            BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('Assets/images/Vector(2).png')),
              label: 'QR Transaction'.tr,
            ),
            BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('Assets/images/Vector(3).png')),
              label: 'Money Transfer'.tr,
            ),
            BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('Assets/images/Vector(4).png')),
              label: 'Payments'.tr,
            ),
            BottomNavigationBarItem(
              icon: const ImageIcon(AssetImage('Assets/images/Vector(5).png')),
              label: 'MBAG Card'.tr,
            ),
          ],
        ),
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
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: settingsController.isDarkMode.value
                      ? Colors.black
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15)),
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
                            Expanded(
                              child: Text('send_money_qr'.tr,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.textStyleTitle18
                                      .copyWith(fontWeight: FontWeight.w700)),
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
                        Get.to(() => ReceiveQrPaymentScreen());
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
                            Expanded(
                              child: Text('Receive payment with QR code',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.textStyleTitle18
                                      .copyWith(fontWeight: FontWeight.w700)),
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
                        Get.to(() => SlideDownTextAnimation(
                              appBarView: true,
                            ));
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
              height: 10,
            )
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
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: settingsController.isDarkMode.value
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                width: double.infinity,
                child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.to(() => const SendMoneyScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.send_outlined,
                                size: 25,
                              ),
                              const SizedBox(
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
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 1,
                      decoration: const BoxDecoration(color: Color(0xffA6ABBD)),
                    ),
                    InkWell(
                        onTap: () {
                          Get.to(() => SlideDownTextAnimation(
                                appBarView: true,
                              ));
                          // Get.to(RequestMoneyScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.reply_all,
                                size: 25,
                              ),
                              const SizedBox(
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
                      decoration: const BoxDecoration(color: Color(0xffA6ABBD)),
                    ),
                    InkWell(
                        onTap: () {
                          Get.to(() => SlideDownTextAnimation(
                                appBarView: true,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.interpreter_mode,
                                size: 25,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'International Money transfer',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Styles.textStyleTitle18
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Container(
                      width: double.infinity,
                      height: 1,
                      decoration: const BoxDecoration(color: Color(0xffA6ABBD)),
                    ),
                    InkWell(
                        onTap: () {
                          Get.to(() => SlideDownTextAnimation(
                                appBarView: true,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.refresh_outlined,
                                size: 25,
                              ),
                              const SizedBox(
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Buttoms(
                    text: 'Cancel',
                    color: Colors.black,
                    onPressed: () {
                      Get.back();
                    },
                    colorText: Colors.white),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }
}
