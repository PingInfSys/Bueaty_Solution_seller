import 'package:beauty_solution_seller_app/services/api/end_points.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/app_logs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkService {
  static final NetworkService _singleton = NetworkService._internal();

  factory NetworkService() {
    return _singleton;
  }

  Dio get dio {
    Dio dio = Dio();
    dio.options.baseUrl = EndPoints.baseUrl;
    //dio.options.connectTimeout = const Duration(seconds: 7); //5s
    //dio.options.receiveTimeout = const Duration(seconds: 7);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          //debugPrint("User token : ****   $token");
          Map<String, String>? headers;

          headers = {
            'Content-Type': 'application/json',
            "accept": "application/json",
          };

          options.headers = headers;

          if (kDebugMode) {
            AppLogs.infoLog(options.baseUrl, "baseUrl From");
            AppLogs.infoLog(options.path, "endPoint");
            AppLogs.infoLog(options.headers.toString(), "Headers");
            AppLogs.infoLog(options.data.toString(), "data");
            AppLogs.infoLog(options.queryParameters.toString(), "queryParameters");
          }

          return handler.next(options); //continue
        },
        onResponse: (Response response, handler) async {
          if (kDebugMode) {
            AppLogs.successLog("${response.data}", "Response From");
          }
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) async {
          if (kDebugMode) {
            AppLogs.errorLog(e.response.toString(), "dio error response");
            AppLogs.errorLog(e.error.toString(), "dio error");
            AppLogs.errorLog(e.type.toString(), "e.type");
            AppLogs.errorLog(e.requestOptions.path, "e.requestOptions.path");
            AppLogs.errorLog(e.message ?? '', "dio error message");
          }
          return handler.next(e);
        },
      ),
    );
    return dio;
  }

  NetworkService._internal();
}
