import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helper/Data.dart';
import '../model/transaction_model.dart';

class AccountTransActonDetails extends StatelessWidget {
  TransactionDetails transactionDetails;
  bool notification;

  AccountTransActonDetails(
      {super.key,
      required this.transactionDetails,
      required this.notification});

  @override
  Widget build(BuildContext context) {
    String formattedDate = transactionDetails.createdAt != null
        ? DateUtilsFormat.formatTransactionDateNumber(
            transactionDetails.createdAt!)
        : '';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      notification
                          ? Get.offAllNamed('/HomeScreen')
                          : Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    )),
                Text(
                  'TransActonDetails',
                  style: Styles.textStyleTitle24
                      .copyWith(fontSize: 23, fontStyle: FontStyle.normal),
                ),
                SizedBox(
                  width: 40,
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('Assets/images/Logo Mbag without background 5.png',
                    height: 150),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    'Receipt',
                    style: Styles.textStyleTitle16
                        .copyWith(color: Color(0Xff6A6969)),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Date of issue : ',
                          style: Styles.textStyleTitle14.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF979797))),
                      Text(formattedDate,
                          style: Styles.textStyleTitle14.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF979797))),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Transaction No :',
                          style: Styles.textStyleTitle14.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF979797))),
                      Text('',
                          style: Styles.textStyleTitle14.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF979797))),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Money Transfer',
                    style: Styles.textStyleTitle16,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            detailsData(
                color: Color(0XFFF8F8F8), title: 'Date', value: formattedDate),
            detailsData(
                color: Colors.white,
                title: 'Name Surname',
                value:
                    "${transactionDetails.senderFirstName} ${transactionDetails.senderLastName}"),
            detailsData(
                color: Color(0XFFF8F8F8),
                title: 'Recipient',
                value: "${transactionDetails.receiverFirstName}"),
            detailsData(
                color: Colors.white,
                title: 'Recipient MBAG No ',
                value: "${transactionDetails.receiverID}"),
            detailsData(
                color: Color(0XFFF8F8F8),
                title: 'Transaction Amount',
                value:
                    "${transactionDetails.finalAmount} ${transactionDetails.abbreviation}"),
            // detailsData(color:Colors.white ,title:'Transaction Fee' ,value:'' ),
            // detailsData(color:Color(0XFFF8F8F8) ,title:'Amount' ,value:'' ),
            // detailsData(color:Colors.white ,title:'Description' ,value:'' ),
          ],
        ),
      ),
    );
  }

  Widget detailsData(
      {required Color color, required String title, required String value}) {
    return Container(
      height: 60,
      color: color,
      //const Color(0XFFF8F8F8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: Styles.textStyleTitle14.copyWith(
                    fontWeight: FontWeight.w700, color: Color(0XFF979797))),
            Text(value,
                style: Styles.textStyleTitle14.copyWith(
                    fontWeight: FontWeight.w400, color: Color(0XFF979797))),
          ],
        ),
      ),
    );
  }
}