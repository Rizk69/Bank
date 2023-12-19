import 'package:bank/Core/widgets/Styles.dart';
import 'package:bank/view/Auth_View/Login/Widget/ButtomsNotBorder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../QrTransaction/model/ScanModel.dart';
import '../Controller/AmountSendController.dart';

class AmountSendScreen extends StatelessWidget {
  final AmountSendController controller = Get.put(AmountSendController());
  final ApiResponseCheckScan model;

  AmountSendScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                // ... Your existing UI code with style improvements
                Container(
                  height: 80.h,
                  width: 80.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border:
                        Border.all(color: const Color(0XffE0E0E0), width: 1),
                  ),
                  child: Image.asset('Assets/images/Ellipse 1108.png'),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'mohamed mama',
                  style: Styles.textStyleTitle16.copyWith(
                      color: const Color(0Xff6A6969),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 24.h,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 190.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0.5, 1.5),
                              blurRadius: 3,
                              blurStyle: BlurStyle.normal,
                              spreadRadius: 0.1,
                              color: Colors.grey)
                        ]),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Turkish Lira',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400)),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.flag_circle,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text('TL',
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
                const SizedBox(height: 20),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '\$',
                          style: TextStyle(fontSize: 36, color: Colors.grey),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          controller.input.value,
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
                      color: Color(0XFFE0E0E0),
                      onPressed: () {
                        controller.sendAmountMoney(
                            receiverId: model.receiver.receiverId.toString(),
                            currencyId: model.currencies.first.id.toString(),
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
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
    );
  }

  Widget buildFunctionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class AmountSendScreenPhone extends StatelessWidget {
  final AmountSendController controller = Get.put(AmountSendController());
  String modelReceiver;
  String modelCurrencies;

  AmountSendScreenPhone(
      {Key? key, required this.modelReceiver, required this.modelCurrencies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                // ... Your existing UI code with style improvements
                Container(
                  height: 80.h,
                  width: 80.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border:
                        Border.all(color: const Color(0XffE0E0E0), width: 1),
                  ),
                  child: Image.asset('Assets/images/Ellipse 1108.png'),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'mohamed mama',
                  style: Styles.textStyleTitle16.copyWith(
                      color: const Color(0Xff6A6969),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 24.h,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 190.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0.5, 1.5),
                              blurRadius: 3,
                              blurStyle: BlurStyle.normal,
                              spreadRadius: 0.1,
                              color: Colors.grey)
                        ]),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Turkish Lira',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400)),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.flag_circle,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text('TL',
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
                const SizedBox(height: 20),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '\$',
                          style: TextStyle(fontSize: 36, color: Colors.grey),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          controller.input.value,
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
                      color: Color(0XFFE0E0E0),
                      onPressed: () {
                        controller.sendAmountMoney(
                            receiverId: modelReceiver,
                            currencyId: modelCurrencies,
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
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
    );
  }

  Widget buildFunctionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
