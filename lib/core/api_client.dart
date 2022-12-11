// Dart imports:
import 'dart:convert';

import 'package:dio/dio.dart';
// Flutter imports:
import 'package:injectable/injectable.dart';
import 'package:udhar_app/utils/logger.dart';

@injectable
class APIClient {
  APIClient() {
    _initialize();
  }

  final Dio _dio = Dio();

  Dio _initialize() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          options.baseUrl = 'url';
          options.followRedirects = true;
          options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
          // options.headers['Auth-Token'] =
          //     getIt<AppPrefs>().authToken.getValue();
          // options.headers['Locale'] = getIt<AppPrefs>().locale.getValue();
          // options.headers['Version'] = getIt<PackageInfo>().version;
          logger.i(
              "API CLIENT : ${options.headers} ${jsonEncode(options.data)} & ${options.uri}");
          return handler.next(options);
        },
        onResponse:
            (Response response, ResponseInterceptorHandler handler) async {
          return handler.next(response);
        },
        onError: (DioError dioError, ErrorInterceptorHandler handler) async {
          logger.wtf(
              "Error : ${dioError.response!.statusCode} ${dioError.error} ${dioError.response!.data}");

          if (jsonDecode(dioError.response!.data)['msg'] != null) {
            // showToast("${jsonDecode(dioError.response!.data)['msg']}");
          }

          return handler.next(dioError);
        },
      ),
    );

    // if (BuildConfig.enableChuck && !kIsWeb) {
    //   _dio.interceptors.add(ChuckerDioInterceptor());
    // }

    return _dio;
  }

  /// GET
  Future<Response> get(String path,
      {Map<String, dynamic>? query, String? subPath}) {
    String reqPath = path;
    if (subPath != null) reqPath = path + subPath;
    return _dio.get(reqPath, queryParameters: query);
  }

  /// POST
  Future<Response> post(String path,
      {dynamic data, Map<String, dynamic>? query, String? subPath}) {
    String reqPath = path;
    if (subPath != null) reqPath = path + subPath;
    return _dio.post(reqPath, data: data, queryParameters: query);
  }

  /// PUT
  Future<Response> put(String path,
      {dynamic data, Map<String, dynamic>? query, String? subPath}) {
    String reqPath = path;
    if (subPath != null) reqPath = path + subPath;
    return _dio.put(reqPath, data: data, queryParameters: query);
  }

  /// DELETE
  Future<Response> delete(String path,
      {dynamic data, Map<String, dynamic>? query, String? subPath}) {
    String reqPath = path;
    if (subPath != null) reqPath = path + subPath;
    return _dio.delete(reqPath, data: data, queryParameters: query);
  }
}
