import 'package:bank/Core/widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
                Text(
                  'Account Details',
                  style: Styles.textStyleTitle24
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox()
              ],
            ),
            SizedBox(
              height: 42.h,
            ),
            Row(
              children: [
                SizedBox(
                  height: 100.h,
                  width: 110.h,
                  child: Stack(
                    children: [
                      Container(
                        width: 100.h,
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0XFF8B959E),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ImageIcon(
                            AssetImage(
                              'Assets/images/line-md_account.png',
                            ),
                            size: 70,
                            color: Colors.white),
                      ),
                      Positioned(
                        left: 70.h,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(Icons.camera_alt_outlined,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fatih Mahmutoglu',
                      style: Styles.textStyleTitle16
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '+9068468368756',
                      style: Styles.textStyleTitle16.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0Xff6A6969)),
                    ),
                    Text(
                      'Fatihmahmutoglu80@gmail.com',
                      style: Styles.textStyleTitle16.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0Xff6A6969),
                          overflow: TextOverflow.visible),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 31.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Account Type', style: Styles.textStyleTitle12),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Turkish Lira Account',
                        style: Styles.textStyleTitle14.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 30,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 11),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account type',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Unverified Approved or Verified',
                              style: Styles.textStyleTitle14.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0XFF565656))),
                        ],
                      ),
                      Text(
                        'Verified Account',
                        style: Styles.textStyleTitle16
                            .copyWith(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0XFFD9D9D9), width: 0.5)),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 11),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account type',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Unverified Approved or Verified',
                              style: Styles.textStyleTitle14.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0XFF565656))),
                        ],
                      ),
                      Text(
                        'Verified Account',
                        style: Styles.textStyleTitle16
                            .copyWith(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0XFFD9D9D9), width: 0.5)),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 11),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account type',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Unverified Approved or Verified',
                              style: Styles.textStyleTitle14.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0XFF565656))),
                        ],
                      ),
                      Text(
                        'Verified Account',
                        style: Styles.textStyleTitle16
                            .copyWith(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0XFFD9D9D9), width: 0.5)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
