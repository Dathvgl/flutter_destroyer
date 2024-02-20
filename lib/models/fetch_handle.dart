import 'dart:developer' as developer;
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class FetchHandle {
  final _dio = Dio(BaseOptions(
    baseUrl: "https://nodejs-crawl-puppeteer.onrender.com",
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  FetchHandle._();

  static FetchHandle? _instance;
  factory FetchHandle() => _instance ??= FetchHandle._();

  Future<void> cookie() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      PersistCookieJar cookieJar = PersistCookieJar(
        storage: FileStorage("$appDocPath/.cookies/"),
      );

      _dio.interceptors.add(CookieManager(cookieJar));
    } catch (e) {
      developer.log(e.toString(), name: "Lỗi cookie");
    }
  }

  Future<Response<T>?> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      developer.log(e.toString(), name: "Lỗi Fetch GET");
    }

    return null;
  }

  Future<Response<T>?> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      developer.log(e.toString(), name: "Lỗi Fetch POST");
    }

    return null;
  }

  Future<Response<T>?> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      developer.log(e.toString(), name: "Lỗi Fetch PUT");
    }

    return null;
  }

  Future<Response<T>?> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      developer.log(e.toString(), name: "Lỗi Fetch GET");
    }

    return null;
  }
}
