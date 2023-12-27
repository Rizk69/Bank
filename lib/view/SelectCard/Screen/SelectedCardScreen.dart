import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:MBAG/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../Controller/CardSelectionController.dart';
import '../model/CardData.dart';

class CardScreen extends StatelessWidget {
  final CardController controller = Get.put(CardController());

  CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  Text(
                    'MBAG card',
                    style: Styles.textStyleTitle24
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox()
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              GetBuilder<CardController>(
                builder: (_) {
                  if (controller.isLoading.value) {
                    return SizedBox(
                        height: 600.h,
                        child: buildShimmerEffect()); // Show loading shimmer
                  } else {
                    return Column(
                      children: [
                        Obx(() => buildCardList()),
                        Obx(() => buildSelectedCardDetails(context)),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 48.0,
                height: 48.0,
                color: Colors.white,
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(height: 8.0, color: Colors.white),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                    Container(
                        height: 8.0,
                        width: double.infinity,
                        color: Colors.white),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                    Container(
                        height: 8.0,
                        width: double.infinity,
                        color: Colors.white),
                  ],
                ),
              )
            ],
          ),
        ),
        itemCount: 6, // Number of shimmer items
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
              controller.selectCardColor('');
            },
            child: Card(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(card.img1)),
            ),
          );
        },
      ),
    );
  }

  Widget buildSelectedCardDetails(BuildContext context) {
    var selectedCardId = controller.selectedCardId.value;
    var selectedCard = controller.cardsListItems.firstWhere(
      (card) => card.id == selectedCardId,
      orElse: () => CardItem(
        id: 0,
        name: '',
        imgs: {},
        colors: [],
        description: '',
        activityId: 0,
        activityName: '',
        request: 0,
      ),
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.66,
      child: Column(
        children: [
          CardDetails(selectedCard: selectedCard),
          Wrap(
            spacing: 30,
            runSpacing: 15,
            children: selectedCard.colors
                .map(
                    (colorItem) => colorButton(colorItem.name, colorItem.color))
                .toList(),
          ),
          SizedBox(height: 20.h),
          Text(' ${selectedCard.name}', style: Styles.textStyleTitle24),
          SizedBox(height: 16.h),
          Text(' ${selectedCard.description}',
              style:
                  Styles.textStyleTitle14.copyWith(color: Color(0XFF979797))),
          const Spacer(),
          SizedBox(
              width: double.infinity,
              child: Buttoms(
                color: Colors.white,
                colorText: Colors.black,
                text:
                    '${selectedCard.request == 0 ? 'Buy' : 'Request'} / Add a MBAG card ',
                onPressed: () {},
              ))
        ],
      ),
    );
  }

  Widget colorButton(String colorName, String color) {
    return Obx(() {
      String colorValue = '0xFF${color.substring(1)}';
      bool isSelected = controller.selectedCardColors.contains(colorName);

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
                    controller: controller.pageController.value,
                    itemCount: selectedCard.imgs.length,
                    onPageChanged: (index) {
                      controller.selectedCardImages.value =
                          index; // Update the selected image index
                    },
                    itemBuilder: (context, index) {
                      String imgUrl = selectedCard.imgs["${index + 1}"] ??
                          ''; // Correctly access the URL
                      return GestureDetector(
                        onTap: () =>
                            controller.navigateToFullSizeImage(imgUrl, context),
                        // Add onTap functionality
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Image.network(
                            imgUrl,
                            errorBuilder: (context, error, stackTrace) =>
                                SizedBox(),
                          ),
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
