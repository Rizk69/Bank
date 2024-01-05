import 'package:get/get.dart';

import '../../../Core/http_helper.dart';

import '../Screen/TraderAdressScreen.dart';
import '../model/CashBackModel.dart';

class TermsController extends GetxController {
  var isLoading = false.obs;
  RxString terms = RxString('');

  Future<void> getTermsData() async {
    if (terms.value != '') {
    } else {
      try {
        final response = await HttpHelper.getData(
          endpoint: "get_terms",
        );
        print(response.toString());

        if (response["status"] == true) {
          isLoading.value = true;

          terms.value = response["terms"];
          update();
        } else {
          isLoading.value = false;
        }
      } catch (error) {
        print(error);
      }
    }
  }
}

class CashBakController extends GetxController {
  CashBackModel cashBackModel = CashBackModel();
  var isLoading = false.obs; // Start with loading as true

  Future getTrader() async {
    try {
      isLoading.value = true;
      final response = await HttpHelper.getData(
        endpoint: "see_more_trader",
      );
      if (response["status"] == true) {
        print(response.toString());
        cashBackModel = CashBackModel.fromJson(response);
        update();
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

  Future getTraderAddress({required int id}) async {
    try {
      final response = await HttpHelper.getData(
        endpoint: "get_address_trader/$id",
      );
      if (response["status"] == true) {
        print(response.toString());
        double _lat = response["lat"];
        double _long = response["long"];
        print(_lat);
        print(_long);

        Get.to(() => TraderAdressScreen(
              lat: _lat,
              long: _long,
            ));
      }
    } catch (error) {
      print(error);
    } finally {}
  }
}
