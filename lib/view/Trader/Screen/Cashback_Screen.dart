import 'package:MBAG/view/Trader/model/CashBackModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Core/widgets/Styles.dart';
import '../Controller/TraderController.dart';
import 'TermsView.dart';

class CashbackScreen extends StatelessWidget {
  CashBakController cashBakController = Get.put(CashBakController());

  CashbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cashBakController.getTrader();
    return Scaffold(
      body: GetBuilder<CashBakController>(
        builder: (controller) => buildBody(controller, context),
      ),
    );
  }

  Widget buildBody(CashBakController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
            ),
            buildHeader(),
            SizedBox(height: 30.h),
            buildTradersSection(controller.cashBackModel.traders),
            SizedBox(height: 24.h),
            buildTotalEarningsSection(controller.cashBackModel.balance),
            SizedBox(height: 24.h),
            buildCategorySection(controller.cashBackModel.traders),
            SizedBox(height: 24.h),
            buildBrandsSection(controller.cashBackModel.brands),
            SizedBox(height: 24.h),
            buildTermsOfUseSection(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, size: 28),
        ),
        Text(
          'Cashback ',
          style: Styles.textStyleTitle24,
        ),
        const ImageIcon(
          AssetImage('Assets/images/carbon_settings.png'),
          size: 25,
        ),
      ],
    );
  }

  Widget buildTradersSection(List<Traders>? traders) {
    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            final traderId = traders?[index].id;
            if (traderId != null) {
              cashBakController.getTraderAddress(id: traderId);
            }
          },
          child: buildTraderItem(
            trader: traders?[index],
          ),
        ),
        itemCount: traders?.length ?? 0,
      ),
    );
  }

  Widget buildTraderItem({Traders? trader}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Container(
            height: 80.h,
            width: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Color(0XffE0E0E0), width: 1),
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  trader?.img ?? '',
                  height: 42,
                  width: 42,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            trader?.firstName ?? '',
            style: Styles.textStyleTitle14.copyWith(
              color: Color(0Xff6A6969),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '${trader?.discount}%',
            style: Styles.textStyleTitle14.copyWith(
              color: Color(0Xff44CF52),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategorySection(List<Traders>? traders) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            final traderId = traders?[index].id;
            if (traderId != null) {
              cashBakController.getTraderAddress(id: traderId);
            }
          },
          child: buildCategoryItem(
            trader: traders?[index],
          ),
        ),
        itemCount: traders?.length ?? 0,
      ),
    );
  }

  Widget buildCategoryItem({Traders? trader}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        height: 80.h,
        width: 250.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0XffA6ABBD), width: 1),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                trader?.img ?? '',
                height: 42,
                width: 42,
              ),
            ),
            SizedBox(
              width: 15.h,
            ),
            Text(
              trader?.firstName ?? '',
              style:
                  Styles.textStyleTitle16.copyWith(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTotalEarningsSection(String? totalEarnings) {
    return Column(
      children: [
        Text(
          'Your total earning this month ',
          style: Styles.textStyleTitle16.copyWith(
            color: Color(0XFF565656),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImageIcon(
              AssetImage('Assets/images/Vector(9).png'),
              size: 30,
            ),
            SizedBox(width: 7.h),
            Text(
              totalEarnings ?? '',
              style: Styles.textStyleTitle24.copyWith(fontSize: 33),
            ),
          ],
        ),
        SizedBox(height: 13.h),
        Text(
          'Your total earning to date 23-11',
          style: Styles.textStyleTitle12.copyWith(
            color: Color(0XFF565656),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget buildCategoriesSection(List<Traders>? traders) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CATEGORIES',
          style: Styles.textStyleTitle16.copyWith(
            color: Color(0XFF565656),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 155.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => buildTraderItem(
              trader: traders?[index],
            ),
            itemCount: traders?.length ?? 0,
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget buildBrandsSection(List<Brands>? brands) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BRANDS ',
          style: Styles.textStyleTitle16.copyWith(
            color: Color(0XFF565656),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 190.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                final brandsId = brands?[index].id;
                if (brandsId != null) {
                  cashBakController.getTraderAddress(id: brandsId);
                }
              },
              child: buildBrandItem(
                brand: brands?[index],
              ),
            ),
            itemCount: brands?.length ?? 0,
          ),
        ),
      ],
    );
  }

  Widget buildBrandItem({Brands? brand}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 56, vertical: 20),
        height: 150.h,
        width: 360.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0XffA6ABBD), width: 1),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                brand?.img ?? '',
                height: 60,
                width: 60,
              ),
            ),
            SizedBox(height: 13.h),
            Text(
              brand?.firstName ?? '',
              style: Styles.textStyleTitle20.copyWith(
                fontWeight: FontWeight.w400,
                color: Color(0XFF6A6969),
              ),
            ),
            SizedBox(height: 7.h),
            Text(
              '${brand?.discount}%',
              style: Styles.textStyleTitle16.copyWith(
                fontWeight: FontWeight.w500,
                color: Color(0XFF44CF52),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTermsOfUseSection() {
    return GestureDetector(
      onTap: () {
        Get.to(() => TermsUserScreen());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'Assets/images/carbon_terminal-3270.png',
            height: 27,
          ),
          SizedBox(width: 10.h),
          Text(
            'Terms of use',
            style:
                Styles.textStyleTitle16.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
