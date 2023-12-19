import 'package:bank/view/Transaction/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/http_helper.dart';

class TransactionController extends GetxController {
  var transactionData = <Transaction>[].obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    getTransactions();
    update();
  }

  var isLoading = true.obs; // Start with loading as true
  Future getTransactions() async {
    try {
      transactionData.value = [];
      // Move this line here
      final response = await HttpHelper.getData(
        endpoint: "get_transaction",
      );
      if (response["status"] == true) {
        print(response);
        print(response.toString());
        response['transactions'].forEach((e) {
          transactionData.add(Transaction.fromJson(e));
          print(transactionData.length);
          isLoading.value = false;

          update();
        });
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

}
