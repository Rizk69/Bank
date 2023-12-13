import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Core/http_helper.dart';
import '../../Money_Transfer/Screen/ScreenAmountSend.dart';
import '../model/ScanModel.dart';

class QRCodeScannerController extends GetxController {
  QRViewController? _controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final RxString scannedData = ''.obs;
  RxString selectedImagePath = ''.obs;
  bool canScan = true;

  QRViewController? get controller => _controller;

  bool canCallApi = true;

  set controller(QRViewController? value) {
    scannedData.value = 'empty';
    _controller = value;
    _controller?.scannedDataStream.listen((scanData) {
      if (canScan) {
        if (canCallApi) {
          print('Scanned data: ${scanData.code}');
          scannedData.value = scanData.code!;

          // Check if the scanned data is not empty and meets your conditions
          if (scannedData.value.isNotEmpty) {
            // You can add more conditions here if needed
            getQRScanClient(scannedData.value);
          }

          // Set a cooldown period (e.g., 5 seconds) before allowing the next API call
          canCallApi = false;
          Future.delayed(Duration(seconds: 5), () {
            canCallApi = true;
          });
        }
      }
    });
  }

  Future<void> getQRScanClientFromImage() async {
    try {
      // Implement your logic to process the image selected from the gallery
      // For example, you can use a package like Firebase ML Kit for image processing
      // After processing, update scannedData and call getQRScanClient
      scannedData.value = 'processed_data_from_image';
      getQRScanClient(scannedData.value);
    } catch (error) {
      print(error);
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      getQRScanClientFromImage();
    }
  }

  @override
  void onClose() {
    _controller?.dispose();
    super.onClose();
  }

  Future<void> getQRScanClient(String url) async {
    try {
      final response = await HttpHelper.getDataUrl(
        endpoint: url,
      );

      ApiResponseCheckScan apiResponse =
          ApiResponseCheckScan.fromJson(response);

      if (response['status'] == true) {
        print(apiResponse.toString());
        Get.snackbar("Success!", response['message'],
            backgroundColor: Colors.blue);
        Get.to(() => AmountSendScreen(model: apiResponse));
        onClose();
        // Set canScan to false to stop further scanning
        canScan = false;
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
    }
  }
}
