import 'package:bank/view/on_bording_screen/Widget/buttom_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../../Core/widgets/Styles.dart';

class ReceiveQrPaymentScreen extends StatefulWidget {
  final String idNumber;

  const ReceiveQrPaymentScreen({super.key, required this.idNumber});

  @override
  State<ReceiveQrPaymentScreen> createState() => _ReceiveQrPaymentScreenState();
}

class _ReceiveQrPaymentScreenState extends State<ReceiveQrPaymentScreen> {
  late QrImage qrImage;

  @override
  void initState() {
    super.initState();
    final qrCode = QrCode(
      8,
      QrErrorCorrectLevel.H,
    )..addData(widget.idNumber);

    qrImage = QrImage(qrCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30.h,
            ),
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
                  }),
            ),
            SizedBox(
              height: 50.h,
            ),
            Text('Receive payment with',
                style: Styles.textStyleTitle24, textAlign: TextAlign.center),
            Text('QR',
                style: Styles.textStyleTitle24, textAlign: TextAlign.center),
            Text(
                'You can get payment by showing this QR or creating new QR by entering the amount',
                style: Styles.textStyleTitle16
                    .copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: SizedBox(
                height: 250.h,
                width: 250.h,
                child: PrettyQrView(
                  qrImage: qrImage,
                  decoration: const PrettyQrDecoration(
                    shape: PrettyQrSmoothSymbol(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Buttoms(
                color: Colors.white,
                colorText: Colors.black,
                text: 'Share QR',
                onPressed: () {}),
            SizedBox(height: 10.h),
            Buttoms(
                color: Colors.black,
                colorText: Colors.white,
                text: 'Create QR by entering amount',
                onPressed: () {}),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}
