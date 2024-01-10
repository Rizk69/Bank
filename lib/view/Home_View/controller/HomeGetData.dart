import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/http_helper.dart';
import '../../Transaction/Screen/Account_transaction_details.dart';
import '../../Transaction/model/transaction_model.dart';
import '../model/HomeModel.dart';

class HomeControllerGetData extends GetxController {
  late HomeModel _homeModel = HomeModel();
  late CurrencyModel _currencyModel;
  Rx<CurrencyHomeModel?> selectedCurrency = Rx<CurrencyHomeModel?>(null);

  late var isLoading = true.obs;
  late var isDataLoaded = false.obs;
  late TransactionDetails transactionDetails;

  HomeModel get homeModel => _homeModel;

  CurrencyModel get currencyModel => _currencyModel;

  @override
  void onInit() {
    super.onInit();

    if (!isDataLoaded.value) {
      getDataHome();
    }
    getDataCurrency();
  }

  void selectCurrency(CurrencyHomeModel currency) {
    selectedCurrency.value = currency;
    update();
  }

  Future<void> refreshDataHome() async {
    isDataLoaded.value = false;
    isLoading.value = true;
    getDataCurrency();

    update();
    await getDataHome();
    update();
  }

  Future<void> getDataHome() async {
    Map<String, dynamic> response = {};

    try {
      // Check if data is already loaded before making the API call
      if (isDataLoaded.value) {
        print('Data is already loaded: $homeModel');
        return;
      }

      // Make the API call
      response = await HttpHelper.getData(endpoint: "homeee");
      print('Raw Response: $response');

      if (isResponseValid(response)) {
        handleSuccessfulResponse(response);
      } else {
        handleInvalidResponse();
      }
    } catch (error) {
      print('Error during data fetching homeModel: $error');
      print('Response: $response');

      handleErrorResponse(error);
    } finally {
      update();
    }
  }

  Future<void> getTransactionsDetails({required var id}) async {
    print(id);
    try {
      final response =
          await HttpHelper.postData(endpoint: "get_transactionn/$id", body: {});
      if (response["status"] == true && response["transaction"] != null) {
        transactionDetails =
            TransactionDetails.fromJson(response["transaction"]);
        print(response);
        Get.to(() => AccountTransActonDetails(
              transactionDetails: transactionDetails,
              notification: false,
            ));
      } else {
        print("Transaction details not found or status is false");
      }
      update();
    } catch (error) {
      print("Error fetching transaction details: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestAntherAccount({
    required String currencyId,
  }) async {
    try {
      final response = await HttpHelper.getData(
        endpoint: 'request_anther_account/$currencyId',
      );

      if (response["status"] == true) {
        Get.snackbar('successfully', response["message"],
            backgroundColor: Colors.green, colorText: Colors.white);

        refreshDataHome();
      } else {
        Get.snackbar('ineffectively', response["message"],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (error) {
      Get.snackbar('ineffectively', error.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);

      print(error);
    } finally {
      update();
    }
  }

  bool isResponseValid(Map<String, dynamic> response) {
    return response.containsKey("status") &&
        response["status"] is bool &&
        response["status"] == true;
  }

  void handleSuccessfulResponse(Map<String, dynamic> response) {
    _homeModel = HomeModel.fromJson(response);
    isLoading.value = false;
    isDataLoaded.value = true;
  }

  void handleInvalidResponse() {
    isLoading.value = false;
    isDataLoaded.value = false;
  }

  void handleErrorResponse(error) {
    print('Error during data fetching homeModel: $error');
    isLoading.value = false;
    isDataLoaded.value = false;
  }

  Future<void> getDataCurrency() async {
    try {
      final response = await HttpHelper.getData(
        endpoint: "get_currencies",
      );
      if (response["status"] == true) {
        print(response);
        _currencyModel = CurrencyModel.fromJson(response);
        selectedCurrency.value = _currencyModel.currencies[0];
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
