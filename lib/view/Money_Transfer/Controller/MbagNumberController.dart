import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/http_helper.dart';
import '../../QrTransaction/model/ScanModel.dart';
import '../Screen/ScreenAmountSend.dart';

class MbagNumberController extends GetxController {
  TextEditingController mbagNumberController = TextEditingController();
  var isLoading = false.obs;

  Future<void> getMbagNumberClient() async {
    try {
      final response = await HttpHelper.postData(
        endpoint: 'send_money_for_account',
        body: {'account_number': mbagNumberController.text},
      );

      ApiResponseCheckScan apiResponse =
          ApiResponseCheckScan.fromJson(response);

      if (response['status'] == true) {
        print(apiResponse.toString());
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
        isLoading.value = true;

        Get.to(() => AmountSendScreen(model: apiResponse));
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
        isLoading.value = false;
      }
    } catch (error) {
      print(error);
    }
  }
}
