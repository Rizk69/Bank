import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../Core/widgets/Styles.dart';
import '../../on_bording_screen/Widget/buttom_.dart';
import '../Controller/QrController.dart';

class QRCodeScannerView extends StatelessWidget {
  final QRCodeScannerController controller = Get.put(QRCodeScannerController());

  QRCodeScannerView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Text('Pay with QR code',
              style: Styles.textStyleTitle24, textAlign: TextAlign.center),
          Text(
            'You can pay by scanning the QR ',
            style: Styles.textStyleTitle16
                .copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Expanded(
            flex: 4,
            child: QRView(
              key: controller.qrKey,
              onQRViewCreated: (QRViewController qrViewController) {
                controller.controller = qrViewController;
                controller.getQRScanClient(controller.scannedData.value);
              },
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
            child: Buttoms(
              color: Colors.black,
              colorText: Colors.white,
              text: 'Select from Gallery ',
              onPressed: () async {
                await controller.pickImageFromGallery();
              },
            ),
          ),
        ],
      ),
    );
  }
}
