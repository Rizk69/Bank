import 'package:MBAG/helper/LoadingData.dart';
import 'package:MBAG/view/Auth_View/Add_Id_Image/Screen/AddImage/AddImagefront.dart';
import 'package:MBAG/view/NotificationView/Screen/NotificationScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:MBAG/view/Home_View/model/HomeModel.dart' as HomeModel;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../helper/Dark/SettingsController.dart';
import '../../../helper/Data.dart';
import '../../../helper/HelperScreenNerst.dart';
import '../../AccountDetails/Controller/AccountDetailsController.dart';
import '../../Auth_View/Add_Id_Image/Screen/CaptureIdScreen.dart';
import '../../Trader/Controller/TraderController.dart';
import '../../on_bording_screen/Widget/buttom_.dart';
import 'package:MBAG/Core/cache_helper.dart';
import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/view/Trader/Screen/Cashback_Screen.dart';
import 'package:MBAG/view/Transaction/Screen/Account_transactions_Screens.dart';
import 'package:MBAG/view/Home_View/Widget/App_Bar_First_Home.dart';
import 'package:MBAG/view/Home_View/Widget/Deposit_WitDraw.dart';
import 'package:MBAG/view/Home_View/Widget/Items_First_Home.dart';

import '../controller/HomeGetData.dart';
import '../model/HomeModel.dart';

