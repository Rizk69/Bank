import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Core/widgets/Styles.dart';
import '../Widget/NestedTabBarSend.dart';

class SendMoneyScreen extends StatelessWidget {
  const SendMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(19),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back, size: 28),
                ),
                Text(
                  'Send Money',
                  style: Styles.textStyleTitle24,
                ),
                ImageIcon(
                  AssetImage('Assets/images/exclamation.png'),
                  size: 20,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: NestedTabBar())
          ],
        ),
      ),
    );
  }
}
