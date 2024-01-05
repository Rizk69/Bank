import 'dart:async';

import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/helper/Data.dart';
import 'package:MBAG/view/Transaction/controller/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../helper/Dark/SettingsController.dart';
import '../../QrTransaction/model/ScanModel.dart';

class AccountTransactions extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());
  final SettingsController settingsController = Get.find();

  AccountTransactions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    controller.getDataCurrencyUser();

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
                          color: settingsController.isDarkMode.value
                              ? Colors.white
                              : Colors.black,
                        )),
                    Center(
                        child: Text('Account Transactions',
                            style: Styles.textStyleTitle24
                                .copyWith(fontSize: 22))),
                    InkWell(
                      onTap: () {
                        Get.snackbar('Coming Soon', '',
                            colorText: Colors.white,
                            backgroundColor: Colors.green);
                      },
                      child: Column(
                        children: [
                          Icon(Icons.file_download_outlined),
                          Text(
                            'Download',
                            style:
                                Styles.textStyleTitle12.copyWith(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                TextFormField(
                  controller: controller.searchController,
                  onChanged: (query) {
                    _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      controller.update();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Keywords ( at least 3 character )',
                    hintStyle: const TextStyle(fontSize: 17),
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
                    prefixIcon:
                        const Icon(Icons.search_sharp, color: Colors.grey),
                  ), // textInputAction: textInputAction,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 28.h,
                ),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context, controller.currenciesList);
                  },
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          width: 300.w,
                          decoration: BoxDecoration(
                            color: settingsController.isDarkMode.value
                                ? Colors.black
                                : Colors.white,
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
                                    controller.selectedCurrency.value?.name ??
                                        '',
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
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1,
                  child: Obx(() => controller.transactionData.isEmpty
                      ? const SizedBox()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height / 1.9,
                          child: controller.isLoading.value
                              ? Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: controller.transactionData.length,
                                  itemBuilder: (context, index) {
                                    var transaction =
                                        controller.transactionData[index];
                                    bool isNewHeader = index == 0 ||
                                        transaction.createdAt !=
                                            controller
                                                .transactionData[index - 1]
                                                .createdAt;
                                    String formattedDate = transaction
                                                .createdAt !=
                                            null
                                        ? DateUtilsFormat.formatTransactionDate(
                                            transaction.createdAt!)
                                        : '';

                                    return Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          if (isNewHeader)
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  formattedDate ??
                                                      'Unknown Date',
                                                  style: Styles.textStyleTitle12
                                                      .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                  ), // Handle the case where textStyleTitle14 is null
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller.getTransactionsDetails(
                                                  id: "${transaction.id}");
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Image.network(
                                                        transaction
                                                                .receiverImg ??
                                                            '',
                                                        errorBuilder:
                                                  (BuildContext
                                                                    context,
                                                                Object error,
                                                                StackTrace?
                                                                    stackTrace) {
                                                return ClipRRect(
                                                  borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            child:
                                                                const SizedBox(
                                                              height: 45,
                                                              width: 45,
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .account_circle,
                                                                  size: 45,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                              },
                                              fit: BoxFit.fill,
                                              height: 45,
                                              width: 45,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                  transaction
                                                      .receiverFirstName ??
                                                      '',
                                                  style: Styles
                                                      .textStyleTitle14),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                transaction
                                                    .receiverLastName ??
                                                    "",
                                                style: Styles
                                                    .textStyleTitle14
                                                    .copyWith(
                                                    fontSize: 13,
                                                    fontWeight:
                                                    FontWeight
                                                        .w400),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                                        Text(
                                                "${transaction.finalAmount ?? '0'}",
                                                style: Styles
                                                    .textStyleTitle24
                                                    .copyWith(
                                                  color: transaction
                                                                            .finalAmount !=
                                                                        null &&
                                                                    transaction
                                                                            .finalAmount! >=
                                                                        0
                                                                ? Color(
                                                                    0XFF4FD25D)
                                                                : Colors.red,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 7.h,
                                                        ),
                                                        Text(
                                                          transaction
                                                                  .abbreviation ??
                                                              '',
                                                          style: Styles
                                                              .textStyleTitle18
                                                              .copyWith(
                                                            color: transaction
                                                                            .finalAmount !=
                                                                        null &&
                                                                    transaction
                                                                            .finalAmount! >
                                                                        0
                                                                ? Color(
                                                                    0XFF4FD25D)
                                                                : Colors.red,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Timer? _debounce;

  void _showBottomSheet(
    BuildContext context,
    List<Currency> currencies,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: settingsController.isDarkMode.value
                  ? Colors.black38
                  : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            child: Column(
              children: [
                Text(
                  'Select Currency',
                  style: Styles.textStyleTitle24.copyWith(fontSize: 30),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    controller.selectedCurrency.value = Currency(
                        id: 0,
                        abbreviation: 'abbreviation',
                        name: 'All',
                        img: '');
                    controller.update();
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('All', style: Styles.textStyleTitle18),
                    ),
                  ),
                ),
                Container(
                  height: 0.5,
                  padding: EdgeInsets.symmetric(vertical: 30),
                  margin: EdgeInsets.only(
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade700, width: 0.2)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.selectedCurrency(currencies[index]);
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Text(currencies[index].abbreviation ?? '',
                                      style: Styles.textStyleTitle12
                                          .copyWith(color: Colors.grey)),
                                  SizedBox(
                                    width: 20,
                                    child: Center(child: Text('--')),
                                  ),
                                  Text(currencies[index].name ?? '',
                                      style: Styles.textStyleTitle14),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          Container(
                            height: 0.5,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade700, width: 0.2)),
                          ),
                        ],
                      );
                    },
                    itemCount: currencies.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
