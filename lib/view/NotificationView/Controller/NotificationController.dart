import 'package:MBAG/view/NotificationView/model/NotificationsModel.dart';
import 'package:get/get.dart';

import '../../../Core/http_helper.dart';
import '../../Transaction/Screen/Account_transaction_details.dart';
import '../../Transaction/model/transaction_model.dart';

class NotificationControllerGetData extends GetxController {
  NotificationsModel _notificationsModel = NotificationsModel();

  NotificationsModel get notificationsModel => _notificationsModel;
  late TransactionDetails transactionDetails;

  Future<void> getNotification() async {
    try {
      final response = await HttpHelper.getData(endpoint: "user_notifications");
      if (response["status"] == true && response["notifications"] != null) {
        _notificationsModel = NotificationsModel.fromJson(response);
        print(response);
        update();
      } else {
        print("Notifications not found or status is false");
      }
    } catch (error) {
      print("Error fetching Notifications: $error");
    } finally {
      update();
    }
  }

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
