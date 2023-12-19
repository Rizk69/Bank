import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../Core/cache_helper.dart';
import '../model/CheckPhoneModel.dart';

class ContactControllerSend extends GetxController {
  RxList<UserData> filteredContacts = <UserData>[].obs;
  Rx<ApiResponseCheck?> user = Rx<ApiResponseCheck?>(null);

  @override
  void onInit() {
    super.onInit();
    main();
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
    } catch (e) {
      print('Error in main: $e');
    }
  }

  Future<List<String>> fetchAllPhones() async {
    List<String> phones = [];

    try {
      // Check and request contacts permission
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
    }

    return phones;
  }

  Future<void> checkNumber(String rawBody) async {
    try {
      var token = CacheHelper.getDataSharedPreference(key: 'token');
      final apiUrl = 'https://wallet.acwad-it.com/api/check_phonee';

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
          // Initialize the filtered list with all users initially
          filteredContacts.value = List.from(user.value?.user ?? []);
          print('Response content: ${response.body}');
        }
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      // Handle exceptions
      print('Exception in checkNumber: $error');
    }
  }

  // Function to filter the list based on the search query
  void filterList(String query) {
    if (query.isEmpty) {
      filteredContacts.value = List.from(user.value?.user ?? []);
    } else {
      filteredContacts.value = (user.value?.user ?? []).where((user) {
        var fullName = '${user.user?.firstName} ${user.user?.lastName}';
        var phoneNumber = user.phone;
        return fullName.toLowerCase().contains(query.toLowerCase()) ||
            phoneNumber.contains(query);
      }).toList();
    }
    update();
  }
}
