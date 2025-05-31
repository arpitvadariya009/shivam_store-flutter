// // lib/core/network/api_service.dart

// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:get/get.dart' as g;

// class ApiService {
//   static final Dio dio = Dio(
//     BaseOptions(
//       headers: {
//         'Authorization': '4ccda7514adc0f13595a585205fb9761',
//         'Cookie': 'ci_session=vrf4vpcas8oodhksmf6dpm42q27oantj',
//         'Content-Type': 'application/json', // will override for multipart
//       },
//       connectTimeout: const Duration(seconds: 15),
//       receiveTimeout: const Duration(seconds: 15),
//     ),
//   );

//   static Future<dynamic> api({
//     required String uri,
//     required String method,
//     Map<String, dynamic>? data,
//     File? imageFile,
//     String imageFieldName = 'image',
//   }) async {
//     try {
//       Response response;

//       if (imageFile != null) {
//         // Prepare multipart form data
//         String fileName = imageFile.path.split('/').last;
//         FormData formData = FormData.fromMap({
//           ...?data,
//           imageFieldName: await MultipartFile.fromFile(
//             imageFile.path,
//             filename: fileName,
//           ),
//         });

//         response = await dio.request(
//           uri,
//           data: formData,
//           options: Options(
//             method: method,
//             headers: {
//               'Content-Type': 'multipart/form-data',
//               'Authorization': dio.options.headers['Authorization'],
//               'Cookie': dio.options.headers['Cookie'],
//             },
//           ),
//         );
//       } else {
//         response = await dio.request(
//           uri,
//           data: data,
//           options: Options(method: method),
//         );
//       }

//       return response.data;
//     } on DioException catch (e) {
//       g.Get.snackbar('error', 'Somthing Went Wrong');

//       throw Exception('Dio error (${e.response?.statusCode}): ${e.message}');
//     } catch (e) {
//       throw Exception('Unhandled error: $e');
//     }
//   }
// }
