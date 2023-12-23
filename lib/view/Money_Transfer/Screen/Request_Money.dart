import 'package:MBAG/view/Money_Transfer/Widget/NestedTabBarReqest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Core/widgets/Styles.dart';

class RequestMoneyScreen extends StatelessWidget {
  const RequestMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  icon: const Icon(Icons.arrow_back, size: 28),
                ),
                Text(
                  'Request Money',
                  style: Styles.textStyleTitle24,
                ),
                const ImageIcon(
                  AssetImage('Assets/images/exclamation.png'),
                  size: 20,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: NestedTabBarRequest())
          ],
        ),
      ),
    );
  }
}
