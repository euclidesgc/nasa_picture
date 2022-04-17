import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../home/core/errors/exceptions.dart';
import '../../home/core/errors/failures.dart';
import 'i_http_client.dart';

class DioHttpClient implements IHttpClient {
  // https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY
  final _dio = Dio();

  DioHttpClient({List<Interceptor> interceptors = const []}) {
    _dio.options = BaseOptions(
      connectTimeout: 5000, receiveTimeout: 100000,
      // If you have default headers, put here!
      headers: {
        'content-type': 'application/json',
      },
    );

    initInterceptors();
  }

  void initInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          if (kDebugMode) {
            developer.log(
              "⚪️ Method .: ${requestOptions.method}\n"
              "⚪️ URL........: ${requestOptions.uri.toString()}\n"
              "⚪️ Parameters.: ${requestOptions.queryParameters}\n"
              "⚪️ Data.......: ${requestOptions.data.toString()}\n"
              "⚪️ Headers....: ${requestOptions.headers.toString()}",
              name: 'REQUEST',
            );
          }
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            developer.log(
              "🟢 StatusCode.: ${response.statusCode}\n"
              "🟢 Message....: ${response.statusMessage}\n"
              "🟢 URL........: ${response.requestOptions.uri.toString()}\n"
              "🟢 Parameters.: ${response.requestOptions.queryParameters}\n"
              "🟢 Data.......: ${response.data.toString()}\n"
              "🟢 Headers....: ${response.headers.toString()}",
              name: 'RESPONSE',
            );
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode) {
            developer.log(
              "🔴 StatusCode.: ${error.response?.statusCode}\n"
              "🔴 Message....: ${error.response?.statusMessage}\n"
              "🔴 URL........: ${error.requestOptions.uri.toString()}\n",
              name: 'RESPONSE',
            );
          }
          return handler.next(error);
        },
      ),
    );
  }

  @override
  Future<dynamic> request(
      {required Method method,
      required String path,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? customHeaders}) async {
    Options? options = Options();

    if (customHeaders != null) {
      options.headers = _dio.options.headers;
      options.headers!.addAll(customHeaders);
    }

    try {
      switch (method) {
        case Method.GET:
          return await _dio.get(path, queryParameters: queryParameters, options: options);
        case Method.POST:
          return await _dio.post(path, data: data, queryParameters: queryParameters, options: options);
        case Method.PUT:
          return await _dio.put(path, data: data, queryParameters: queryParameters, options: options);
        case Method.DELETE:
          return await _dio.delete(path, data: data, queryParameters: queryParameters, options: options);
      }
    } on DioError catch (e, stacktrace) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.type == DioErrorType.connectTimeout) {
        developer.log("Timeout!", stackTrace: stacktrace);
        throw ServerException();
      }
      if (e.type == DioErrorType.response) {
        developer.log("🟠 Response.code out of range 2xx : ${e.response!.statusCode}",
            error: e, stackTrace: stacktrace, name: 'dio_http_client.dart');

        if (e.response!.statusCode == 400) {
          throw InvalidDate();
        }

        return e.response;
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        developer.log("Erro não expecificado!", name: 'dio_http_client.dart', error: e, stackTrace: stackTrace);
      }
      throw ServerException();
    }
  }
}
