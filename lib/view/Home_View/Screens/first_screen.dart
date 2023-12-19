import 'package:bank/helper/LoadingData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../helper/Data.dart';
import '../../AccountDetails/Controller/AccountDetailsController.dart';
import '../../Auth_View/Add_Id_Image/Screen/CaptureIdScreen.dart';
import '../../on_bording_screen/Widget/buttom_.dart';
import '../controller/contoller_home.dart';
import 'package:bank/Core/cache_helper.dart';
import 'package:bank/Core/widgets/Styles.dart';
import 'package:bank/view/Home_View/Screens/Cashback_Screen.dart';
import 'package:bank/view/Transaction/Screen/Account_transactions_Screens.dart';
import 'package:bank/view/Home_View/Widget/App_Bar_First_Home.dart';
import 'package:bank/view/Home_View/Widget/Deposit_WitDraw.dart';
import 'package:bank/view/Home_View/Widget/Items_First_Home.dart';

class FirstScreen extends StatelessWidget {
  final HomeControllerGetData homeController = Get.put(HomeControllerGetData());
  final AccountDetailsController accountController =
      Get.put(AccountDetailsController());

  // final ContactControllerSend home = Get.put(ContactControllerSend());

  FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return homeController.isLoading.value == true
        ? ShimmerLoadingHome()
        : Scaffold(
            body: RefreshIndicator(
              onRefresh: () => homeController.refresh(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10.h),
                      AppBarFirstHome(
                        showBottomSheetDrawer: (context) {
                          return _showBottomSheetDrawer(context);
                        },
                      ),
                      SizedBox(height: 10.h),
                      ItemsFirstHome(
                        onPressed1: () {},
                        onPressed2: () {
                          _showBottomSheet(context, '');
                        },
                        onPressed3: () {
                          var token =
                              CacheHelper.getDataSharedPreference(key: 'token');
                          print('token===>$token');
                        },
                      ),
                      SizedBox(height: 25.h),
                      Obx(() => DepositAndWithdraw(
                            balance:
                                homeController.homeModel.user?.balance ?? '',
                          )),
                      SizedBox(height: 25.h),
                      Obx(() {
                        return homeController.homeModel.user?.froutid != null
                            ? SizedBox()
                            : InkWell(
                                onTap: () {
                                  Get.to(() => CameraScreenId());
                                },
                                child: _cheakIdCard());
                      }),
                      SizedBox(height: 15.h),
                      Obx(() {
                        return homeController.homeModel.user?.img != null
                            ? SizedBox()
                            : InkWell(
                                onTap: () {
                                  Get.to(() => CameraScreen());
                                },
                                child: _buildProfilePhotoContainer());
                      }),
                      SizedBox(height: 25.h),
                      _buildAccountTransactionRow(),
                      _buildTransactionListView(),
                      InkWell(
                        onTap: () {
                          Get.to(CashbackScreen());
                        },
                        child: _buildListTile('CASHBACK'),
                      ),
                      SizedBox(height: 10.h),
                      _buildPharmacyContainer(),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void _showBottomSheetDrawer(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(() => AccountTransactions());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.send_outlined,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Notification',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                  "${accountController.userModel.countNotifications ?? '0'}",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xffA6ABBD)),
                  ),
                  InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.reply_all,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Request Money',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xffA6ABBD)),
                  ),
                  InkWell(
                      onTap: () {
                        // Get.to(QrPay());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.interpreter_mode,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'International Money transfer',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xffA6ABBD)),
                  ),
                  InkWell(
                      onTap: () {
                        // Get.to(QrPay());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.refresh_outlined,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Recurrig transfer',
                              style: Styles.textStyleTitle18
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Buttoms(
                  text: 'Cancel',
                  color: Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                  colorText: Colors.white),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfilePhotoContainer() {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.1,
            blurRadius: 8,
            offset: Offset(1, 0.5),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
              child: const ImageIcon(
                AssetImage('Assets/images/line-md_account.png'),
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Profile Photo', style: Styles.textStyleTitle16),
                Text('You can add a photo', style: Styles.textStyleTitle12),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.navigate_next_outlined, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cheakIdCard() {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.1,
            blurRadius: 8,
            offset: Offset(1, 0.5),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
              child: const ImageIcon(
                AssetImage('Assets/images/line-md_account.png'),
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 10.h),
            Text(
              'Please Enter \nPersonal ID Card Image',
              style: Styles.textStyleTitle16,
              maxLines: 2,
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.navigate_next_outlined, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountTransactionRow() {
    return InkWell(
      onTap: () {
        Get.to(() => AccountTransactions());
      },
      child: _buildListTile('ACCOUNT TRANSACTION'),
    );
  }

  Widget _buildListTile(String title) {
    return Row(
      children: [
        Text(title, style: Styles.textStyleTitle16),
        SizedBox(width: 4),
        Icon(Icons.navigate_next_outlined, color: Colors.black),
      ],
    );
  }

  Widget _buildTransactionListView() {
    return Obx(
      () {
        var transactions = homeController.homeModel.trans;

        if (transactions == null || transactions.isEmpty) {
          return SizedBox(
            height: 20.h,
          );
        }

        return SizedBox(
          height: 230.h,
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              var transaction = transactions[index];
              String formattedDate = DateUtilsFormat.formatTransactionDate(
                transaction.createdAt ?? '',
              );

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            transaction.receiverImg ?? '',
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Icon(Icons.account_circle, size: 40),
                              );
                            },
                            fit: BoxFit.fill,
                            height: 55.h,
                            width: 50.w,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(transaction.senderFirstName ?? '',
                                style: Styles.textStyleTitle14),
                            SizedBox(height: 5),
                            Text(
                              transaction.senderLastName ?? '',
                              style: Styles.textStyleTitle14.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            ImageIcon(
                              AssetImage('Assets/images/Vector(9).png'),
                              color: transaction.finalAmount! >= 0
                                  ? Color(0XFF4FD25D)
                                  : Colors.red,
                            ),
                            SizedBox(width: 7.h),
                            Text(
                              "${transaction.finalAmount}",
                              style: Styles.textStyleTitle24.copyWith(
                                color: transaction.finalAmount! >= 0
                                    ? Color(0XFF4FD25D)
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              formattedDate ?? 'Unknown Date',
                              style: Styles.textStyleTitle12.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPharmacyContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0XFFEBEBEB), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPharmacyItem('Pharmacy', '10%', Color(0XFF86E08F)),
          _buildPharmacyItem('EcZane', 'lorem epsim', Color(0XFF979797)),
        ],
      ),
    );
  }

  Widget _buildPharmacyItem(String title, String subtitle, Color subtitleColor) {
    return Row(
      children: [
        Image(
          image: AssetImage('Assets/images/Clip path group.png'),
          height: 40,
          width: 30,
        ),
        SizedBox(width: 13.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
              Styles.textStyleTitle16.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              subtitle,
              style: Styles.textStyleTitle16.copyWith(
                fontWeight: FontWeight.w500,
                color: subtitleColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, String content) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(content),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close Bottom Sheet'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
