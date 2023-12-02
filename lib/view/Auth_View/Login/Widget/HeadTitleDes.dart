import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadFirstTitle extends StatelessWidget {
  String title;
  String des;

  HeadFirstTitle({Key? key, required this.title, required this.des})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
          title,
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        )),
        SizedBox(
          height: 8.h,
        ),
        Center(
            child: Text(
          des,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
        )),
      ],
    );
  }
}
