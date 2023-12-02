import 'package:bank/Core/cache_helper.dart';
import 'package:bank/Core/widgets/Navigation/navigation.dart';
import 'package:bank/Core/widgets/Styles.dart';
import 'package:bank/view/Home_View/Screens/Cashback_Screen.dart';
import 'package:bank/view/Transaction/Screen/Account_transactions_Screens.dart';
import 'package:bank/view/Home_View/Widget/App_Bar_First_Home.dart';
import 'package:bank/view/Home_View/Widget/Deposit_WitDraw.dart';
import 'package:bank/view/Home_View/Widget/Items_First_Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helper/Data.dart';
import '../../Transaction/controller/transaction_controller.dart';

class FirstScreen extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());

  FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.update();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: SingleChildScrollView(
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
                    var token =
                        CacheHelper.getDataSharedPreference(key: 'token');
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
              ),
              GetBuilder<TransactionController>(
                initState: (_) {
                  controller.update();
                  controller.getTransactions();
                },
                builder: (controller) {
                  if (controller.isLoading.value) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.grey));
                  } else if (controller.transactionData.isEmpty) {
                    return const Center(
                        child: Text('No transactions available.'));
                  } else {
                    return SizedBox(
                      height: 230.h,
                      child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          var transaction = controller.transactionData[index];
                          bool isNewHeader = index == 0 ||
                              transaction.createdAt !=
                                  controller
                                      .transactionData[index - 1].createdAt;
                          String formattedDate =
                              DateUtilsFormat.formatTransactionDate(
                                  transaction.createdAt);

                          return Container(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        transaction.receiverImg,
                                        errorBuilder: (BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace) {
                                          // This function is called when an error occurs while loading the image
                                          return Text('Image not found');
                                        },
                                        fit: BoxFit.fill,
                                        height: 55.h,
                                        width: 50.w,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(transaction.receiverFirstName,
                                            style: Styles.textStyleTitle14),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          transaction.senderFirstName,
                                          style: Styles.textStyleTitle14
                                              .copyWith(
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
                                        ImageIcon(
                                          AssetImage(
                                              'Assets/images/Vector(9).png'),
                                          color: transaction.finalAmount >= 0
                                              ? Color(0XFF4FD25D)
                                              : Colors.red,
                                        ),
                                        SizedBox(
                                          width: 7.h,
                                        ),
                                        Text(
                                          "${transaction.finalAmount}",
                                          style: Styles.textStyleTitle24
                                              .copyWith(
                                                  color:
                                                      transaction.finalAmount >=
                                                              0
                                                          ? Color(0XFF4FD25D)
                                                          : Colors.red),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          formattedDate ?? 'Unknown Date',
                                          style: Styles.textStyleTitle12
                                                  .copyWith(
                                                fontWeight: FontWeight.w400,
                                                // Customize the header text style
                                              ) ??
                                              TextStyle(), // Handle the case where textStyleTitle14 is null
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              InkWell(
                onTap: () {
                  Get.to(CashbackScreen());
                },
                child: Row(
                  children: [
                    Text(
                      'CASHBACK',
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
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 28),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0XFFEBEBEB), width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image(
                          image:
                              AssetImage('Assets/images/Clip path group.png'),
                          height: 40,
                          width: 30,
                        ),
                        SizedBox(
                          width: 13.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pharmacy',
                                style: Styles.textStyleTitle16
                                    .copyWith(fontWeight: FontWeight.w500)),
                            Text(
                              '10%',
                              style: Styles.textStyleTitle16.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0XFF86E08F)),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Image(
                          image:
                              AssetImage('Assets/images/Clip path group.png'),
                          height: 40,
                          width: 30,
                        ),
                        SizedBox(
                          width: 13.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('EcZane',
                                style: Styles.textStyleTitle16
                                    .copyWith(fontWeight: FontWeight.w500)),
                            Text(
                              'lorem epsim',
                              style: Styles.textStyleTitle16.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0XFF979797)),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
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
