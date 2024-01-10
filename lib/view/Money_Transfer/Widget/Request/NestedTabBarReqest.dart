import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/Core/widgets/custom_text_form_field.dart';
import 'package:MBAG/view/Money_Transfer/Controller/ContactControllerSendRequest.dart';
import 'package:MBAG/view/Money_Transfer/Widget/Request/ContactListPageRequest.dart';
import 'package:MBAG/view/Money_Transfer/Widget/Request/MbagNumberTabBarRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NestedTabBarRequest extends StatefulWidget {
  NestedTabBarRequest({super.key});

  @override
  State<NestedTabBarRequest> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBarRequest>
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
            children: <Widget>[
              ContactListPageRequest(),
              MbagNumberTabBarRequest()
            ],
          ),
        ),
      ],
    );
  }
}



