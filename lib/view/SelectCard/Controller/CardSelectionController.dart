import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/http_helper.dart';
import '../Screen/DetailsCardScreen.dart';
import '../model/CardData.dart';

class CardController extends GetxController {
  List<CardItem> cardsListItems = [];
  var isLoading = true.obs;
  var imageItemList = <ImageItem>[].obs;
  var selectedCardId = 2.obs;
  var selectedCardImages = Rxn<int>();
  var selectedCardColors = <String>[].obs;

  var pageController = PageController(viewportFraction: 0.8).obs;

  @override
  void onInit() {
    fetchCards();
    super.onInit();
  }

  void fetchCards() async {
    try {
      isLoading.value = true;
      final response = await HttpHelper.getData(endpoint: 'get_cards');
      var jsonData = response;
      if (jsonData['status']) {
        print(response);
        cardsListItems.clear();
        imageItemList.clear();
        for (var item in jsonData['imgs']) {
          imageItemList.add(ImageItem.fromJson(item));
        }
        for (var item in jsonData['cards']) {
          cardsListItems.add(CardItem.fromJson(item));
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Get.snackbar('Error', 'Failed to load cards',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print(e);
      // Handle any errors that occur during the fetch
      Get.snackbar('Error', 'An error occurred: ${e.toString()}',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      update();
    }
  }

  Route<dynamic> fadeRoute({required Widget page, required Duration duration}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var fadedAnimation = animation.drive(tween);

        return FadeTransition(opacity: fadedAnimation, child: child);
      },
      transitionDuration: duration,
    );
  }

  void selectCard(int id) {
    selectedCardId.value = id;
  }

  void navigateToFullSizeImage(CardItem selectedCard, int index) {
    Get.to(
        () => DetailsCardScreen(
              selectedCard: selectedCard,
              index: index,
            ),
        transition: Transition.fade,
        duration: Duration(milliseconds: 500));
  }

  void selectCardColor(String color) {
    if (selectedCardColors.contains(color)) {
      selectedCardColors.remove(color);
    } else {
      if (selectedCardColors.length < 2) {
        selectedCardColors.add(color);
      }
    }
  }

  void pageForward() {
    pageController.value.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  void pageBack() {
    pageController.value.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastEaseInToSlowEaseOut);
  }

  @override
  void onClose() {
    pageController.value.dispose();
    super.onClose();
  }
}
