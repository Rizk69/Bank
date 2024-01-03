import 'package:MBAG/view/Location/Screens/Location%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../helper/Dark/SettingsController.dart';
import '../../../helper/HelperScreenNerst.dart';

class DepositAndWithdraw extends StatelessWidget {
  DepositAndWithdraw(
      {Key? key, required this.balance, required this.accountNumber})
      : super(key: key);
  String balance;
  String accountNumber;

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.to(() => SlideDownTextAnimation(
                    appBarView: true,
                  ));
            },
            child: Column(
              children: [
                ImageIcon(
                    AssetImage(
                      'Assets/images/Vector(8).png',
                    ),
                    size: 26,
                    color: Colors.red),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Witdraw',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  ImageIcon(
                    AssetImage('Assets/images/Vector(9).png'),
                    color: settingsController.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.8,
                    child: Center(
                      child: Text(
                        balance,
                        style: TextStyle(
                            color: settingsController.isDarkMode.value
                                ? Colors.white
                                : Colors.black,
                            fontSize: 37,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'MBAG Number:  ',
                    style: TextStyle(
                        fontSize: 14,
                        color: settingsController.isDarkMode.value
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: accountNumber));
                      // Optionally, show a message that the text has been copied.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Account number copied to clipboard'),
                        ),
                      );
                    },
                    child: Text(
                      '$accountNumber',
                      style: TextStyle(
                        fontSize: 14,
                        color: settingsController.isDarkMode.value
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          InkWell(
            onTap: () {
              Get.to(() => LocationScreen());
            },
            child: Column(
              children: [
                ImageIcon(AssetImage('Assets/images/icons8_plus.png'),
                    size: 34, color: Colors.green),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Deposit',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
