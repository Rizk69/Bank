import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/Core/widgets/custom_text_form_field.dart';
import 'package:MBAG/view/Money_Transfer/Screen/ScreenAmountSend.dart';
import 'package:MBAG/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../Controller/ContactControllerSend.dart';
import '../Controller/MbagNumberController.dart';

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
    // contactController.update();
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

  ContactListPage({Key? key}) : super(key: key);

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
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quick contacts',
                    style: Styles.textStyleTitle16.copyWith(
                      color: Color(0XFF6A6969),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Add/Edit',
                    style: Styles.textStyleTitle16.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Row(
                children: [
                  buildContactWidget('mama', 'Assets/images/Ellipse 1108.png'),
                  SizedBox(width: 24),
                  buildContactWidget('hate', 'Assets/images/Ellipse 1108.png'),
                  SizedBox(width: 24),
                  buildContactWidget('hate', 'Assets/images/Ellipse 1108.png'),
                ],
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: searchController,
                hintText: 'To whom?',
                onChanged: (value) {
                  contactController.filterList(value);
                },
              ),
              SizedBox(height: 10),
              Obx(
                () => Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contact using MBAG ${contactController.user.value?.user.length}',
                    style: Styles.textStyleTitle16.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Obx(
                () => Expanded(
                    flex: 1,
                    child: contactController.isLoading.isFalse
                        ? buildContactListView()
                        : Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.white,
                              ),
                              height: 90.h,
                              width: double.infinity,
                            ),
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContactListView() {
    return GetBuilder<ContactControllerSend>(
        initState: (state) => ContactControllerSend(),
        builder: (controller) {
          controller.filteredContacts.sort((a, b) {
            // Sort by photos first
            if (a.user?.img != null && b.user?.img == null) {
              return -1; // a comes first
            } else if (a.user?.img == null && b.user?.img != null) {
              return 1; // b comes first
            } else {
              return 0;
            }
          });

          return ListView.builder(
            itemCount: controller.filteredContacts.length,
            itemBuilder: (context, index) {
              if (index >= 0 && index < controller.filteredContacts.length) {
                var contact = controller.filteredContacts[index].phone;
                var contactId = controller.filteredContacts[index].user?.id;
                var photo = controller.filteredContacts[index].user?.img;
                var firstName =
                    controller.filteredContacts[index].user?.firstName;
                var lastName =
                    controller.filteredContacts[index].user?.lastName;

                return InkWell(
                  onTap: () {
                    if (firstName != null) {
                      Get.to(() => AmountSendScreenId(
                            modelCurrencies: "1",
                            modelReceiver: '$contactId',
                            name: firstName ?? '',
                            img: photo ?? "",
                            endPoint: 'send_amount_ID',
                          ));
                    }
                  },
                  child: ListTile(
                    leading: buildContactImage(photo),
                    title: firstName == null
                        ? SizedBox()
                        : Text('$firstName $lastName'),
                    subtitle: Text(
                        (contact.isNotEmpty ? contact : 'لا يوجد رقم هاتف')),
                    trailing:
                        firstName == null ? SizedBox() : Icon(Icons.check),
                  ),
                );
              } else {
                // Handle index out of bounds case
                return SizedBox(); // or any other widget as needed
              }
            },
          );
        });
  }

  Widget buildContactImage(String? photo) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0XFF8B959E),
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          photo ?? '',
          width: 60.h,
          height: 60.h,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Padding(
            padding: EdgeInsets.all(11.0),
            child: ImageIcon(
              AssetImage('Assets/images/line-md_account.png'),
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContactWidget(String name, String imagePath) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Color(0XffE0E0E0), width: 1),
          ),
          child: Image.asset(imagePath),
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: Styles.textStyleTitle14.copyWith(
            color: Color(0Xff6A6969),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
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
                  ],
                ),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  hintText: 'MBAG NUMBER / IBAN ',
                  controller: controller.mbagNumberController,
                ),
                Spacer(),
                // Use FutureBuilder to handle loading state
                Buttoms(
                  text: 'Continue',
                  color: Colors.black,
                  onPressed: () async {
                    controller.mbagNumberController.isNull
                        ? Get.snackbar('', 'Please Enter Mbag Number',
                            backgroundColor: Colors.red)
                        : await controller.getMbagNumberClient();
                  },
                  colorText: Colors.white,
                )
              ],
            )));
  }
}

class ContactListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactControllerSend>(
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.user.value?.user.length,
          itemBuilder: (context, index) {
            // Check if the index is within the bounds of the list
            if (index < controller.user.value!.user.length) {
              var contact = controller.user.value?.user[index].phone;
              var photo = controller.user.value?.user[index].user?.img;
              var firstName =
                  controller.user.value?.user[index].user?.firstName;
              var lastName = controller.user.value?.user[index].user?.lastName;

              return InkWell(
                onTap: () {},
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      color: const Color(0XFF8B959E),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        photo ?? '',
                        width: 60.h,
                        height: 60.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Padding(
                          padding: EdgeInsets.all(11.0),
                          child: ImageIcon(
                            AssetImage('Assets/images/line-md_account.png'),
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: firstName == null
                      ? SizedBox()
                      : Text('$firstName $lastName'),
                  subtitle: Text(contact?.isNotEmpty ?? false
                      ? contact!
                      : 'لا يوجد رقم هاتف'),
                  trailing: photo == null ? SizedBox() : Icon(Icons.check),
                ),
              );
            } else {
              // Return an empty container if the index is out of bounds
              return Container();
            }
          },
        );
      },
    );
  }
}
// Align(
//   alignment: Alignment.centerLeft,
//   child: Text(
//     'Quick transaction',
//     style: Styles.textStyleTitle16.copyWith(
//       color: Color(0XFF6A6969),
//       fontWeight: FontWeight.w400,
//     ),
//   ),
// ),
// SizedBox(height: 18.h),
// Align(
//   alignment: Alignment.centerLeft,
//   child: Container(
//     height: 80.h,
//     width: 80.h,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(40),
//       border: Border.all(color: Color(0XffE0E0E0), width: 1),
//     ),
//     child: Center(child: Icon(Icons.add)),
//   ),
// ),
// SizedBox(height: 8.h),
// Align(
//   alignment: Alignment.centerLeft,
//   child: Text(
//     'Add IBAN',
//     style: Styles.textStyleTitle14.copyWith(
//       color: Color(0Xff6A6969),
//       fontWeight: FontWeight.w400,
//     ),
//   ),
// ),
// SizedBox(height: 25.h),
