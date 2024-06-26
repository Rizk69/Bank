import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/widgets/Styles.dart';

class ItemsAccountDetails extends StatelessWidget {
  String title;
  String des;
  String caption;

  ItemsAccountDetails(
      {Key? key, required this.title, required this.des, required this.caption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 11.w),
      // Responsive padding
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // Use Expanded for text to prevent overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Styles.textStyleTitle16.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp, // Responsive font size
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(des,
                        style: Styles.textStyleTitle12.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp, // Responsive font size
                            overflow: TextOverflow.ellipsis,
                            color: const Color(0XFF565656))),
                  ],
                ),
              ),
              SizedBox(width: 8.w), // Responsive spacing
              Text(
                caption,
                style: Styles.textStyleTitle14.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp, // Responsive font size
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 1.h, // Responsive height
            decoration: BoxDecoration(
                border: Border.all(color: Color(0XFFD9D9D9), width: 0.5)),
          )
        ],
      ),
    );
  }
}
