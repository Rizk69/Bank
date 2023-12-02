import 'dart:async';

import 'package:bank/Core/widgets/Styles.dart';
import 'package:bank/helper/Data.dart';
import 'package:bank/view/Transaction/controller/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccountTransactions extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());
  TextEditingController searchController = TextEditingController();

  AccountTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 23,
                          color: Colors.black,
                        )),
                    Center(
                        child: Text('Account Transactions',
                            style: Styles.textStyleTitle24
                                .copyWith(fontSize: 22))),
                    Column(
                      children: [
                        Icon(Icons.file_download_outlined),
                        Text(
                          'Download',
                          style: Styles.textStyleTitle12.copyWith(fontSize: 10),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                TextFormField(
                  controller: searchController,
                  onChanged: (query) {
                    _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      controller.update();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Keywords ( at least 3 character )',
                    hintStyle: TextStyle(fontSize: 17),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search_sharp, color: Colors.grey),
                    // prefixIcon: ,
                  ), // textInputAction: textInputAction,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 28.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      width: 300.w,
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
                              Text('Account Type',
                                  style: Styles.textStyleTitle12),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'All',
                                style: Styles.textStyleTitle14
                                    .copyWith(fontSize: 20),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_downward)
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.filter_alt_rounded),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Filter',
                          style: Styles.textStyleTitle12.copyWith(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                    itemCount: controller.transactionData.length ?? 0,
                    itemBuilder: (context, index) {
                      var transaction = controller.transactionData[index];
                      bool isNewHeader = index == 0 ||
                          transaction.createdAt !=
                              controller.transactionData[index - 1].createdAt;
                      String formattedDate =
                          DateUtilsFormat.formatTransactionDate(
                              transaction.createdAt);

                      return Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            if (isNewHeader)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    formattedDate ?? 'Unknown Date',
                                    style: Styles.textStyleTitle12.copyWith(
                                          fontWeight: FontWeight.w400,
                                          // Customize the header text style
                                        ) ??
                                        TextStyle(), // Handle the case where textStyleTitle14 is null
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
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
                                          return Container(
                                            width: 50.w,
                                            height: 55.h,
                                            color: Colors
                                                .black, // Placeholder color or alternative content
                                            // You can also show an alternative image here
                                            // child: Image.asset('assets/error_placeholder.png'),
                                          );
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
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Timer? _debounce;
}
