import 'package:MBAG/view/Money_Transfer/Widget/send/ContactListPageSend.dart';
import 'package:MBAG/view/Money_Transfer/Widget/send/MbagNumberTabBarSend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../helper/Dark/SettingsController.dart';

class NestedTabBar extends StatefulWidget {
  const NestedTabBar({super.key});

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




