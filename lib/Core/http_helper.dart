import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'cache_helper.dart';

class HttpHelper {
  static const String baseUrl = "https://wallet.acwad-it.com/api/";
  static String languageCode = 'en';

  static void updateLanguageHeader(String langCode) {
    languageCode = langCode;
  }

  static Future<Map<String, dynamic>> postData({
    required String endpoint,
    Map<String, dynamic>? query,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    final url = Uri.parse(baseUrl + endpoint);
    var token = CacheHelper.getDataSharedPreference(key: 'token');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Accept-Language': languageCode,
        },
        body: jsonEncode(body),
      );
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (error) {
      throw Exception('Failed to post data: $error');
    }
  }

  static Future<Map<String, dynamic>> postMultipart({
    required String endpoint,
    Map<String, dynamic>? fields,
    required List<File> files,
  }) async {
    var token = CacheHelper.getDataSharedPreference(key: 'token');
    final url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Accept'] = 'application/json'
        ..headers['Accept-Language'] = languageCode
        ..headers['Content-Type'] = 'application/json';

      // Add fields
      if (fields != null) {
        fields.forEach((key, value) {
          request.fields[key] = value.toString();
        });
      }

      // Add files
      for (var i = 0; i < files.length; i++) {
        var file = files[i];
        request.files.add(
          await http.MultipartFile.fromPath(
            'file_$i',
            // Use a dynamic field name, e.g., 'file_0', 'file_1', ...
            file.path,
            filename: 'file$i.jpg',
          ),
        );
      }

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to post data: $error');
    }
  }

  static Future<Map<String, dynamic>> getData({
    required String endpoint,
    Map<String, dynamic>? query,
  }) async {
    final url = Uri.parse(baseUrl + endpoint);
    var token = CacheHelper.getDataSharedPreference(key: 'token');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Accept-Language': languageCode,
          'User-Agent': 'PostmanRuntime/7.36.0',
          'Connection': 'keep-alive',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }

  static Future<http.Response> saveData({required String endpoint}) async {
    var url = Uri.parse('https://your-api-url.com/api/$endpoint');
    var headers = {
      'Authorization': 'Bearer YourTokenHere',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': languageCode,
      'User-Agent': 'PostmanRuntime/7.36.0',
      'Connection': 'keep-alive',
    };

    var response = await http.get(url, headers: headers);
    return response;
  }

  void downloadFile(String endpoint) async {
    final url = Uri.parse(baseUrl + endpoint);
    var token = CacheHelper.getDataSharedPreference(key: 'token');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': languageCode,
        'User-Agent': 'PostmanRuntime/7.36.0',
        'Connection': 'keep-alive',
      },
    );

    // If the call to the server was successful, parse the PDF file
    if (response.statusCode == 200) {
      Directory documentsDir = await getApplicationDocumentsDirectory();
      String filePath = '${documentsDir.path}/transaction.pdf';

      // Write the file
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      print('File downloaded to $filePath');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to download file');
    }
  }

  static Future<Map<String, dynamic>> getDataUrl({
    required String endpoint,
    Map<String, dynamic>? query,
  }) async {
    final url = Uri.parse(endpoint);
    var token = CacheHelper.getDataSharedPreference(key: 'token');
    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Language': languageCode,
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }

  // في HttpHelper
  static Future<Map<String, dynamic>> sendImagesToAPI({
    required File frontImage,
    required File backImage,
  }) async {
    if (frontImage == null || backImage == null) {
      throw Exception('Please capture both front and back images.');
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://wallet.acwad-it.com/api/add_id'),
      );

      request.files.add(
        await http.MultipartFile.fromPath('frout_id', frontImage.path),
      );
      request.files.add(
        await http.MultipartFile.fromPath('back_id', backImage.path),
      );

      var token = await CacheHelper.getDataSharedPreference(key: 'token');
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Accept-Language': 'en',
      });

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Images uploaded successfully');
        // يمكنك إرجاع أي بيانات ترغب فيها هنا
        return {};
      } else {
        throw Exception(
            'Error uploading images. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error sending images: $error');
    }
  }
}
