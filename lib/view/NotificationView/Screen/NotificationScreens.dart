import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Core/widgets/Styles.dart';
import '../Controller/NotificationController.dart';

class NotificationScreenHome extends StatelessWidget {
  NotificationControllerGetData controllerGetData =
      Get.put(NotificationControllerGetData());

  NotificationScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    controllerGetData.getNotification();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    )),
                Text(
                  'Notification',
                  style: Styles.textStyleTitle24
                      .copyWith(fontSize: 23, fontStyle: FontStyle.normal),
                ),
                SizedBox(
                  width: 40,
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            GetBuilder<NotificationControllerGetData>(
              builder: (notificationController) {
                final notifications =
                    notificationController.notificationsModel.notifications;

                return notifications != null && notifications.isNotEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 0.9,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            var title = notifications[index].title;
                            var des = notifications[index].description;
                            var transId = notifications[index].transId ?? 0;
                            var type = notifications[index].type?.trim() ?? '';

                            return InkWell(
                              onTap: () {
                                if (type == 'transformation') {
                                  notificationController.getTransactionsDetails(
                                      id: transId);
                                }
                              },
                              child: notificationDetails(title, des),
                            );
                          },
                          itemCount: notifications.length,
                        ),
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: notificationDetails('', ''),
                      );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget notificationDetails(String? title, String? des) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      color: Color(0XFF979797).withOpacity(0.3),
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  des ?? '',
                  style: Styles.textStyleTitle14
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  title ?? '',
                  style: Styles.textStyleTitle14.copyWith(
                      fontWeight: FontWeight.w400, color: Color(0XFF727376)),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            color: Colors.black,
            height: 1,
          )
        ],
      ),
    );
  }
}
