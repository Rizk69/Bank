import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share/share.dart';
import '../../../Core/http_helper.dart';

class ReceiveQrPaymentController extends GetxController {
  late QrImage qrImage;
  final GlobalKey qrKey = GlobalKey();
  late String _qR;

  String get qr => _qR;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getQRClient();
    await generateQrCode(_qR);
    isLoading = true.obs;
  }

//
  Future<void> getQRClient() async {
    try {
      final response = await HttpHelper.getData(
        endpoint: 'get_qr_client',
      );
      if (response["status"] == true) {
        print(response.toString());
        _qR = response['QR'];
        generateQrCode(_qR);
        isLoading = true.obs;
      } else {
        Get.snackbar("Warning!", response['message'],
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
    } finally {}
  }

  Future<void> generateQrCode(String idNumber) async {
    final qrCode = QrCode(
      8,
      QrErrorCorrectLevel.H,
    )..addData(idNumber);

    qrImage = QrImage(qrCode);
    updateQrCode(idNumber);
  }

  Future<Uint8List> getQrImageBytes() async {
    final boundary =
        qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);

    ByteData? byteData;

    try {
      byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    } catch (e) {
      print('Error converting image to byte data: $e');
    }

    return byteData!.buffer.asUint8List();
  }

  Future<void> shareQRCode() async {
    final imageBytes = await getQrImageBytes();

    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/qr_code.png');

    await tempFile.writeAsBytes(imageBytes);

    await Share.shareFiles(
      [tempFile.path],
      text: 'Share QR Code',
      subject: 'QR Code',
      mimeTypes: ['image/png'], // Specify PNG format
    );
  }

  void updateQrCode(String newIdNumber) {
    final qrCode = QrCode(
      8,
      QrErrorCorrectLevel.H,
    )..addData(newIdNumber);

    qrImage = QrImage(qrCode);
    update();
  }
}
