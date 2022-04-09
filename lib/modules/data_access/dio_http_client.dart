import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'i_http_client.dart';

class DioHttpService implements IHttpClient {
  final String _nasaApiKey = dotenv.env['NASA_API_KEY']!;
  final String _baseUrl = dotenv.env['BASE_URL']!;

// https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY
  final _dio = Dio();

  DioHttpService({List<Interceptor> interceptors = const []}) {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl, connectTimeout: 5000, receiveTimeout: 100000,
      //Add default key to the queryParameters
      queryParameters: {'api_key': _nasaApiKey},
      // If you have default headers, put here!
      headers: {
        'content-type': 'application/json',
        'content-encoding': 'gzip',
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
              "🟠 Method .: ${requestOptions.method}\n"
              "🟠 URL........: ${requestOptions.uri.toString()}\n"
              "🟠 Parameters.: ${requestOptions.queryParameters}\n"
              "🟠 Data.......: ${requestOptions.data.toString()}\n"
              "🟠 Headers....: ${requestOptions.headers.toString()}",
              name: 'REQUEST',
            );
          }
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            developer.log(
              "🟠 StatusCode.: ${response.statusCode}\n"
              "🟠 Message....: ${response.statusMessage}\n"
              "🟠 URL........: ${response.requestOptions.uri.toString()}\n"
              "🟠 Parameters.: ${response.requestOptions.queryParameters}\n"
              "🟠 Data.......: ${response.requestOptions.data.toString()}\n"
              "🟠 Headers....: ${response.requestOptions.headers.toString()}",
              name: 'RESPONSE',
            );
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode) {
            developer.log(
              "🟠 StatusCode.: ${error.response?.statusCode}\n"
              "🟠 Message....: ${error.response?.statusMessage}\n"
              "🟠 URL........: ${error.requestOptions.uri.toString()}\n",
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
          final response = await _dio.get(path, queryParameters: queryParameters, options: options);
          return response;
        case Method.POST:
          final response = await _dio.post(path, data: data, queryParameters: queryParameters, options: options);
          return response;
        case Method.PUT:
          final response = await _dio.put(path, data: data, queryParameters: queryParameters, options: options);
          return response;
        case Method.DELETE:
          final response = await _dio.delete(path, data: data, queryParameters: queryParameters, options: options);
          return response;
      }
    } on DioError catch (e, stacktrace) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.type == DioErrorType.connectTimeout) {
        developer.log("Timeout!", stackTrace: stacktrace);
      }
      if (e.type == DioErrorType.response) {
        developer.log("🟠 Response.code out of range 2xx : ${e.response!.statusCode}",
            error: e, stackTrace: stacktrace, name: 'dio_http_client.dart');

        if (e.response!.statusCode == 400) {
          throw Exception(e.response!.data["error"]);
        }
        if (e.response!.statusCode == 401) {
          throw UnimplementedError();
        }
        if (e.response!.data["code"] == 101) {
          debugPrint("🟠 Login ou senha inválida");
          throw UnimplementedError();
        }
        return e.response;
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        developer.log("Erro não expecificado!", name: 'dio_http_client.dart', error: e, stackTrace: stackTrace);
      }
      throw Exception();
    }
  }
}
