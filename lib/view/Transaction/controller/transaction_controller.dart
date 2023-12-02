import 'package:bank/view/Transaction/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/http_helper.dart';

class TransactionController extends GetxController {
  var transactionData = <Transaction>[].obs;
  final TextEditingController searchController = TextEditingController();

  var isLoading = false.obs; // Start with loading as true
  Future getTransactions() async {
    try {
      transactionData.value = [];
      isLoading.value = true;
      // Move this line here
      final response = await HttpHelper.postData(
        endpoint: "get_transaction",
        body: {},
      );
      print(response.toString());
      response['transactions'].forEach((e) {
        transactionData.add(Transaction.fromJson(e));
      });
      print(transactionData.length);
      update();
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

// get one transaction
  late TransactionModel transactionOneData;
  var isLoadingGetOne = false.obs;

  void getOnTransaction({required int id}) async {
    try {
      isLoadingGetOne.value = true;
      final response = await HttpHelper.postData(
        endpoint: "get_transaction/$id",
        body: {},
      );
      print(response);
      transactionOneData = TransactionModel.fromJson(response);
      isLoadingGetOne.value = false;
    } catch (error) {
      Get.snackbar("Error!", "Please Try Again");
      isLoadingGetOne.value = true;
    }
  }
}