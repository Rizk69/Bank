import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/Core/widgets/custom_text_form_field.dart';
import 'package:MBAG/view/Money_Transfer/Controller/ContactControllerSendRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactListPageRequest extends StatelessWidget {
  final ContactControllerSendRequest contactController =
      Get.put(ContactControllerSendRequest());

  ContactListPageRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quick contacts ',
                    style: Styles.textStyleTitle16.copyWith(
                        color: Color(0XFF6A6969), fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Add/Edit',
                    style: Styles.textStyleTitle16.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 18.h,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border:
                              Border.all(color: Color(0XffE0E0E0), width: 1),
                        ),
                        child: Image.asset('Assets/images/Ellipse 1108.png'),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        'mama',
                        style: Styles.textStyleTitle14.copyWith(
                            color: Color(0Xff6A6969),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 24.h,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border:
                              Border.all(color: Color(0XffE0E0E0), width: 1),
                        ),
                        child: Image.asset('Assets/images/Ellipse 1108.png'),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        'hate',
                        style: Styles.textStyleTitle14.copyWith(
                            color: Color(0Xff6A6969),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 24.h,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border:
                              Border.all(color: Color(0XffE0E0E0), width: 1),
                        ),
                        child: Image.asset('Assets/images/Ellipse 1108.png'),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        'hate',
                        style: Styles.textStyleTitle14.copyWith(
                            color: Color(0Xff6A6969),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextFormField(),
              Row(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    height: 45.h,
                    width: 45.h,
                    child: Image.asset(
                      'Assets/images/link.png',
                    ),
                  ),
                  SizedBox(
                    width: 15.h,
                  ),
                  Text(
                    'Request money via link ',
                    style: Styles.textStyleTitle16
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Icon(
                    Icons.navigate_next_outlined,
                    size: 30,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contact using MBAG ${contactController.contacts.length}',
                    style: Styles.textStyleTitle16.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Obx(
                  () => ListView.builder(
                    itemCount: contactController.contacts.length,
                    itemBuilder: (context, index) {
                      var contact = contactController.contacts[index];
                      return ListTile(
                        leading: contact.phones!.isNotEmpty
                            ? Icon(Icons.phone)
                            : Icon(Icons.phone_disabled),
                        title: Text(contact.displayName ?? ''),
                        subtitle: Text((contact.phones!.isNotEmpty
                                ? contact.phones!.first.value
                                : 'لا يوجد رقم هاتف') ??
                            ''),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
