import 'package:dio/dio.dart';

import '../error/error_helper.dart';

abstract class ApiService {
  static String apiUrl = 'https://invastro.dev4.wady.sa/api/v1/customer';

  // static final ApiService _singleton = ApiService._();
  // static const String apiUrl = '$url/api/v1/customer';
  // static const String url = 'https://$domain';
  // static const String domain = 'ghiar-tech.dev4.wady.sa';
  static final baseOptions = BaseOptions(
    baseUrl: apiUrl,
    headers: {'Accept': 'application/json'},
  );

  static final Dio dio = Dio(baseOptions);

  // static ApiService get instance => _singleton;
  // ApiService._();
  static void setToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
    // final existingHeaders = {...dio.options.headers};
    // existingHeaders['Authorization'] = 'Bearer $token';
    // dio.options = dio.options.copyWith(headers:existingHeaders);
  }

  static void setLanguage(String lang) {
    dio.options.headers['language'] = lang;
    // final existingHeaders = {...dio.options.headers};
    // existingHeaders['lang'] = lang;
    // dio.options = dio.options.copyWith(headers: existingHeaders);
  }

  static void removeToken() {
    final existingHeaders = {...dio.options.headers};
    existingHeaders.remove('Authorization');
    dio.options = dio.options.copyWith(headers: existingHeaders);
  }

  static Future post(
    String endPoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    rethrowError = false,
    Map<String, dynamic>? headers,
    bool useDefaultUrl = false,
    bool useCache = false,
    hasMultipartData = false,
    Function(int, int)? onSendProgress,
  }) async {
    try {
      Map<String, dynamic> myHeaders = {...dio.options.headers};
      if (hasMultipartData) {
        headers = headers ?? {};
        headers['Content-Type'] = 'multipart/form-data';
      }

      if (headers != null) {
        headers.forEach((key, value) {
          myHeaders[key] = value;
        });
      }
      FormData? formData;
      if (hasMultipartData) {
        formData = FormData.fromMap(data!);
        List<MapEntry<String, MultipartFile>> newFiles = [];
        for (int i = 0; i < formData.files.length; i++) {
          final file = formData.files[i];
          if (file.key.contains('[photos[]]')) {
            final newFileKey = file.key.replaceFirst(
              '[photos[]]',
              '[photos][]',
            );
            newFiles.add(MapEntry(newFileKey, file.value));
          }
        }
        formData.files.removeWhere((e) => e.key.contains('[photos[]]'));
        formData.files.addAll(newFiles);
      }
      final response = await dio.post(
        useDefaultUrl
            ? 'https://invastro.dev4.wady.sa/api/v1$endPoint'
            : endPoint,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        options: Options(
          headers: myHeaders,
          // extra: cacheOptions
          //     .copyWith(
          //         policy: useCache
          //             ? CachePolicy.refreshForceCache
          //             : CachePolicy.noCache)
          //     .toExtra()
        ),
        data: hasMultipartData ? formData : data,
      );
      return response.data;
    } catch (e) {
      if (rethrowError) {
        rethrow;
      } else {
        ErrorHelper.handleApiError(e);
      }
    }
  }

  static Future get(
    String endPoint, {
    rethrowError = false,
    bool useCache = false,
    bool useDefaultUrl = false,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? customUrl,
  }) async {
    try {
      Map<String, dynamic> myHeaders = {...dio.options.headers};
      if (headers != null) {
        headers.forEach((key, value) {
          myHeaders[key] = value;
        });
      }
      final response = await dio.get(
        useDefaultUrl
            ? '${customUrl ?? 'https://invastro.dev4.wady.sa/api/v1'}$endPoint'
            : endPoint,
        queryParameters: queryParameters,
        options: Options(
          headers: myHeaders,
          // extra: cacheOptions
          //     .copyWith(
          //         policy: useCache
          //             ? CachePolicy.refreshForceCache
          //             : CachePolicy.noCache)
          //     .toExtra()
        ),
      );
      return response.data;
    } catch (e) {
      if (rethrowError) {
        rethrow;
      } else {
        ErrorHelper.handleApiError(e);
      }
    }
  }

  static Future delete(
    String endPoint, {
    rethrowError = false,
    bool useCache = false,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Map<String, dynamic> myHeaders = {...dio.options.headers};
      if (headers != null) {
        headers.forEach((key, value) {
          myHeaders[key] = value;
        });
      }
      final response = await ApiService.dio.delete(
        endPoint,
        queryParameters: queryParameters,
        options: Options(
          headers: myHeaders,
          // extra: cacheOptions
          //     .copyWith(
          //         policy: useCache
          //             ? CachePolicy.refreshForceCache
          //             : CachePolicy.noCache)
          //     .toExtra()
        ),
      );

      return response.data;
    } catch (e) {
      if (rethrowError) {
        rethrow;
      } else {
        ErrorHelper.handleApiError(e);
      }
    }
  }
}
