import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactControllerSendRequest extends GetxController {
  RxList<Contact> contacts = <Contact>[].obs;

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
    } else {
      // لم يتم منح الإذن
      // يمكنك إدراج رمز للتعامل مع الحالة هنا
    }
  }
}
