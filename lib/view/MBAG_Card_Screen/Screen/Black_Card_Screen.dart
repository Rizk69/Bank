import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/view/MBAG_Card_Screen/Screen/ChangeCardPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Transaction/Screen/Account_transactions_Screens.dart';
import '../Controller/BlackCardController.dart';

class BlackCard extends StatelessWidget {
  BlackCard({Key? key}) : super(key: key);
  final MySwitchController _controller = Get.put(MySwitchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    )),
                Center(
                    child: Text(
                  'Black card ',
                  style: Styles.textStyleTitle24.copyWith(fontSize: 26),
                )),
                SizedBox()
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'Assets/images/IDCard.png',
                  height: 150.h,
                  width: 102.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      width: 273.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Color(0XFFA6ABBD),
                        width: 0.5,
                      )),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'Fatih Mahmutoglu',
                      style: Styles.textStyleTitle16,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      '7349068468368756',
                      style: Styles.textStyleTitle16.copyWith(
                          color: Color(0XFF6A6969),
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'SKT 04/27 - cvv 780',
                      style: Styles.textStyleTitle16.copyWith(
                          color: Color(0XFFA6ABBD),
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildAccountTransactionRow(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                '',
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Icon(Icons.account_circle, size: 40),
                                  );
                                },
                                fit: BoxFit.fill,
                                height: 55.h,
                                width: 50.w,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Play Store',
                                    style: Styles.textStyleTitle14),
                                SizedBox(height: 5),
                                Text(
                                  'MBAG card',
                                  style: Styles.textStyleTitle14.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const ImageIcon(
                                  AssetImage('Assets/images/Vector(9).png'),
                                  color:
                                      -1 >= 0 ? Color(0XFF4FD25D) : Colors.red,
                                ),
                                SizedBox(width: 7.h),
                                Text(
                                  "${13}",
                                  style: Styles.textStyleTitle24.copyWith(
                                    color: -1 >= 0
                                        ? Color(0XFF4FD25D)
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'formattedDate' ?? 'Unknown Date',
                                  style: Styles.textStyleTitle12
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                '',
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Icon(Icons.account_circle, size: 40),
                                  );
                                },
                                fit: BoxFit.fill,
                                height: 55.h,
                                width: 50.w,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Play Store',
                                    style: Styles.textStyleTitle14),
                                SizedBox(height: 5),
                                Text(
                                  'MBAG card',
                                  style: Styles.textStyleTitle14.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const ImageIcon(
                                  AssetImage('Assets/images/Vector(9).png'),
                                  color:
                                      -1 >= 0 ? Color(0XFF4FD25D) : Colors.red,
                                ),
                                SizedBox(width: 7.h),
                                Text(
                                  "${13}",
                                  style: Styles.textStyleTitle24.copyWith(
                                    color: -1 >= 0
                                        ? Color(0XFF4FD25D)
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'formattedDate' ?? 'Unknown Date',
                                  style: Styles.textStyleTitle12
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0XFFA6ABBD),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enabled to Use',
                          style: Styles.textStyleTitle20
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Obx(() => MySwitchWidget(
                              isSwitched: _controller.isSwitched.value,
                              onToggle: _controller.isSwitched,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0XFFA6ABBD),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Contactless Payment',
                          style: Styles.textStyleTitle20
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Obx(() => MySwitchWidget(
                              isSwitched: _controller.isSwitched1.value,
                              onToggle: _controller.isSwitched1,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0XFFA6ABBD),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Online Payments',
                          style: Styles.textStyleTitle20
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Obx(() => MySwitchWidget(
                              isSwitched: _controller.isSwitched2.value,
                              onToggle: _controller.isSwitched2,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0XFFA6ABBD),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subscriptions',
                          style: Styles.textStyleTitle20
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 28,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0XFFA6ABBD),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Spending Limit',
                              style: Styles.textStyleTitle20
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text('MBAG card limit equal to your MBAG balance ',
                                style: Styles.textStyleTitle12.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0XFF6A6969)))
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 28,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0XFFA6ABBD),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ChangeCardPassword());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Change Card Password',
                            style: Styles.textStyleTitle20
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 28,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0XFFA6ABBD),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cancel Card ',
                          style: Styles.textStyleTitle20
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 28,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAccountTransactionRow() {
    return InkWell(
      onTap: () {
        Get.to(() => AccountTransactions());
      },
      child: _buildListTile('ACCOUNT TRANSACTION'),
    );
  }

  Widget _buildListTile(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Styles.textStyleTitle16.copyWith(
                color: Color(0XFF979797), fontWeight: FontWeight.w400)),
        SizedBox(width: 4),
        Icon(Icons.navigate_next_outlined, color: Colors.black),
      ],
    );
  }
}

class MySwitchWidget extends StatelessWidget {
  final bool isSwitched;
  final Function(bool) onToggle;

  MySwitchWidget({required this.isSwitched, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: onToggle,
      activeTrackColor: Colors.blue,
      activeColor: Colors.white,
    );
  }
}
