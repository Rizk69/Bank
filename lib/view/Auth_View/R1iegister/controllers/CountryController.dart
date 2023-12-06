import 'package:bank/view/Auth_View/Login/model/Countries.dart';
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
    } finally {}
  }
}
