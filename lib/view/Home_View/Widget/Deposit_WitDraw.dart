import 'package:bank/view/Location/Screens/Location%20Screen.dart';
import 'package:bank/view/Location/Screens/NearestBranch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepositAndWithdraw extends StatelessWidget {
  DepositAndWithdraw({Key? key, required this.balance}) : super(key: key);
  String balance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {},
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
            Text(
              '\$$balance',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Papara Number:  ',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '1854321733',
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
            Get.to(() => NearestBranch());
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
