import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Core/widgets/Styles.dart';

class DetailsCardScreen extends StatelessWidget {
  final String imageUrl;

  const DetailsCardScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            SizedBox(
              height: 70.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
                Text(
                  'MBAG card',
                  style: Styles.textStyleTitle24
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox()
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Image.network(imageUrl, fit: BoxFit.contain, height: 150.h),
          ],
        ),
      ),
    );
  }
}
