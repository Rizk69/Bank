import 'package:MBAG/view/Auth_View/Login/model/Countries.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/http_helper.dart';

class CountryController extends GetxController {
  late Countries _countryModel;

  Countries get countryModel => _countryModel;

  @override
  void onInit() {
    super.onInit();
    _countryModel = Countries(
      status: false,
      message: "",
      country: [],
    );
  }

  Future<void> getCountry() async {
    try {
      final response = await HttpHelper.getData(
        endpoint: "countries",
      );
      if (response["status"] == true) {
        _countryModel = Countries.fromJson(response);
        print(response.toString());
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
      await Future.delayed(Duration(seconds: 2)); // Initial delay
      await getDataCountryWithExponentialBackoff(2);
    } finally {}
  }

  Future<void> getDataCountryWithExponentialBackoff(int retryCount) async {
    if (retryCount <= 5) {
      // Limit the number of retries to avoid infinite loops
      final delaySeconds =
          2 * (1 << (retryCount - 1)); // Exponential backoff formula
      await Future.delayed(Duration(seconds: delaySeconds));
      await getCountry(); // Retry the request
    } else {
      print('Maximum number of retries reached. Stopping.');
    }
  }
}
