import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/Core/widgets/custom_text_form_field.dart';
import 'package:MBAG/view/Money_Transfer/Screen/ScreenAmountSend.dart';
import 'package:MBAG/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../helper/Dark/SettingsController.dart';
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
    SettingsController settingsController = Get.find();

    return Column(
      children: <Widget>[
        TabBar.secondary(
          padding: const EdgeInsets.all(5),
          indicatorColor:
              settingsController.isDarkMode.value ? Colors.white : Colors.black,
          labelColor:
              settingsController.isDarkMode.value ? Colors.white : Colors.black,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: 'MBAG number '),
            Tab(
              text: 'Phone number',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[MbagNumberTabBar(), ContactListPage()],
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
    SettingsController settingsController = Get.find();
    contactController.getFavoriteClient();
    return Scaffold(
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
                      color: settingsController.isDarkMode.value
                          ? Colors.white
                          : Color(0XFF6A6969),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Add/Edit',
                    style: Styles.textStyleTitle16.copyWith(
                      color: settingsController.isDarkMode.value
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              GetBuilder<ContactControllerSend>(
                builder: (controller) {
                  if (controller.isLoadingGetFavoriteClient.value) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Row(
                          children: [
                            buildContactWidget('', ''),
                            buildContactWidget('', ''),
                            buildContactWidget('', ''),
                            buildContactWidget('', ''),
                          ],
                        ));
                  } else {
                    return SizedBox(
                      height: 115.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.favoriteClients.length,
                        itemBuilder: (context, index) {
                          final client = controller.favoriteClients[index];
                          return buildContactWidget(client.img ?? '',
                              '${client.firstName} ${client.lastName}');
                        },
                      ),
                    );
                  }
                },
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
            if (a.user?.img != null && b.user?.img == null) {
              return -1;
            } else if (a.user?.img == null && b.user?.img != null) {
              return 1;
            } else {
              return 0;
            }
          });

          return ListView.builder(
            itemCount: controller.filteredContacts.length,
            itemBuilder: (context, index) {
              if (index < 0 || index >= controller.filteredContacts.length) {
                return const SizedBox();
              }

              var contact = controller.filteredContacts[index].phone ??
                  'لا يوجد رقم هاتف';
              var contactId = controller.filteredContacts[index].user?.id;
              var photo = controller.filteredContacts[index].user?.img;
              var firstName =
                  controller.filteredContacts[index].user?.firstName ?? '';
              var lastName =
                  controller.filteredContacts[index].user?.lastName ?? '';

              return InkWell(
                onTap: () {
                  Get.to(() => AmountSendScreenId(
                        modelCurrencies: "1",
                        modelReceiver: '$contactId',
                        name: '$firstName $lastName',
                        img: photo ?? "",
                        endPoint: 'send_amount_phone',
                      ));
                },
                child: ListTile(
                  leading: buildContactImage(photo),
                  title: Text('$firstName $lastName'),
                  subtitle: Text(contact),
                  trailing:
                      Icon(firstName.isNotEmpty ? Icons.check : Icons.error),
                ),
              );
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

  Widget buildContactWidget(String? imagePath, String name) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: const Color(0XffE0E0E0), width: 1),
          ),
          child: imagePath != null && imagePath.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: const Padding(
                          padding: EdgeInsets.all(11.0),
                          child: ImageIcon(
                            AssetImage('Assets/images/line-md_account.png'),
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: const ImageIcon(
                    AssetImage('Assets/images/line-md_account.png'),
                    size: 40,
                  ),
                ), // Default image if null or empty
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 80.w,
          child: Text(
            name,
            maxLines: 1,
            style: const TextStyle(
                color: Color(0Xff6A6969),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                overflow: TextOverflow.ellipsis),
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
    SettingsController settingsController = Get.find();

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
                  textInputType: TextInputType.number,
                  hintText: 'MBAG NUMBER / IBAN ',
                  controller: controller.mbagNumberController,
                ),
                Spacer(),
                // Use FutureBuilder to handle loading state
                Buttoms(
                  text: 'Continue',
                  color: settingsController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                  onPressed: () async {
                    controller.mbagNumberController.isNull
                        ? Get.snackbar('', 'Please Enter Mbag Number',
                            backgroundColor: Colors.red)
                        : await controller.getMbagNumberClient();
                  },
                  colorText: settingsController.isDarkMode.value
                      ? Colors.black
                      : Colors.white,
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
        var usersWithStatusPhoneTrue =
            controller.filteredUsersWithStatusPhoneTrue;

        return ListView.builder(
          itemCount: usersWithStatusPhoneTrue.length,
          itemBuilder: (context, index) {
            var contact = usersWithStatusPhoneTrue[index].phone;
            var photo = usersWithStatusPhoneTrue[index].user?.img;
            var firstName = usersWithStatusPhoneTrue[index].user?.firstName;
            var lastName = usersWithStatusPhoneTrue[index].user?.lastName;

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
                title: Text('$firstName $lastName'),
                subtitle:
                    Text(contact.isNotEmpty ? contact : 'لا يوجد رقم هاتف'),
                trailing: photo == null ? SizedBox() : Icon(Icons.check),
              ),
            );
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
// InkWell(
// onTap: () {},
// child: ListTile(
// leading: Container(
// decoration: BoxDecoration(
// color: const Color(0XFF8B959E),
// borderRadius: BorderRadius.circular(50),
// ),
// child: ClipRRect(
// borderRadius: BorderRadius.circular(50),
// child: Image.network(
// photo ?? '',
// width: 60.h,
// height: 60.h,
// fit: BoxFit.cover,
// errorBuilder: (context, error, stackTrace) =>
// const Padding(
// padding: EdgeInsets.all(11.0),
// child: ImageIcon(
// AssetImage('Assets/images/line-md_account.png'),
// size: 30,
// color: Colors.white,
// ),
// ),
// ),
// ),
// ),
// title: firstName == null
// ? SizedBox()
//     : Text('$firstName $lastName'),
// subtitle: Text(contact?.isNotEmpty ?? false
// ? contact!
// : 'لا يوجد رقم هاتف'),
// trailing: photo == null ? SizedBox() : Icon(Icons.check),
// ),
// )
//   ListView.builder(
//   itemCount: controller.filteredContacts.length,
//   itemBuilder: (context, index) {
//     if (index >= 0 && index < controller.filteredContacts.length) {
//       var contact = controller.filteredContacts[index].phone;
//       var contactId = controller.filteredContacts[index].user?.id;
//       var photo = controller.filteredContacts[index].user?.img;
//       var firstName =
//           controller.filteredContacts[index].user?.firstName;
//       var lastName =
//           controller.filteredContacts[index].user?.lastName;
//
//       return InkWell(
//         onTap: () {
//           if (firstName != null) {
//             Get.to(() => AmountSendScreenId(
//                   modelCurrencies: "1",
//                   modelReceiver: '$contactId',
//                   name: firstName ?? '',
//                   img: photo ?? "",
//                   endPoint: 'send_amount_ID',
//                 ));
//           }
//         },
//         child: ListTile(
//           leading: buildContactImage(photo),
//           title: firstName == null
//               ? SizedBox()
//               : Text('$firstName $lastName'),
//           subtitle: Text(
//               (contact.isNotEmpty ? contact : 'لا يوجد رقم هاتف')),
//           trailing:
//               firstName == null ? SizedBox() : Icon(Icons.check),
//         ),
//       );
//     } else {
//       // Handle index out of bounds case
//       return SizedBox(); // or any other widget as needed
//     }
//   },
// );
