import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/view/Auth_View/Login/Widget/ButtomsNotBorder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helper/Dark/SettingsController.dart';
import '../../Home_View/controller/HomeGetData.dart';
import '../../QrTransaction/model/ScanModel.dart';
import '../Controller/AmountSendController.dart';

class AmountSendScreen extends StatelessWidget {
  final AmountSendController controller = Get.put(AmountSendController());
  final ApiResponseCheckScan model;
  String endPoint;
  final SettingsController settingsController = Get.find();

  AmountSendScreen({Key? key, required this.model, required this.endPoint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getDataCurrencyPhone();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back, size: 28),
                    ),
                    Text('Send Money', style: Styles.textStyleTitle24),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                Container(
                  height: 80.h,
                  width: 80.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border:
                    Border.all(color: const Color(0XffE0E0E0), width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(41),
                    child: Image.network(
                      model.receiver.img ?? '',
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Icon(Icons.account_circle, size: 60),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  model.receiver.firstName,
                  style: Styles.textStyleTitle16.copyWith(
                      color: settingsController.isDarkMode.value
                          ? Colors.white
                          : Color(0Xff6A6969),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 24.h,
                ),
                InkWell(
                  onTap: () {
                    _showBottomSheet(context, model.currencies);
                  },
                  child: Obx(
                        () => Container(
                      width: 180.w,
                      height: 33.h,
                      padding:
                      EdgeInsets.symmetric(horizontal: 30.h, vertical: 3.h),
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
                          Text(
                              controller.selectedCurrency.value?.abbreviation ??
                                  '',
                              style: TextStyle(
                                  color: settingsController.isDarkMode.value
                                      ? Colors.white
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 3,
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                controller.selectedCurrency.value?.img ?? '',
                                height: 25.h,
                                width: 25.h,
                                errorBuilder: (context, error, stackTrace) =>
                                const SizedBox(),
                              )),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                              controller.selectedCurrency.value?.name ??
                                  // abbreviation ??
                                  '',
                              style: TextStyle(
                                  color: settingsController.isDarkMode.value
                                      ? Colors.white
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.expand_more,
                              color: settingsController.isDarkMode.value
                                  ? Colors.white
                                  : Colors.grey,
                              size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.input.value,
                      style:
                      const TextStyle(fontSize: 36, color: Colors.grey),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      controller.selectedCurrency.value?.abbreviation ?? '',
                      style:
                      const TextStyle(fontSize: 36, color: Colors.grey),
                    ),
                  ],
                )),
                const SizedBox(height: 20),
                Center(
                    child: Text(
                      'Turkish Lira Balance ',
                      style: Styles.textStyleTitle14.copyWith(
                          color: settingsController.isDarkMode.value
                              ? Colors.white
                              : Color(0XFF6A6969)),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildNumberButton('1'),
                    buildNumberButton('2'),
                    buildNumberButton('3'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildNumberButton('4'),
                    buildNumberButton('5'),
                    buildNumberButton('6'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildNumberButton('7'),
                    buildNumberButton('8'),
                    buildNumberButton('9'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildFunctionButton('C', controller.clear),
                    buildNumberButton('0'),
                    buildFunctionButton(
                        '⌫', controller.delete), // Delete button
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ButtomsNotBorder(
                      text: 'continue',
                      color: Colors.black,
                      onPressed: () {
                        controller.input.value == "0"
                            ? Get.snackbar("Warning!", 'Please Enter Number',
                            colorText: Colors.white,
                            backgroundColor: Colors.red)
                            : controller.sendAmountMoney(
                            endPoint: endPoint,
                            receiverId:
                            model.receiver.receiverId.toString(),
                            currencyId:
                            "${controller.selectedCurrency.value?.id}",
                            amount: controller.input.value,
                            context: context);
                      },
                      colorText: Colors.white,
                      isFormValid: true.obs,
                      context: context,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNumberButton(String number) {
    final SettingsController settingsController = Get.find();

    return Obx(
      () => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          disabledBackgroundColor:
              settingsController.isDarkMode.value ? Colors.white : Colors.white,

          padding: EdgeInsets.all(16),
          // Set padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Set border radius
          ),
        ),
        onPressed: () => controller.appendNumber(number),
        child: Text(
          number,
          style: TextStyle(
              fontSize: 25,
              color: settingsController.isDarkMode.value
                  ? Colors.white
                  : Colors.black),
        ),
      ),
    );
  }

  Widget buildFunctionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }

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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.selectedCurrency(currencies[index]);
                              print(currencies[index]);
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                // Text(currencies[index].abbreviation ?? '',
                                //     style: Styles.textStyleTitle12
                                //         .copyWith(color: Colors.grey)),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      controller.currenciesList[index].img ??
                                          '' '',
                                      height: 25.h,
                                      width: 25.h,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const SizedBox(),
                                    )),
                                SizedBox(
                                  width: 20,
                                  // child: Center(child: Text('--')),
                                ),
                                Text(currencies[index].name ?? '',
                                    style: Styles.textStyleTitle14),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          Container(
                            height: 0.5,
                            padding: EdgeInsets.symmetric(vertical: 30),
                            margin:
                                EdgeInsets.only(right: 10, top: 10, bottom: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade700, width: 0.2)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      );
                    },
                    itemCount: currencies.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class AmountSendScreenId extends StatelessWidget {
  final AmountSendController controller = Get.put(AmountSendController());
  final SettingsController settingsController = Get.find();

  String modelReceiver;
  String name;
  String img;
  String endPoint;

  AmountSendScreenId(
      {Key? key,
      required this.modelReceiver,
      required this.endPoint,
      required this.name,
      required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getDataCurrencyPhone();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back, size: 28),
                    ),
                    Text('Send Money', style: Styles.textStyleTitle24),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                Container(
                  height: 80.h,
                  width: 80.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border:
                        Border.all(color: const Color(0XffE0E0E0), width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(41),
                    child: Image.network(
                      img,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Icon(Icons.account_circle, size: 60),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  name,
                  style: Styles.textStyleTitle16.copyWith(
                      color: settingsController.isDarkMode.value
                          ? Colors.white
                          : Color(0Xff6A6969),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 24.h,
                ),
                InkWell(
                  onTap: () {
                    _showBottomSheet(context, controller.currenciesList);
                  },
                  child: Obx(
                    () => Container(
                      width: 180.w,
                      height: 33.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.h, vertical: 3.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
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
                          Text(
                              controller.selectedCurrency.value?.abbreviation ??
                                  '',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 3,
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                controller.selectedCurrency.value?.img ?? '',
                                height: 25.h,
                                width: 25.h,
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox(),
                              )),
                          SizedBox(
                            width: 3,
                          ),
                          Text(controller.selectedCurrency.value?.name ?? '',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.expand_more, color: Colors.grey, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.input.value,
                          style:
                              const TextStyle(fontSize: 36, color: Colors.grey),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          controller.selectedCurrency.value?.abbreviation ?? '',
                          style:
                              const TextStyle(fontSize: 36, color: Colors.grey),
                        ),
                      ],
                    )),
                const SizedBox(height: 20),
                Center(
                    child: Text(
                  'Turkish Lira Balance ',
                  style: Styles.textStyleTitle14
                      .copyWith(color: const Color(0XFF6A6969)),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildNumberButton('1'),
                    buildNumberButton('2'),
                    buildNumberButton('3'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildNumberButton('4'),
                    buildNumberButton('5'),
                    buildNumberButton('6'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildNumberButton('7'),
                    buildNumberButton('8'),
                    buildNumberButton('9'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildFunctionButton('C', controller.clear),
                    buildNumberButton('0'),
                    buildFunctionButton(
                        '⌫', controller.delete), // Delete button
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ButtomsNotBorder(
                      text: 'continue',
                      color: Colors.black,
                      onPressed: () {
                        controller.input.value == "0"
                            ? Get.snackbar("Warning!", 'Please Enter Number',
                                colorText: Colors.white,
                                backgroundColor: Colors.red)
                            : controller.sendAmountMoney(
                                endPoint: endPoint,
                                receiverId: modelReceiver,
                                currencyId:
                                    "${controller.selectedCurrency.value?.id}",
                                amount: controller.input.value,
                                context: context);
                      },
                      colorText: Colors.white,
                      isFormValid: true.obs,
                      context: context,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNumberButton(String number) {
    final SettingsController settingsController = Get.find();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        disabledBackgroundColor: Colors.white,

        padding: EdgeInsets.all(16),
        // Set padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Set border radius
        ),
      ),
      onPressed: () => controller.appendNumber(number),
      child: Text(
        number,
        style: TextStyle(
            fontSize: 25,
            color: settingsController.isDarkMode.value
                ? Colors.white
                : Colors.black),
      ),
    );
  }

  Widget buildFunctionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }

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
                            child: Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      controller.currenciesList[index].img ??
                                          '',
                                      height: 25.h,
                                      width: 25.h,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const SizedBox(),
                                    )),
                                SizedBox(
                                  width: 20,
                                  // child: Center(child: Text('--')),
                                ),
                                Text(currencies[index].name ?? '',
                                    style: Styles.textStyleTitle14),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          Container(
                            height: 0.5,
                            padding: EdgeInsets.symmetric(vertical: 30),
                            margin:
                                EdgeInsets.only(right: 10, top: 10, bottom: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade700, width: 0.2)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      );
                    },
                    itemCount: currencies.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
