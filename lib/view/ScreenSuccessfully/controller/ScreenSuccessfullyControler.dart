import 'package:get/get.dart';

import '../../../Core/http_helper.dart';
import '../../Transaction/Screen/Account_transaction_details.dart';
import '../../Transaction/model/transaction_model.dart';

class ScreenSuccessfullyController extends GetxController {
  late TransactionDetails transactionDetails;

  Future<void> getTransactionsDetails({required int id}) async {
    print(id);
    try {
      final response =
          await HttpHelper.postData(endpoint: "get_transactionn/$id", body: {});
      if (response["status"] == true && response["transaction"] != null) {
        transactionDetails =
            TransactionDetails.fromJson(response["transaction"]);
        print(response);
        update();
        Get.to(() => AccountTransActonDetails(
              transactionDetails: transactionDetails,
              notification: false,
            ));
      } else {
        print("Transaction details not found or status is false");
      }
    } catch (error) {
      print("Error fetching transaction details: $error");
    } finally {}
  }
}
