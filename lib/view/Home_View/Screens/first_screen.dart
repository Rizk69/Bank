import 'package:bank/Core/cache_helper.dart';
import 'package:bank/Core/widgets/Navigation/navigation.dart';
import 'package:bank/Core/widgets/Styles.dart';
import 'package:bank/view/Transaction/Screen/Account_transactions_Screens.dart';
import 'package:bank/view/Home_View/Widget/App_Bar_First_Home.dart';
import 'package:bank/view/Home_View/Widget/Deposit_WitDraw.dart';
import 'package:bank/view/Home_View/Widget/Items_First_Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBarFirstHome(),
            SizedBox(
              height: 10.h,
            ),
            ItemsFirstHome(
                onPressed1: () {},
                onPressed2: () {
                  _showBottomSheet(context, '');
                },
                onPressed3: () {
                  var token = CacheHelper.getDataSharedPreference(key: 'token');
                  print('token===>$token');
                }),
            SizedBox(
              height: 25.h,
            ),
            DepositAndWithdraw(),
            SizedBox(
              height: 25.h,
            ),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.1,
                        blurRadius: 8,
                        offset: Offset(1, 0.5))
                  ],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1.5)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: ImageIcon(
                          AssetImage(
                            'Assets/images/line-md_account.png',
                          ),
                          color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Profile Photo',
                          style: Styles.textStyleTitle16,
                        ),
                        Text(
                          'You can add photo',
                          style: Styles.textStyleTitle12,
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.navigate_next_outlined,
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            InkWell(
              onTap: () {
                Get.to(AccountTransactions());
              },
              child: Row(
                children: [
                  Text(
                    'ACCOUNT TRANSACTION',
                    style: Styles.textStyleTitle16,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.navigate_next_outlined,
                    color: Colors.black,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String content) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(content),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close Bottom Sheet'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
