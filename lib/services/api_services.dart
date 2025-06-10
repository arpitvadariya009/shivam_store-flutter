import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';

class ApiService extends GetxService {
  late Dio _dio;

  static ApiService get instance => Get.find<ApiService>();

  @override
  void onInit() {
    super.onInit();
    _initializeDio();
  }

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for logging and error handling
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => log(obj.toString()),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token if needed
          // options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        },
        onError: (error, handler) {
          log('API Error: ${error.message}');
          handler.next(error);
        },
      ),
    );
  }

  // Generic GET request
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? parser,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final data =
            parser != null ? parser(response.data) : response.data as T;
        return ApiResponse<T>().success(data);
      } else {
        return ApiResponse<T>().failure(
          'Request failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      return ApiResponse<T>().failure(_handleDioError(e));
    } catch (e) {
      return ApiResponse<T>().failure('Unexpected error: $e');
    }
  }

  // Generic POST request
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? parser,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData =
            parser != null ? parser(response.data) : response.data as T;
        return ApiResponse<T>().success(responseData);
      } else {
        return ApiResponse<T>().failure(
          'Request failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      return ApiResponse<T>().failure(_handleDioError(e));
    } catch (e) {
      return ApiResponse<T>().failure('Unexpected error: $e');
    }
  }

  // Generic PUT request
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? parser,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final responseData =
            parser != null ? parser(response.data) : response.data as T;
        return ApiResponse<T>().success(responseData);
      } else {
        return ApiResponse<T>().failure(
          'Request failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      return ApiResponse<T>().failure(_handleDioError(e));
    } catch (e) {
      return ApiResponse<T>().failure('Unexpected error: $e');
    }
  }

  // Generic DELETE request
  Future<ApiResponse<bool>> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return ApiResponse<bool>().success(true);
      } else {
        return ApiResponse<bool>().failure(
          'Request failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      return ApiResponse<bool>().failure(_handleDioError(e));
    } catch (e) {
      return ApiResponse<bool>().failure('Unexpected error: $e');
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        return 'Server error: ${error.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return 'Something went wrong';
    }
  }
}
