import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../Core/cache_helper.dart';
import '../../../Core/http_helper.dart';
import '../model/CheckPhoneModel.dart';
import '../model/FavoriteClientModel.dart';

class ContactControllerSend extends GetxController {
  RxList<UserData> filteredContacts = <UserData>[].obs;
  Rx<ApiResponseCheck?> user = Rx<ApiResponseCheck?>(null);
  var favoriteClients = <FavoriteClient>[].obs;

  RxBool isLoading = true.obs;
  RxBool isLoadingGetFavoriteClient = true.obs;

  @override
  void onInit() {
    super.onInit();
    main().then((_) => removeDuplicates());
  }

  Future<void> getFavoriteClient() async {
    try {
      isLoadingGetFavoriteClient.value = true;

      final response = await HttpHelper.getData(
        endpoint: "get_favorite_client",
      );
      if (response["status"] == true) {
        List<dynamic> clientList = response['favorite_client'];
        var clients = clientList
            .map((jsonItem) => FavoriteClient.fromJson(jsonItem))
            .toList();
        favoriteClients.assignAll(clients);
        isLoadingGetFavoriteClient.value = false;
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
      Get.snackbar("Error", "An error occurred", backgroundColor: Colors.red);
      await Future.delayed(Duration(seconds: 2)); // Initial delay
    } finally {
      update();
    }
  }

  Future<void> main() async {
    try {
      List<String> allPhones = await fetchAllPhones();
      List<Map<String, String>> phonesList =
          allPhones.map((phone) => {"phone": phone}).toList();

      print('Phones List: $phonesList');

      String jsonBody = json.encode(phonesList);

      print('JSON Body: $jsonBody');
      await checkNumber(jsonBody);
      isLoading.value = false;
      update();
    } catch (e) {
      print('Error in main: $e');
    }
  }

  Future<List<String>> fetchAllPhones() async {
    List<String> phones = [];

    try {
      var status = await Permission.contacts.request();
      if (status.isGranted) {
        Iterable<Contact> contacts = await ContactsService.getContacts();

        for (var contact in contacts) {
          for (var phone in contact.phones!) {
            phones.add(phone.value!);
          }
        }
      }
    } catch (e) {
      print('Error in fetchAllPhones: $e');
    } finally {}

    return phones;
  }

  Future<void> checkNumber(String rawBody) async {
    try {
      var token = CacheHelper.getDataSharedPreference(key: 'token');
      const apiUrl = 'https://wallet.acwad-it.com/api/check_phonee';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Accept-Language': 'en',
        },
        body: rawBody.trim(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print('object $jsonResponse');

        if (jsonResponse.isNotEmpty) {
          user.value = ApiResponseCheck.fromJson(jsonResponse);
          filteredContacts.value = List.from(user.value?.user ?? []);

          print('Response content: ${response.body}');
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      // Handle exceptions
      print('Exception in checkNumber: $error');
    }
  }

  List<UserData> get filteredUsersWithStatusPhoneTrue {
    return user.value?.user.where((u) => u.statusPhone == true).toList() ?? [];
  }

  void filterList(String query) {
    if (query.isEmpty) {
      // Filter to include only users with status_phone == true
      filteredContacts.value = (user.value?.user ?? [])
          .where((user) => user.statusPhone == true)
          .toList();
    } else {
      filteredContacts.value = (user.value?.user ?? []).where((user) {
        // Check if status_phone is true
        bool isStatusPhoneTrue = user.statusPhone == true;
        var fullName = '${user.user?.firstName} ${user.user?.lastName}';
        var phoneNumber = user.phone;

        // Filter based on query and status_phone
        return isStatusPhoneTrue &&
            (fullName.toLowerCase().contains(query.toLowerCase()) ||
                phoneNumber.contains(query));
      }).toList();
    }
    update();
  }

  void removeDuplicates() {
    var uniquePhoneNumbers = <String>{};
    user.value?.user.retainWhere((u) => uniquePhoneNumbers.add(u.phone));
    filterList('');
  }
}
