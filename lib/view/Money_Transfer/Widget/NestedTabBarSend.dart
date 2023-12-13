import 'package:bank/Core/widgets/Styles.dart';
import 'package:bank/Core/widgets/custom_text_form_field.dart';
import 'package:bank/view/on_bording_screen/Widget/buttom_.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Controller/ContactControllerSend.dart';

class NestedTabBar extends StatefulWidget {
  NestedTabBar({super.key});

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          padding: EdgeInsets.all(5),
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Phone number',
            ),
            Tab(text: 'MBAG number '),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[ContactListPage(), MbagNumberTabBar()],
          ),
        ),
      ],
    );
  }
}



class ContactListPage extends StatelessWidget {
  final ContactControllerSend contactController =
      Get.put(ContactControllerSend());
  final TextEditingController searchController = TextEditingController();

  ContactListPage({super.key});

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
              CustomTextFormField(
                controller: searchController,
                hintText: 'To whom?',
                onChanged: (value) {
                  contactController.searchContacts(value);
                },
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
                  () =>
                  contactController.contacts.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: contactController.filteredContacts.length,
                          itemBuilder: (context, index) {
                            var contact =
                                contactController.filteredContacts[index];
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

class MbagNumberTabBar extends StatelessWidget {
  const MbagNumberTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 25.h,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Quick transaction',
                style: Styles.textStyleTitle16.copyWith(
                    color: Color(0XFF6A6969), fontWeight: FontWeight.w400),
              )),
          SizedBox(
            height: 18.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 80.h,
              width: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Color(0XffE0E0E0), width: 1),
              ),
              child: Center(child: Icon(Icons.add)),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add IBAN',
                style: Styles.textStyleTitle14.copyWith(
                    color: Color(0Xff6A6969), fontWeight: FontWeight.w400),
              )),
          SizedBox(
            height: 25.h,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(1),
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: Center(
                      child: Text(
                    'MBAG number',
                    style: Styles.textStyleTitle20.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.white),
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(1),
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Center(
                      child: Text(
                    'Easy address',
                    style: Styles.textStyleTitle20
                        .copyWith(fontWeight: FontWeight.w400),
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 80.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffD9D9D9)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'MBAG NUMBER / IBAN ',
                      style: Styles.textStyleTitle12.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                    Text(
                      '145362436 ',
                      style: Styles.textStyleTitle20.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.camera_alt)
              ],
            ),
          ),
          Spacer(),
          Buttoms(
              text: 'Continue',
              color: Colors.black,
              onPressed: () {},
              colorText: Colors.white)
        ],
      ),
    );
  }
}
