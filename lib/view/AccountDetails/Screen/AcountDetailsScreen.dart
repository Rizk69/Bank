import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Core/cache_helper.dart';
import '../../../Core/widgets/Styles.dart';
import '../../../helper/Dark/SettingsController.dart';
import '../../on_bording_screen/Screen/OnbordingScreen.dart';
import '../../on_bording_screen/Widget/buttom_.dart';
import '../Controller/AccountDetailsController.dart';
import '../Widget/ItemsAccoutDetails.dart';

class AccountDetailsScreen extends StatelessWidget {
  final AccountDetailsController userController =
      Get.put(AccountDetailsController());
  final SettingsController settingsController = Get.put(SettingsController());

  AccountDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => userController.isLoading.isTrue
          ? SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),
                        Text(
                          'Account Details',
                          style: Styles.textStyleTitle24
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox()
                      ],
                    ),
                    SizedBox(
                      height: 42.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: userController.takePhotoAndSendToAPI,
                          child: SizedBox(
                            height: 100.h,
                            width: 110.h,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0XFF8B959E),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      userController.userModel.user!.img ?? '',
                                      width: 100.h,
                                      height: 100.h,
                                      fit: BoxFit.cover,
                                      // Ensure the image covers the container
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child: ImageIcon(
                                          AssetImage(
                                              'Assets/images/line-md_account.png'),
                                          size: 70,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 70.h,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Icon(Icons.camera_alt_outlined,
                                        color: Colors.white, size: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${userController.userModel.user?.firstName} ${userController.userModel.user?.lastName}" ??
                                  '',
                              style: Styles.textStyleTitle16
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              userController.userModel.user?.phone ?? '',
                              style: Styles.textStyleTitle16.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0Xff6A6969)),
                            ),
                            SizedBox(
                              width: 170.w,
                              child: Text(
                                maxLines: 1,
                                "${userController.userModel.user?.email}" ?? '',
                                style: Styles.textStyleTitle16.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0Xff6A6969),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.language),
                                onPressed: () => _showLanguageDialog(context),
                              ),
                              IconButton(
                                icon: const Icon(Icons.brightness_4),
                                onPressed: () {
                                  settingsController.toggleDarkMode();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 31.h,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: settingsController.isDarkMode.value
                            ? Colors.black
                            : Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Account Type',
                                  style: Styles.textStyleTitle12),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                userController.userModel.user?.accountType ??
                                    '',
                                style: Styles.textStyleTitle14
                                    .copyWith(fontSize: 20),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    ItemsAccountDetails(
                      title: 'Account type',
                      des: 'Unverified Approved or Verified',
                      caption: 'Verified Account',
                    ),
                    ItemsAccountDetails(
                      title: 'MBAG Number',
                      des: 'You can receive money or payment\nby sharing',
                      caption: userController.userModel.user?.accountNumber ??
                          'Empty',
                    ),
                    ItemsAccountDetails(
                      title: 'Total balance',
                      des: 'The total sum of balances in your account',
                      caption:
                          userController.userModel.user?.balance ?? 'Empty',
                    ),
                    ItemsAccountDetails(
                      title: 'The maximum limit\nof the credit card',
                      des: '',
                      caption: "${userController.userModel.user?.limitCart}",
                    ),
                    ItemsAccountDetails(
                      title: 'The maximum limit\nof the account',
                      des: '',
                      caption: "${userController.userModel.user?.limitAccount}",
                    ),
                    ItemsAccountDetails(
                      title: 'The maximum limit\nfor transfers in a day',
                      des: '',
                      caption:
                          "${userController.userModel.user?.limitTransferDay}",
                    ),
                    ItemsAccountDetails(
                      title: 'The maximum limit\nfor transfers in a month',
                      des: '',
                      caption:
                          "${userController.userModel.user?.limitTransferManth}",
                    ),
                    ItemsAccountDetails(
                      title: 'Incoming amount limit',
                      des: 'Unverified Approved or Verified',
                      caption:
                          "${userController.userModel.user?.limitReceptionDay}",
                    ),
                    ItemsAccountDetails(
                      title: 'The maximum limit\nfor receiving in a month',
                      des: '',
                      caption:
                          "${userController.userModel.user?.limitReceptionManth}",
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width,
                        child: Buttoms(
                            text: 'Log Out',
                            color: Colors.red,
                            onPressed: () {
                              CacheHelper.clearData();

                              CacheHelper.removeData(key: 'token');
                              CacheHelper.removeData(key: 'user_id');
                              CacheHelper.removeData(key: 'user');

                              Get.offAll(CupertinoOnboardingScreen());
                            },
                            colorText: Colors.white))
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // ...
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 70.h,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 70.h,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 70.h,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 70.h,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 70.h,
                        width: double.infinity,
                      ),
                    ),

                    // ...
                  ],
                ),
              ),
            )),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    // عرض قائمة اللغات للمستخدم
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('English'),
                onTap: () => settingsController.changeLanguage('en', 'US'),
              ),
              ListTile(
                title: const Text('العربية'),
                onTap: () => settingsController.changeLanguage('ar', 'SA'),
              ),
            ],
          ),
        );
      },
    );
  }
}
