import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NestedTabBarController extends GetxController
    with SingleGetTickerProviderMixin {
  final RxInt myCounter = 0.obs;
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
