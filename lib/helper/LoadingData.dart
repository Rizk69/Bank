import 'package:MBAG/view/Home_View/model/HomeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../Core/cache_helper.dart';
import '../view/Home_View/Widget/App_Bar_First_Home.dart';
import '../view/Home_View/Widget/Deposit_WitDraw.dart';
import '../view/Home_View/Widget/Items_First_Home.dart';

class ShimmerLoadingHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Add shimmer effect to AppBar
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  child: AppBarFirstHome(
                    showBottomSheetDrawer: (context) {},
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              // Add shimmer effect to ItemsFirstHome widget
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ItemsFirstHome(
                  onPressed1: () {
                    var token =
                        CacheHelper.getDataSharedPreference(key: 'token');
                    print('token===>$token');
                  },
                  onPressed2: () {},
                  onPressed3: () {},
                  currency: CurrencyHome(
                      id: 0,
                      name: '',
                      active: false,
                      abbreviation: '',
                      img: ''),
                ),
              ),
              SizedBox(height: 25),
              // Add shimmer effect to DepositAndWithdraw widget
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: DepositAndWithdraw(
                  balance: '',
                  accountNumber: '',
                ),
              ),
              // Add shimmer effect to _cheakIdCard widget

              SizedBox(height: 10.h),

              // Add shimmer effect to _buildTransactionListView widget
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 180.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 15.h),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 180.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
