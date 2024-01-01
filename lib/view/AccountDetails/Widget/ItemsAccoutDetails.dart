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
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 11),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Styles.textStyleTitle16
                          .copyWith(fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(des,
                      style: Styles.textStyleTitle12.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(0XFF565656))),
                ],
              ),
              Spacer(),
              Text(caption,
                  style: Styles.textStyleTitle14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis)
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0XFFD9D9D9), width: 0.5)),
          )
        ],
      ),
    );
  }
}
