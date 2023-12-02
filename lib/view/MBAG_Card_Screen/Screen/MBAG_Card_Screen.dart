import 'package:bank/Core/widgets/Styles.dart';
import 'package:bank/view/MBAG_Card_Screen/Widget/Card.dart';
import 'package:bank/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            MbagCard(image: 'Assets/images/Vector(11).png', text: 'Bank card'),
            SizedBox(
              height: 30.h,
            ),
            MbagCard(
                image: 'Assets/images/Vector(10).png', text: 'credit card'),
            Spacer(),
            Buttoms(
              text: 'New Card',
              color: Color(0XFFFFFFFF),
              onPressed: () {},
              colorText: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
