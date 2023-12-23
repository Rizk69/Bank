import 'package:MBAG/view/Home_View/model/HomeModel.dart';
import 'package:get/get.dart';

import '../../../Core/http_helper.dart';

class CashBackController extends GetxController {
  late Traders _traders = Traders();
  late List<Traders> tradersList;

  late var isLoading = true.obs;

  Traders get traders => _traders;

  Future<void> getDataHome() async {
    try {
      final response = await HttpHelper.getData(
        endpoint: "see_more_trader",
      );
      if (response["status"] == true) {
        _traders = Traders.fromJson(response);
        tradersList.add(_traders);
        isLoading.value = false;
        update();
      } else {
        isLoading.value = true;
      }
    } catch (error) {
      print('Error during data fetching: $error');
      isLoading.value = true;
    }
  }
}
