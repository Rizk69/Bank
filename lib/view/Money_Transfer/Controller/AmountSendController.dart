import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/http_helper.dart';
import '../../MBAG_Card_Screen/Widget/ScreenSuccessfull.dart';
import '../../QrTransaction/model/ScanModel.dart';

class AmountSendController extends GetxController {
  var input = '0'.obs;
  Rx<Currency?> selectedCurrency = Rx<Currency?>(null);
  var currenciesList = <Currency>[].obs;

  void selectCurrency(Currency currency) {
    selectedCurrency.value = currency;
    print(currency.id);
  }

  void appendNumber(String number) {
    if (input.value == '0') {
      input.value = number;
    } else {
      input.value += number;
    }
  }

  void clear() {
    input.value = '0';
  }

  void delete() {
    if (input.value.length > 1) {
      input.value = input.value.substring(0, input.value.length - 1);
    } else {
      input.value = '0';
    }
  }

  Future<void> sendAmountMoney({
    required String receiverId,
    required String currencyId,
    required String amount,
    required String endPoint,
    required BuildContext context,
  }) async {
    try {
      final response = await HttpHelper.postData(
        endpoint: endPoint,
        body: {
          'receiver_id': receiverId,
          'currency_id': currencyId,
          'amount': amount,
        },
      );
      if (response["status"] == true) {
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
        clear();
        Get.offAll(const ScreenSuccessfull());
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> getDataCurrencyPhone() async {
    try {
      final response = await HttpHelper.getData(
        endpoint: "get_currencies_user",
      );
      if (response["status"] == true) {
        List<dynamic> currenciesJson = response["currencies"];
        currenciesList.value = currenciesJson
            .map((currencyJson) => Currency.fromJson(currencyJson))
            .toList();
        if (currenciesList.isNotEmpty) {
          selectedCurrency.value = currenciesList.first;
        }
        update();
      } else {
        // Handle the case when currency data is not available
      }
    } catch (error) {
      print('Error during data fetching currencyModel: $error');
      // Handle the error when fetching currency data
    }
  }
}
