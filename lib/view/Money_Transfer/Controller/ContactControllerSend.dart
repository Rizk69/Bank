import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../Core/http_helper.dart';

class ContactControllerSend extends GetxController {
  RxList<Contact> contacts = <Contact>[].obs;
  RxList<Contact> filteredContacts = <Contact>[].obs;
  RxList<Contact> trueNumbers = <Contact>[].obs; // New RxList for valid numbers
  RxList<Contact> falseNumbers =
      <Contact>[].obs; // New RxList for valid numbers

  @override
  void onInit() {
    super.onInit();
    getContacts();
  }

  Future<void> getContacts() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      Iterable<Contact> contactList = await ContactsService.getContacts();
      contacts.assignAll(contactList);
      filteredContacts.assignAll(contacts);
      checkAllNumbers();
      update();
    } else {
      // Handle the case where contacts permission is not granted
    }
  }

  void searchContacts(String query) {
    if (query.isEmpty) {
      filteredContacts.assignAll(contacts);
    } else {
      filteredContacts.assignAll(
        contacts.where(
          (contact) =>
              contact.displayName
                  ?.toLowerCase()
                  .contains(query.toLowerCase()) ??
              false,
        ),
      );
    }
    update();
  }

  Future<void> checkAllNumbers() async {
    try {
      for (Contact contact in contacts) {
        if (contact.phones != null && contact.phones!.isNotEmpty) {
          for (Item phoneItem in contact.phones!) {
            await checkNumber(contact, phoneItem.value!);
          }
        }
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> checkNumber(Contact contact, String phoneNumber) async {
    try {
      final response = await HttpHelper.postData(
        endpoint: 'check_phonee',
        body: {'phone': phoneNumber},
      );

      if (response['status'] == true) {
        // Handle the case when the phone number is valid
        print('Phone number is valid: $phoneNumber');
        trueNumbers.add(contact); // Add contact to trueNumbers
      } else {
        // Handle the case when the phone number is not valid
        print('Phone number is not valid: $phoneNumber');
        falseNumbers.add(contact); // Add contact to trueNumbers
      }
    } catch (error) {
      print(error);
    }
  }
}
