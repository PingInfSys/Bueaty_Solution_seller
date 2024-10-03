import 'package:beauty_solution_seller_app/resource/enums_manager.dart';
import 'package:beauty_solution_seller_app/services/api/api_response.dart';
import 'package:beauty_solution_seller_app/services/api/network_service.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/app_logs.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/extentions.dart';
import 'package:dio/dio.dart';

abstract class ApiRequest {
  Future<ApiResponseModel> getRequest(String path, {Object? body, Map<String, dynamic>? queryParameters});
  Future<ApiResponseModel> postRequest(String path, {Object? body, Map<String, dynamic>? queryParameters});
  Future<ApiResponseModel> putRequest(String path, {Object? body, Map<String, dynamic>? queryParameters});
  Future<ApiResponseModel> deleteRequest(String path, {Object? body, Map<String, dynamic>? queryParameters});
}

class DioConsumer implements ApiRequest {
  static final Dio _dio = NetworkService().dio;

  @override
  Future<ApiResponseModel> getRequest(String path, {Object? body, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (error) {
      return _handleError(error);
    }
  }

  @override
  Future<ApiResponseModel> postRequest(String path, {Object? body, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(path, queryParameters: queryParameters, data: body);
      return _handleResponse(response);
    } on DioException catch (error) {
      return _handleError(error);
    }
  }

  @override
  Future<ApiResponseModel> putRequest(String path, {Object? body, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.put(path, queryParameters: queryParameters, data: body);
      return _handleResponse(response);
    } on DioException catch (error) {
      return _handleError(error);
    }
  }

  @override
  Future<ApiResponseModel> deleteRequest(String path, {Object? body, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(path, queryParameters: queryParameters, data: body);
      return _handleResponse(response);
    } on DioException catch (error) {
      return _handleError(error);
    }
  }

  static ApiResponseModel _handleResponse(Response<dynamic> response) {
    final data = response.data;
    final message = data['message'];
    final stateCode = data['statusCode'];
    AppLogs.successLog(data.toString(), "Response from http");

    if (stateCode.toString().startsWith('2')) {
      return ApiResponseModel(status: ApiStatus.success, data: data, message: message, stateCode: stateCode);
    } else {
      return ApiResponseModel(status: ApiStatus.error, data: data, stateCode: stateCode, message: message);
    }
  }

  static ApiResponseModel _handleError(DioException error) {
    if (error.response != null) {
      final data = error.response?.data;
      final message = data['message'];
      final stateCode = error.response?.statusCode ?? 400;
      AppLogs.errorLog(data.toString());
      AppLogs.errorLog(stateCode.toString());
      AppLogs.errorLog(message.toString());
      return ApiResponseModel(status: ApiStatus.error, data: data, stateCode: stateCode, message: message);
    } else {
      AppLogs.errorLog('${error.toString().contains('SocketException') ? "check_network".tr() : error.error ?? 'Unknown Error'}');
      throw error.toString().contains('SocketException') ? 'Please check your network connection' : error.error ?? 'Unknown Error';
    }
  }
}
