import 'package:MBAG/view/Transaction/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/http_helper.dart';
import '../../QrTransaction/model/ScanModel.dart';
import '../Screen/Account_transaction_details.dart';

class TransactionController extends GetxController {
  var transactionData = <Transaction>[].obs;
  late TransactionDetails transactionDetails;
  final TextEditingController searchController = TextEditingController();
  Rx<Currency?> selectedCurrency = Rx<Currency?>(null);
  var currenciesList = <Currency>[].obs;

  void selectCurrency(Currency currency) {
    selectedCurrency.value = currency;
    transactionData.clear();

    update();
  }

  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    ever(selectedCurrency, (_) => getTransactions());
    getTransactions();
    update();
    selectedCurrency.value =
        Currency(id: 0, abbreviation: 'abbreviation', name: 'All', img: '');
  }

  var isLoading = true.obs;

  Future getTransactions() async {
    try {
      transactionData.value = [];
      // Move this line here
      final response = await HttpHelper.getData(
        endpoint: "get_transaction_type/${selectedCurrency.value?.id}",
      );
      if (response["status"] == true) {
        print(response);
        print(response.toString());
        response['transactions'].forEach((e) {
          transactionData.add(Transaction.fromJson(e));
          print(transactionData.length);
          isLoading.value = false;

          update();
        });
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getDataCurrencyUser() async {
    try {
      final response = await HttpHelper.getData(
        endpoint: "get_currencies_user",
      );
      if (response["status"] == true) {
        List<dynamic> currenciesJson = response["currencies"];
        currenciesList.value = currenciesJson
            .map((currencyJson) => Currency.fromJson(currencyJson))
            .toList();
        if (currenciesList.isNotEmpty) {
          // selectedCurrency.value = currenciesList.first;
        }
        update();
      } else {}
    } catch (error) {
      print('Error during data fetching currencyModel: $error');
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
}
