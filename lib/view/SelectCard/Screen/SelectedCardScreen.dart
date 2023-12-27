import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Controller/CardSelectionController.dart';
import '../model/CardData.dart';

class CardScreen extends StatelessWidget {
  final CardController controller = Get.put(CardController());

  CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MBAG card'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Obx(() => buildCardList()),
            Obx(() => buildSelectedCardDetails()),
            Spacer(),
            SizedBox(
                width: double.infinity,
                child: Buttoms(
                  color: Colors.white,
                  colorText: Colors.black,
                  text: 'Request / Add a MBAG card ',
                  onPressed: () {},
                ))
          ],
        ),
      ),
    );
  }

  Widget buildCardList() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.imageItemList.length,
        itemBuilder: (context, index) {
          var card = controller.imageItemList[index];
          return GestureDetector(
            onTap: () {
              controller.selectCard(card.id);
              controller.selectCardColor(''); // Reset selected color
            },
            child: Card(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(card.img1 ?? 'placeholder_image_url')),
            ),
          );
        },
      ),
    );
  }

  Widget buildSelectedCardDetails() {
    var selectedCardId = controller.selectedCardId.value;
    if (selectedCardId == null) return SizedBox();

    var selectedCard = controller.cardsListItems.firstWhere(
      (card) => card.id == selectedCardId,
      orElse: () => CardItem(
        id: 0,
        name: '',
        imgs: {},
        colors: {},
        description: '',
        activityId: 0,
        activityName: '',
      ),
    );

    return Column(
      children: [
        CardDetails(selectedCard: selectedCard),
        Wrap(
          spacing: 30,
          runSpacing: 15,
          children: selectedCard.colors.entries
              .map((entry) => colorButton(entry.key, entry.value))
              .toList(),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          ' ${selectedCard.name}',
          style: Styles.textStyleTitle24,
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          ' ${selectedCard.description}',
          style: Styles.textStyleTitle14.copyWith(color: Color(0XFF979797)),
        ),
      ],
    );
  }

  Widget colorButton(String colorName, String color) {
    return Obx(() {
      String colorValue = '0xFF${color.substring(1)}';

      bool isSelected = controller.selectedCardColor.value == colorName;
      print(controller.selectedCardColor.value);
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: FilterChip(
          selectedShadowColor: Colors.orangeAccent,
          side: BorderSide(color: Colors.transparent, width: 1),
          padding: EdgeInsets.all(15),
          label: Text(colorName),
          selected: isSelected,
          onSelected: (bool selected) {
            controller.selectCardColor(colorName);
          },
          backgroundColor: Colors.white,
          showCheckmark: true,
          checkmarkColor: Colors.white,
          selectedColor: Color(int.parse(colorValue)),
        ),
      );
    });
  }
}

class CardDetails extends StatelessWidget {
  final CardItem selectedCard;
  final CardController controller = Get.find<CardController>();

  CardDetails({super.key, required this.selectedCard});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: ImageIcon(
                    AssetImage("Assets/images/Vector(15).png"),
                    color: Colors.grey,
                  ),
                  onPressed: () => controller.pageBack(),
                ),
                Expanded(
                  child: PageView.builder(
                    allowImplicitScrolling: false,
                    controller: controller.pageController.value,
                    itemCount: selectedCard.imgs.length,
                    onPageChanged: (index) {
                      index + 1;
                      controller.selectedCardImages.value = index;
                    },
                    itemBuilder: (context, index) {
                      String imgUrl = selectedCard.imgs["${index + 1}"] ??
                          ''; // تصحيح الـ index
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Image.network(
                          imgUrl,
                          errorBuilder: (context, error, stackTrace) =>
                              SizedBox(),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: ImageIcon(
                    AssetImage(
                      "Assets/images/Vector(14).png",
                    ),
                    color: Colors.grey,
                  ),
                  onPressed: () => controller.pageForward(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