class FirstScreen extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);
  final SettingsController settingsController = Get.find();

  final AccountDetailsController userController =
      Get.put(AccountDetailsController());
  final HomeControllerGetData homeControllerGetData =
      Get.put(HomeControllerGetData());

  FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeControllerGetData>(
        builder: (homeController) {
          if (homeController.isLoading.value) {
            return ShimmerLoadingHome();
          } else if (homeController.isDataLoaded.value) {
            return SmartRefresher(
              onRefresh: () => homeController.refreshDataHome(),
              enablePullDown: true,
              controller: _refreshController,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 15.h),
                      AppBarFirstHome(
                        showBottomSheetDrawer: (context) {
                          return _showBottomSheetDrawer(context);
                        },
                      ),
                      SizedBox(height: 15.h),
                      ItemsFirstHome(
                        onPressed1: () {
                          Get.to(() => SlideDownTextAnimation(
                                appBarView: true,
                              ));
                        },
                        onPressed2: () {
                          _showBottomSheet(
                              context, homeController.currencyModel);
                        },
                        onPressed3: () {
                          var token =
                              CacheHelper.getDataSharedPreference(key: 'token');
                          print('token===>$token');
                          Get.to(() => SlideDownTextAnimation(
                                appBarView: true,
                              ));
                        },
                        currency: homeController.selectedCurrency.value ??
                            CurrencyHomeModel(
                                id: 0,
                                name: '',
                                active: false,
                                abbreviation: '',
                                img: '',
                                amount: ''),
                      ),
                      SizedBox(height: 25.h),
                      DepositAndWithdraw(
                        abbreviation: homeController
                                .selectedCurrency.value?.abbreviation ??
                            '',
                        balance:
                            homeController.selectedCurrency.value?.amount ?? '',
                        accountNumber:
                            homeController.homeModel.user?.accountNumber ?? '',
                      ),
                      SizedBox(height: 15.h),
                      homeController.homeModel.user?.froutid != null
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                Get.to(() => CameraScreenId());
                              },
                              child: _cheakIdCard()),
                      SizedBox(height: 15.h),
                      homeController.homeModel.user?.img != null
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                Get.to(() => CameraScreen());
                              },
                              child: _buildProfilePhotoContainer()),
                      homeController.homeModel.user?.img != null
                          ? SizedBox()
                          : SizedBox(height: 25.h),
                      _buildAccountTransactionRow(),
                      _buildTransactionListView(homeController.homeModel.trans),
                      InkWell(
                        onTap: () {
                          Get.to(() => CashbackScreen());
                        },
                        child: _buildListTile('CASHBACK'.tr),
                      ),
                      SizedBox(height: 10.h),
                      _buildPharmacyContainer(
                          homeController.homeModel.traders!, context),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load data'),
                  ElevatedButton(
                    onPressed: () {
                      homeController.refreshDataHome();
                    },
                    child: const Text('OBS Retry'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _showBottomSheetDrawer(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: settingsController.isDarkMode.value
                        ? Colors.black87
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Get.to(() => NotificationScreenHome());
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
                                    "${userController.userModel.countNotifications}",
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
                        onTap: () {
                          Get.to(() => SlideDownTextAnimation(
                                appBarView: true,
                              ));
                        },
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
                          Get.to(() => SlideDownTextAnimation(
                                appBarView: true,
                              ));
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
                          Get.to(() => SlideDownTextAnimation(
                                appBarView: true,
                              ));
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
                    color: settingsController.isDarkMode.value
                        ? Colors.black
                        : Colors.black,
                    onPressed: () {
                      Get.back();
                    },
                    colorText: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfilePhotoContainer() {
    return Obx(
      () => Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color:
              settingsController.isDarkMode.value ? Colors.black : Colors.white,
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
                  Text('Add Profile Photo'.tr, style: Styles.textStyleTitle16),
                  Text('You can add a photo'.tr,
                      style: Styles.textStyleTitle12),
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
      ),
    );
  }

  Widget _cheakIdCard() {
    return Obx(
      () => Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color:
              settingsController.isDarkMode.value ? Colors.black : Colors.white,
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
                'Please Enter \nPersonal ID Card Image'.tr,
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
      ),
    );
  }

  Widget _buildAccountTransactionRow() {
    return InkWell(
      onTap: () {
        Get.to(() => AccountTransactions());
      },
      child: _buildListTile('ACCOUNT TRANSACTION'.tr),
    );
  }

  Widget _buildListTile(String title) {
    return Row(
      children: [
        Text(title, style: Styles.textStyleTitle16),
        SizedBox(width: 4),
        Icon(Icons.navigate_next_outlined,
            color: settingsController.isDarkMode.value
                ? Colors.white
                : Colors.black),
      ],
    );
  }

  Widget _buildTransactionListView(List<HomeModel.Trans>? trans) {
    var transactions = trans!;
    return SizedBox(
      height: transactions.isEmpty ? 20.h : 230.h,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          var transaction = transactions[index];
          String formattedDate = DateUtilsFormat.formatTransactionDate(
            transaction.createdAt ?? '',
          );

          return transactions.isEmpty
              ? Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(15),
                  height: 80.h,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Text(
                    'Empty',
                    style: Styles.textStyleTitle18,
                  )),
                )
              : Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  child: InkWell(
                    onTap: () {
                      homeControllerGetData.getTransactionsDetails(
                          id: transaction.id);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    transaction.receiverImg ?? '',
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: const SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Center(
                                            child: Icon(
                                              Icons.account_circle,
                                              size: 50,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    fit: BoxFit.fill,
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(transaction.receiverFirstName ?? '',
                                        style: Styles.textStyleTitle14),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      transaction.receiverLastName ?? "",
                                      style: Styles.textStyleTitle14.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${transaction.finalAmount ?? '0'}",
                                  textAlign: TextAlign.right,
                                  style: Styles.textStyleTitle24.copyWith(
                                    color: transaction.finalAmount != null &&
                                            transaction.finalAmount! >= 0
                                        ? Color(0XFF4FD25D)
                                        : Colors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.h,
                                ),
                                Text(
                                  transaction.abbreviation ?? '',
                                  style: Styles.textStyleTitle18.copyWith(
                                    color: transaction.finalAmount != null &&
                                            transaction.finalAmount! > 0
                                        ? Color(0XFF4FD25D)
                                        : Colors.red,
                                  ),
                                )
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
                  ),
                );
        },
      ),
    );
  }

  Widget _buildPharmacyContainer(List<Traders> traders, BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          CashBakController cashBakController = Get.put(CashBakController());

          return InkWell(
            onTap: () {
              final traderId = traders[index].id;
              if (traderId != null) {
                cashBakController.getTraderAddress(id: traderId);
              }
            },
            child: Container(
              width: 300.w,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0XFFEBEBEB), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPharmacyItem(
                      traders[index].img ?? '',
                      traders[index].activityName!,
                      "${traders[index].discount!}",
                      Color(0XFF86E08F)),

                  // _buildPharmacyItem('EcZane', 'lorem epsim', Color(0XFF979797)),
                ],
              ),
            ),
          );
        },
        itemCount: traders.length,
      ),
    );
  }

  Widget _buildPharmacyItem(
      String image, String title, String subtitle, Color subtitleColor) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            image,
            height: 50.h,
            width: 40.h,
            errorBuilder: (context, error, stackTrace) => SizedBox(),
          ),
        ),
        SizedBox(width: 23.h),
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

  void _showBottomSheet(
    BuildContext context,
    CurrencyModel currencies,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: settingsController.isDarkMode.value
                  ? Colors.black38
                  : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            child: Column(
              children: [
                Text(
                  'Accounts',
                  style: Styles.textStyleTitle24.copyWith(fontSize: 30),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      bool isActive;
                      if (currencies.currencies[index].active == true) {
                        isActive = true;
                      } else {
                        isActive = false;
                      }
                      return InkWell(
                        onTap: () {
                          if (isActive == true) {
                            homeControllerGetData
                                .selectCurrency(currencies.currencies[index]);
                            Navigator.pop(context);
                          }
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      currencies.currencies[index].img ?? '',
                                      height: 25.h,
                                      width: 25.h,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const SizedBox(),
                                    )),

                                // const SizedBox(
                                //   width: 20,
                                //   child: Center(child: Text('--')),
                                // ),

                                const SizedBox(
                                  width: 10,
                                  // child: Center(child: Text('--')),
                                ),
                                Text(
                                    currencies.currencies[index].abbreviation ??
                                        '',
                                    style: Styles.textStyleTitle20.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),

                                // Text(currencies.currencies[index].name ?? '',
                                //     style: Styles.textStyleTitle14),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    if (isActive == false) {
                                      homeControllerGetData.requestAntherAccount(
                                          currencyId:
                                              "${currencies.currencies[index].id}" ??
                                                  '0');
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                      width: 80.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                          color: isActive
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                            isActive ? 'Active' : 'NoActive',
                                            style: Styles.textStyleTitle14
                                                .copyWith(color: Colors.white)),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5.h,
                            ),
                            Container(
                              height: 0.5,
                              padding: EdgeInsets.symmetric(vertical: 30),
                              margin: EdgeInsets.only(
                                  right: 10, top: 10, bottom: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade700, width: 0.2)),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: currencies.currencies.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
