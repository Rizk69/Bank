import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helper/Dark/SettingsController.dart';
import '../model/HomeModel.dart';

class ItemsFirstHome extends StatelessWidget {
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;
  final VoidCallback onPressed3;
  CurrencyHomeModel currency;

  ItemsFirstHome(
      {Key? key,
      required this.onPressed1,
      required this.onPressed2,
      required this.onPressed3,
      required this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: onPressed1,
              child: Container(
                height: 33.h,
                padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 3.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: settingsController.isDarkMode.value
                        ? Colors.black
                        : Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.5, 1.5),
                          blurRadius: 3,
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 0.1,
                          color: Colors.grey)
                    ]),
                child: Row(
                  children: [
                    ImageIcon(
                      AssetImage('Assets/images/Vector(6).png'),
                      size: 17.h,
                      color: Color(0XFF3BC7BE),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text('\$100')
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: onPressed2,
              child: Container(
                height: 33.h,
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 3.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: settingsController.isDarkMode.value
                        ? Colors.black
                        : Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.5, 1.5),
                          blurRadius: 3,
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 0.1,
                          color: Colors.grey)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(currency.abbreviation ?? '',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 8,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          currency.img ?? '',
                          height: 25.h,
                          width: 25.h,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox(),
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(currency.name ?? '',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.expand_more, color: Colors.grey, size: 18),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: onPressed3,
              child: Container(
                height: 33.h,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: settingsController.isDarkMode.value
                        ? Colors.black
                        : Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.5, 1.5),
                          blurRadius: 3,
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 0.1,
                          color: Colors.grey)
                    ]),
                child: ImageIcon(AssetImage('Assets/images/bx_chat.png')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// currency.id==1?
