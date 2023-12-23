import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../on_bording_screen/Widget/buttom_.dart';
import '../Controller/ReceiveQrPaymentController.dart';

class ReceiveQrPaymentScreen extends StatelessWidget {
  final ReceiveQrPaymentController controller =
      Get.put(ReceiveQrPaymentController());

  ReceiveQrPaymentScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30.h),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 35,
                  color: Colors.black,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            SizedBox(height: 50.h),
            Text('Receive payment with',
                style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
            Text('QR',
                style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
            Text(
              'You can get payment by showing this QR or creating new QR by entering the amount',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            GetBuilder<ReceiveQrPaymentController>(
              initState: (_) => controller.generateQrCode,
              builder: (controller) =>
              controller.isLoading.value == false
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 250.h,
                        width: 250.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white),
                      ),
                    )
                  : Center(
                      child: RepaintBoundary(
                        key: controller.qrKey,
                        child: SizedBox(
                          height: 250.h,
                          width: 250.h,
                          child: PrettyQrView(
                            qrImage: controller.qrImage,
                            decoration: const PrettyQrDecoration(
                              shape: PrettyQrSmoothSymbol(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            Spacer(),
            Buttoms(
              text: 'Share QR',
              onPressed: () async {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  await controller.shareQRCode();
                });
              },
              color: Colors.white,
              colorText: Colors.black,
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Text(
                  'Create QR by entering amount',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}
