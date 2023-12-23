import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/view/MBAG_Card_Screen/Screen/Black_Card_Screen.dart';
import 'package:MBAG/view/MBAG_Card_Screen/Widget/Card.dart';
import 'package:MBAG/view/MBAG_Card_Screen/Widget/HelperScreen.dart';
import 'package:MBAG/view/MBAG_Card_Screen/Widget/ScreenSuccessfull.dart';
import 'package:MBAG/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MBAGCardScreen extends StatelessWidget {
  const MBAGCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'MBAG card',
          style: Styles.textStyleTitle24,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40.h,
            ),
            InkWell(
                onTap: () {
                  Get.to(BlackCard());
                },
                child: MbagCard(
                    image: 'Assets/images/Vector(11).png', text: 'Bank card')),
            SizedBox(
              height: 30.h,
            ),
            InkWell(
                onTap: () {
                  Get.to(ScreenSuccessfull());
                },
                child: MbagCard(
                    image: 'Assets/images/Vector(10).png',
                    text: 'credit card')),
            Spacer(),
            Buttoms(
              text: 'New Card',
              color: Color(0XFFFFFFFF),
              onPressed: () {
                Get.to(
                    SlideDownTextAnimation()); // Provide the correct route name
              },
              colorText: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
