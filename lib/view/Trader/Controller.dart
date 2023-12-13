import 'package:bank/view/Home_View/model/HomeModel.dart';
import 'package:get/get.dart';

import '../../Core/http_helper.dart';

class TraderController extends GetxController {
  var traderData = <Traders>[].obs;
  var isLoading = false.obs; // Start with loading as true

  Future getTrader() async {
    try {
      traderData.value = [];
      isLoading.value = true;
      // Move this line here
      final response = await HttpHelper.postData(
        endpoint: "see_more_trader",
        body: {},
      );
      if (response["status"] == true) {
        print(response.toString());
        response['transactions'].forEach((e) {
          traderData.add(Traders.fromJson(e));
          print(traderData.length);
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
