import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/widgets/Styles.dart';

class MbagCard extends StatelessWidget {
  String image;
  String text;

  MbagCard({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
              height: 35,
              width: 35,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ImageIcon(AssetImage(image), color: Colors.white),
              ),
            ),
            SizedBox(
              width: 15.h,
            ),
            Text(
              text,
              style: Styles.textStyleTitle20,
            ),
            Spacer(),
            Icon(Icons.navigate_next_outlined)
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Color(0XFFA6ABBD),
        )
      ],
    );
  }
}
