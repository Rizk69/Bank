import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Core/widgets/Styles.dart';
import '../../on_bording_screen/Widget/buttom_.dart';
import '../Controller/CardSelectionController.dart';
import '../model/CardData.dart';

class DetailsCardScreen extends StatelessWidget {
  final CardController controller = Get.find<CardController>();

  final CardItem selectedCard;
  int index;

  DetailsCardScreen({Key? key, required this.selectedCard, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                SizedBox()
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Image.network(
              selectedCard.imgs["${index + 1}"] ?? 'default_image_url_here',
              fit: BoxFit.contain,
              height: 150.h,
            ),
            SizedBox(
              height: 40.h,
            ),
            Wrap(
              spacing: 30,
              runSpacing: 15,
              children: selectedCard.colors
                  .map((colorItem) =>
                      colorButton(colorItem.name, colorItem.color))
                  .toList(),
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              'Use it completely free , get instant cash on certain\nbrands, Moreover, You can design your own card.',
              style: Styles.textStyleTitle14.copyWith(
                  fontWeight: FontWeight.w400, color: Color(0Xff6A6969)),
            ),
            const Spacer(),
            SizedBox(
                width: double.infinity,
                child: Buttoms(
                  color: Colors.white,
                  colorText: Colors.black,
                  text: ' Add a MBAG Card ',
                  onPressed: () {},
                )),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
                width: double.infinity,
                child: Buttoms(
                  color: Colors.black,
                  colorText: Colors.white,
                  text:
                      '${selectedCard.request == 0 ? 'Buy' : 'Request'} / Add a MBAG card ',
                  onPressed: () {},
                ))
          ],
        ),
      ),
    );
  }

  Widget colorButton(String colorName, String color) {
    return Obx(() {
      String colorValue = '0xFF${color.substring(1)}';
      bool isSelected = controller.selectedCardColors.contains(colorName);

      return ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: FilterChip(
          selectedShadowColor: Colors.orangeAccent,
          side: const BorderSide(color: Colors.grey),
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
