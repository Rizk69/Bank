import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../../../Core/http_helper.dart';

class AccountTransActonDetailsController extends GetxController {
  Future<void> saveTransactionsDetailsToExternalStorage(
      {required var id, required BuildContext context}) async {
    print(id);
    var status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final response =
            await HttpHelper.saveData(endpoint: "get_trans_pdf/$id");
        if (response.statusCode == 200) {
          // print(response.bodyBytes);
          var bytes = response.bodyBytes;
          print(bytes);

          final directory = await getExternalStorageDirectory();
          await directory!.create(recursive: true);

          String fileName = 'transaction_$id.pdf';
          String filePath = '${directory.path}/$fileName';
          File file = File(filePath);

          await file.writeAsBytes(bytes);

          Get.snackbar(
            'Success',
            'File saved successfully to $filePath',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            onTap: (_) {
              showPdf(context, directory.path);
            },
          );
        } else {
          Get.snackbar(
            'Error',
            'Failed to download file: Server responded with status code ${response.statusCode}',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      } catch (error) {
        Get.snackbar(
          'Error',
          'An error occurred while fetching transaction details: $error',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } finally {
        update();
      }
    } else {
      Get.snackbar(
        'Permission Denied',
        'Storage permission is required to save the file.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void showPdf(BuildContext context, String filePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFView(
          filePath: filePath,
        ),
      ),
    );
  }
}
