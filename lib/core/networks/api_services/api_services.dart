import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tayaar/core/networks/api_constants.dart';

class ApiServices {
  final Dio _dio;
  ApiServices(this._dio);

  Future<Map<String, dynamic>> get({
    required String endPoint,
    String? jwt,
    dynamic data,
  }) async {
   _dio.interceptors.add(PrettyDioLogger());
    _dio.options.headers = {
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };
    var response =
        await _dio.get("${ApiConstants.baseUrl}$endPoint", data: data);
    return response.data;
  }

  Future<List<dynamic>> getList({
    required String endPoint,
    String? jwt,
  }) async {
    _dio.interceptors.add(PrettyDioLogger());
    _dio.options.headers = {
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };
    var response = await _dio.get("${ApiConstants.baseUrl}$endPoint");
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required dynamic data,
    String? jwt,
  }) async {
    _dio.interceptors.add(PrettyDioLogger());
    _dio.options.headers = {
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };
    var response =
        await _dio.post("${ApiConstants.baseUrl}$endPoint", data: data);
    return response.data;
  }

  Future<Response> stripePost({
    required String url,
    required body,
    required String token,
    String? contentType,
  }) async {
    _dio.interceptors.add(PrettyDioLogger());
    var response = await _dio.post(
      url,
      data: body,
      options: Options(contentType: contentType, headers: {
        "Authorization": "Bearer $token",
      }),
    );
    return response;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    dynamic data,
    String? jwt,
  }) async {
    _dio.interceptors.add(PrettyDioLogger());
    _dio.options.headers = {
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };
    var response =
        await _dio.put("${ApiConstants.baseUrl}$endPoint", data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    String? jwt,
  }) async {
    _dio.interceptors.add(PrettyDioLogger());
    _dio.options.headers = {
      "Authorization": "Bearer $jwt",
      "Content-Type": "application/json",
    };
    var response = await _dio.delete("${ApiConstants.baseUrl}$endPoint");
    return response.data;
  }
}
