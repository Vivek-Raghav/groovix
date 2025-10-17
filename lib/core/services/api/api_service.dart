// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({required String baseUrl, String? token})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            if (token != null) 'Authorization': token,
          },
        )) {
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (kDebugMode) {
        print('headers: ${options.headers}');
        print('[API][REQUEST][URL] => ${options.method} ${options.uri}');
        print('[API][BODY] => ${options.data}');
      }
      handler.next(options);
    }, onResponse: (response, handler) {
      if (kDebugMode) {
        print('[API][RESPONSE] => ${response.statusCode} ${response.data}');
      }
      handler.next(response);
    }, onError: (DioException e, handler) {
      if (kDebugMode) {
        if (e.response != null) {
          print(
              '[API][ERROR][STATUS] => ${e.response?.statusCode} && [DATA] => ${e.response?.data}');
        } else {
          print('[API][ERROR] => ${e.message}');
        }
      }
      handler.next(e);
    }));
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> postMultipart<T>({
    required String url,
    required Map<String, File> files, // key = field name, value = File
    required Map<String, dynamic> fields, // key = field name, value = data
    Map<String, dynamic>? headers,
  }) async {
    print("headers: $headers");
    try {
      // Convert files into MultipartFile
      final fileMap = <String, MultipartFile>{};
      for (final entry in files.entries) {
        fileMap[entry.key] = await MultipartFile.fromFile(entry.value.path);
      }

      // Merge fields + files
      final formData = FormData.fromMap({
        ...fields,
        ...fileMap,
      });

      final response = await _dio.post<T>(
        url,
        data: formData,
        options: Options(contentType: "multipart/form-data", headers: headers),
      );

      return response;
    } on DioException catch (e) {
      throw Exception("Upload failed: ${e.message}");
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Exception('Connection Timeout');
      case DioExceptionType.badResponse:
        return Exception('Server Error: ${e.response?.statusCode}');
      case DioExceptionType.unknown:
        return Exception('Unexpected Error: ${e.message}');
      default:
        return Exception('Something went wrong');
    }
  }
}
