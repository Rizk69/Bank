import 'package:MBAG/view/Location/Screens/Location%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/HelperScreenNerst.dart';

class DepositAndWithdraw extends StatelessWidget {
  DepositAndWithdraw(
      {Key? key, required this.balance, required this.accountNumber})
      : super(key: key);
  String balance;
  String accountNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                const ImageIcon(
                  AssetImage('Assets/images/Vector(9).png'),
                  color: Colors.black,
                  size: 30,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  balance,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  'MBAG Number:  ',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '${accountNumber}',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
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
        ),
      ],
    );
  }
}
