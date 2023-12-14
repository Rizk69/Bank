import 'package:bank/Core/widgets/Styles.dart';
import 'package:bank/Core/widgets/custom_text_form_field.dart';
import 'package:bank/view/on_bording_screen/Widget/buttom_.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Core/http_helper.dart';
import '../../QrTransaction/model/ScanModel.dart';
import '../Controller/ContactControllerSend.dart';
import '../Controller/MbagNumberController.dart';
import '../Screen/ScreenAmountSend.dart';

class NestedTabBar extends StatefulWidget {
  NestedTabBar({super.key});

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final ContactControllerSend contactController =
      Get.put(ContactControllerSend());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    contactController.getContacts();
    contactController.update();
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
          padding: const EdgeInsets.all(8),
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
              Obx(
                () => Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Contact using MBAG ${contactController.contacts.length}',
                      style: Styles.textStyleTitle16.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
              ),
              Expanded(
                flex: 1,
                child: GetBuilder<ContactControllerSend>(
                  builder: (controller) {
                    return controller.contacts.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: contactController.falseNumbers.length +
                                contactController.trueNumbers.length,
                            itemBuilder: (context, index) {
                              // Check if the index is within the bounds of trueNumbers
                              if (index <
                                  contactController.trueNumbers.length) {
                                var contactTrue =
                                    contactController.trueNumbers[index];
                                return ListTile(
                                  trailing: Icon(Icons.phone),
                                  title: Text(contactTrue.displayName ?? ''),
                                  subtitle: Text(
                                    (contactTrue.phones!.isNotEmpty
                                            ? contactTrue.phones!.first.value
                                            : 'لا يوجد رقم هاتف') ??
                                        '',
                                  ),
                                );
                              } else {
                                // Adjust the index to access elements from falseNumbers
                                var adjustedIndex = index -
                                    contactController.trueNumbers.length;
                                var contactFalse = contactController
                                    .falseNumbers[adjustedIndex];
                                return ListTile(
                                  title: Text(contactFalse.displayName ?? ''),
                                  subtitle: Text(
                                    (contactFalse.phones!.isNotEmpty
                                            ? contactFalse.phones!.first.value
                                            : 'لا يوجد رقم هاتف') ??
                                        '',
                                  ),
                                );
                              }
                            },
                          );
                  },
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
  MbagNumberTabBar({Key? key}) : super(key: key);
  MbagNumberController controller = Get.put(MbagNumberController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.4,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 16.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Quick transaction',
                style: Styles.textStyleTitle16.copyWith(
                  color: Color(0XFF6A6969),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 18.h),
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
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add IBAN',
                style: Styles.textStyleTitle14.copyWith(
                  color: Color(0Xff6A6969),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(1),
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        'MBAG number',
                        style: Styles.textStyleTitle20.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(1),
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Easy address',
                        style: Styles.textStyleTitle20.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            CustomTextFormField(
                hintText: 'MBAG NUMBER / IBAN ',
                suffix: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
                controller: controller.mbagNumberController),
            Spacer(),
            Buttoms(
              text: 'Continue',
              color: Colors.black,
              onPressed: () {
                controller.getMbagNumberClient();
              },
              colorText: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
