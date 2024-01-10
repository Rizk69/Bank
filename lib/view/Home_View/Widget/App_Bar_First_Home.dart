import 'package:MBAG/Core/widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/Dark/SettingsController.dart';
import '../../AccountDetails/Screen/AcountDetailsScreen.dart';

class AppBarFirstHome extends StatelessWidget {
  final void Function(
    BuildContext,
  ) showBottomSheetDrawer;

  AppBarFirstHome({Key? key, required this.showBottomSheetDrawer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                showBottomSheetDrawer(context);
              },
              icon: ImageIcon(
                AssetImage('Assets/images/Group.png'),
                size: 30,
                color: settingsController.isDarkMode.value
                    ? Colors.white
                    : Colors.black,
              )),
          ImageIcon(
            const AssetImage('Assets/images/M black.png'),
            color: settingsController.isDarkMode.value
                ? Colors.orangeAccent
                : Colors.black,
            size: 50,
          ),
          // Image.asset('Assets/images/Logo Mbag without background 5.png',height: 120.h,),
          InkWell(
            onTap: () {
              Get.to(() => AccountDetailsScreen());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 43,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const ImageIcon(
                            AssetImage(
                              'Assets/images/line-md_account.png',
                            ),
                            size: 30,
                            color: Colors.white),
                      ),
                      Positioned(
                        left: 25,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Icon(Icons.camera_alt_outlined,
                              color: Colors.white, size: 9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'My Account'.tr,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
