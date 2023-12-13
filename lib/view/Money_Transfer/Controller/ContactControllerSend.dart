import 'package:contacts_service/contacts_service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactControllerSend extends GetxController {
  RxList<Contact> contacts = <Contact>[].obs;
  RxList<Contact> filteredContacts = <Contact>[].obs;

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
      filteredContacts
          .assignAll(contacts); // Initialize filteredContacts with all contacts
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
}
