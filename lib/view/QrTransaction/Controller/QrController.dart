import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerController extends GetxController {
  QRViewController? _controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR'); // Add GlobalKey here

  QRViewController? get controller => _controller;

  set controller(QRViewController? value) {
    _controller = value;
    _controller?.scannedDataStream.listen((scanData) {
      print('Scanned data: ${scanData.code}');
      // Handle the scanned data as desired
    });
  }

  @override
  void onClose() {
    _controller?.dispose();
    super.onClose();
  }
}
