import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/http_helper.dart';
import '../model/CardData.dart';

// class CardController extends GetxController {
//   var cardsList = <CardData>[].obs;
//   var selectedCard = Rxn<CardData>();
//   var pageController = PageController(viewportFraction: 0.8).obs;
//   var selectedCardId = 0.obs;
//   var isCardPressed= true.obs;
//   var selectedCardColor = 'Black'.obs;
//
//
//   @override
//   void onInit() {
//     fetchCards();
//     super.onInit();
//   }
//
//   void fetchCards() async {
//     final response = await HttpHelper.getData(endpoint: 'get_cards');
//     var jsonData = response;
//     if (jsonData['status']) {
//       for (var item in jsonData['cards']) {
//         cardsList.add(CardData.fromJson(item));
//       }
//     } else {
//       Get.snackbar('Error', 'Failed to load cards');
//     }
//   }
//
//   void selectCard(int id) {
//     selectedCardId.value = id;
//   }
//
//   void selectCardColor(String color) {
//     selectedCardColor.value = color;
//   }
//
//   bool isSelected(CardData card) {
//     return selectedCard.value?.id == card.id;
//   }
//
//   void pageForward() {
//     pageController.value.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
//   }
//
//   void pageBack() {
//     pageController.value.previousPage(duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
//   }
//
//   @override
//   void onClose() {
//     pageController.value.dispose();
//     super.onClose();
//   }
// }
class CardController extends GetxController {
  List<CardItem> cardsListItems = [];

  var imageItemList = <ImageItem>[].obs;
  var selectedCardId = Rxn<int>();
  var selectedCardImages = Rxn<int>();
  var selectedCardColor = Rxn<String>();
  var pageController = PageController(viewportFraction: 0.8).obs;

  @override
  void onInit() {
    fetchCards();
    super.onInit();
  }

  void fetchCards() async {
    try {
      final response = await HttpHelper.getData(endpoint: 'get_cards');
      var jsonData = response;
      if (jsonData['status']) {
        cardsListItems.clear();
        imageItemList.clear();
        for (var item in jsonData['imgs']) {
          imageItemList.add(ImageItem.fromJson(item));
        }
        for (var item in jsonData['cards']) {
          cardsListItems.add(CardItem.fromJson(item));
        }
      } else {
        Get.snackbar('Error', 'Failed to load cards');
      }
    } catch (e) {
      print(e);
      // Handle any errors that occur during the fetch
      Get.snackbar('Error', 'An error occurred: ${e.toString()}');
    }
  }

  void selectCard(int id) {
    selectedCardId.value = id;
  }

  void selectCardColor(String color) {
    selectedCardColor.value = color;
  }

  void pageForward() {
    pageController.value.nextPage(
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void pageBack() {
    pageController.value.previousPage(
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  void onClose() {
    pageController.value.dispose();
    super.onClose();
  }
}
