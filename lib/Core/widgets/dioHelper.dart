//
// class DioHelper {
//   static Dio? dio;
//
//   static init() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: "https://wallet.acwad-it.com/api/",
//         receiveDataWhenStatusError: true,
//       ),
//     );
//   }
//
//   static Future<Response> postData({
//     required String url,
//     Map<String, dynamic>? query,
//     required Map<String, dynamic> body,
//   }) async {
//     try {
//       Response response = await dio!.post(
//         url,
//         queryParameters: query,
//         data: body,
//         options: Options(
//           headers: {
//             'Accept': 'application/json',
//             'Accept-Language': 'en',
//           },
//         ),
//       );
//       return response;
//     } catch (error) {
//       throw Exception('Failed to post data: $error');
//     }
//   }
// }
