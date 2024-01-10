import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/helper/Dark/SettingsController.dart';
import 'package:MBAG/view/Money_Transfer/Controller/ContactControllerSend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Core/widgets/custom_text_form_field.dart';
import '../../Screen/ScreenAmountSend.dart';

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
                          ],
                        ));
                  } else {
                    return SizedBox(
                      height: 105.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.favoriteClients.length,
                        itemBuilder: (context, index) {
                          final client = controller.favoriteClients[index];
                          return InkWell(
                            onTap: () {
                              print(client.id);

                              Get.to(() => AmountSendScreenId(
                                    modelReceiver: '${client.id}',
                                    name:
                                        '${client.firstName} ${client.lastName}',
                                    img: client.img ?? "",
                                    endPoint: 'send_amount_phone',
                                  ));
                            },
                            child: buildContactWidget(client.img ?? '',
                                '${client.firstName} ${client.lastName}'),
                          );
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
                    'Contact using MBAG ${contactController.filteredUsersWithStatusPhoneTrue.length}',
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
                        ? buildContactListView(context)
                        : Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              margin: const EdgeInsets.all(8),
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

  Widget buildContactListView(BuildContext context) {
    SettingsController settingsController = Get.find();

    return GetBuilder<ContactControllerSend>(
        initState: (state) => ContactControllerSend(),
        builder: (controller) {
          controller.filteredContacts.sort((a, b) {
            if (a.user?.firstName != null && b.user?.firstName == null) {
              return -1;
            } else if (a.user?.firstName == null && b.user?.firstName != null) {
              return 1;
            } else {
              return 0;
            }
          });

          return SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
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
                      trailing: firstName.isNotEmpty
                          ? ImageIcon(
                              const AssetImage('Assets/images/M black.png'),
                              color: settingsController.isDarkMode.value
                                  ? Colors.orangeAccent
                                  : Colors.black,
                              size: 25,
                            )
                          : SizedBox()),
                );
              },
            ),
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
          width: 60,
          height: 60,
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
                      return const Center(
                        child: Padding(
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
              : const Center(
                  child: ImageIcon(
                    AssetImage('Assets/images/line-md_account.png'),
                    size: 40,
                  ),
                ), // Default image if null or empty
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80.w,
          child: Center(
            child: Text(
              name.length > 6 ? name.substring(0, 6) : '..',
              // هنا تم استخدام substring
              maxLines: 1,
              style: const TextStyle(
                  color: Color(0Xff6A6969),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ),
      ],
    );
  }
}
