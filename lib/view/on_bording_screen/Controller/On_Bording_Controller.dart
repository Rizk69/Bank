import 'package:get/get.dart';

class CupertinoOnBoardingController extends GetxController {
  int _selectedIndex = 0;

  get selectedIndex => _selectedIndex;

  void changeSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }
}

class OnBoardingModel {
  final String title;
  final String description;
  final String imageUrl;

  OnBoardingModel(this.title, this.description, this.imageUrl);
}
