import 'package:get/get.dart';

import '../../../Core/http_helper.dart';
import '../model/HomeModel.dart';

class HomeControllerGetData extends GetxController {
  late HomeModel _homeModel = HomeModel();
  late CurrencyModel _currencyModel;
  late var isLoading = true.obs;
  late var isDataLoaded = false.obs;

  HomeModel get homeModel => _homeModel;

  CurrencyModel get currencyModel => _currencyModel;

  @override
  void onInit() {
    super.onInit();
    // Check if data is already loaded before making the initial API call
    if (!isDataLoaded.value) {
      getDataHome();
    }
  }

  Future<void> refreshDataHome() async {
    // Reset flags and fetch the data again
    isDataLoaded.value = false;
    isLoading.value = true;
    await getDataHome();
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
        _currencyModel = CurrencyModel.fromJson(response);
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
