import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Core/widgets/Styles.dart';

class CashbackScreen extends StatelessWidget {
  const CashbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(19.0),
        child: SingleChildScrollView(
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
                    'Cashback ',
                    style: Styles.textStyleTitle24,
                  ),
                  const ImageIcon(
                    AssetImage('Assets/images/carbon_settings.png'),
                    size: 25,
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 150.h,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Container(
                          height: 80.h,
                          width: 80.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border:
                                Border.all(color: Color(0XffE0E0E0), width: 1),
                          ),
                          child: Center(
                              child: Image.asset(
                            'Assets/images/Ellipse 1108.png',
                            height: 40,
                            width: 40,
                          )),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          'mama',
                          style: Styles.textStyleTitle14.copyWith(
                              color: Color(0Xff6A6969),
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '10%',
                          style: Styles.textStyleTitle14.copyWith(
                              color: Color(0Xff44CF52),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  itemCount: 15,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text('Your total earning this month ',
                  style: Styles.textStyleTitle16.copyWith(
                      color: Color(0XFF565656), fontWeight: FontWeight.w400)),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ImageIcon(
                    AssetImage('Assets/images/Vector(9).png'),
                    size: 30,
                  ),
                  SizedBox(
                    width: 7.h,
                  ),
                  Text("200",
                      style: Styles.textStyleTitle24.copyWith(fontSize: 33)),
                ],
              ),
              SizedBox(
                height: 13.h,
              ),
              Text('Your total earning to date 23-11',
                  style: Styles.textStyleTitle12.copyWith(
                      color: Color(0XFF565656), fontWeight: FontWeight.w400)),
              SizedBox(
                height: 24.h,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('CATEGORIES',
                      style: Styles.textStyleTitle16.copyWith(
                        color: Color(0XFF565656),
                        fontWeight: FontWeight.w500,
                      ))),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 100.h,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      height: 90.h,
                      width: 250.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0XffA6ABBD), width: 1),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'Assets/images/Ellipse 1108.png',
                            height: 42,
                            width: 42,
                          ),
                          SizedBox(
                            width: 15.h,
                          ),
                          Text(
                            'Pharmacy',
                            style: Styles.textStyleTitle16
                                .copyWith(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: 15,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('BRANDS ',
                      style: Styles.textStyleTitle16.copyWith(
                        color: Color(0XFF565656),
                        fontWeight: FontWeight.w500,
                      ))),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 230.h,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 56, vertical: 20),
                      height: 200.h,
                      width: 360.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0XffA6ABBD), width: 1),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'Assets/images/Ellipse 1108.png',
                            height: 60,
                            width: 60,
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          Text(
                            'Pharmacy',
                            style: Styles.textStyleTitle20.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Color(0XFF6A6969)),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Row(
                            children: [
                              Text(
                                '10%',
                                style: Styles.textStyleTitle16.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFF44CF52)),
                              ),
                              Text(
                                '  Instant cashback',
                                style: Styles.textStyleTitle16.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFF6A6969)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: 15,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'Assets/images/carbon_terminal-3270.png',
                    height: 27,
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Text(
                    'Terms of use',
                    style: Styles.textStyleTitle16
                        .copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
