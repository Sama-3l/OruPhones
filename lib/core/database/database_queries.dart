import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:oruphones/core/constants/api_constants.dart';

class BackendRepo {
  final String _domain = ApiConstants.baseUrl;
  final _dio = Dio();

  Future<Response> signInUser(String apiUrl) async {
    try {
      String url = _domain + apiUrl;
      Map<String, String> header = {
        'Content-Type': 'application/json'
      };
      Response response = await _dio.get(
        url,
        options: Options(headers: header),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callUserGetMethod(String apiUrl, String token) async {
    try {
      String url = _domain + apiUrl;
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };

      Response response = await _dio.get(
        url,
        options: Options(headers: header),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response?> callPostMethod(String apiUrl, Map<String, dynamic> body) async {
    try {
      String url = _domain + apiUrl;
      Map<String, String> header = {
        'Content-Type': 'application/json'
      };
      Response response = await _dio.post(
        url,
        data: jsonEncode(body),
        options: Options(headers: header),
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callGetMethod(String apiUrl, {String? cookie}) async {
    try {
      String url = _domain + apiUrl;
      Map<String, String> header = cookie == null
          ? {
              'Content-Type': 'application/json',
            }
          : {
              'Content-Type': 'application/json',
              'Cookie': cookie,
            };

      Response response = await _dio.get(
        url,
        options: Options(headers: header),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callUserPostMethod(String apiUrl, Map<String, dynamic> body, String token) async {
    try {
      String url = _domain + apiUrl;
      Map<String, String> header = {
        'Content-Type': 'application/json',
        "key": "X-Csrf-Token",
        "value": token,
        "type": "text",
      };

      Response response = await _dio.post(
        url,
        data: jsonEncode(body),
        options: Options(headers: header),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callUserPutMethod(String apiUrl, Map<String, dynamic> body, String token) async {
    try {
      String url = _domain + apiUrl;
      Map<String, String> header = {
        'Content-Type': 'application/json',
        "key": "X-Csrf-Token",
        "value": token,
        "type": "text",
      };

      Response response = await _dio.put(
        url,
        data: jsonEncode(body),
        options: Options(headers: header),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
