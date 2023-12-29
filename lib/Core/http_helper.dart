import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'cache_helper.dart';

class HttpHelper {
  static const String baseUrl = "https://wallet.acwad-it.com/api/";

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
          'Accept-Language': 'en',
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
        ..headers['Accept-Language'] = 'en'
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
          'Accept-Language': 'en',
          'User-Agent': 'PostmanRuntime/7.36.0',
          'Connection': 'keep-alive',
        },
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
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
          'Accept-Language': 'en',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }
}
