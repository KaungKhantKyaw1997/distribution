import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final storage = FlutterSecureStorage();

  final Dio _dio = Dio();

  // Define your base API URL
  static const String baseUrl = 'http://150.95.82.125:8005';

  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<Map<String, dynamic>?> get(String path,
      {Map<String, dynamic>? params}) async {
    try {
      var token = await storage.read(key: "token") ?? '';
      final response = await _dio.get(
        '$baseUrl/$path',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            if (token.isNotEmpty) 'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: params,
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to make GET request: $error');
    }
  }

  Future<Map<String, dynamic>?> post(String path,
      {Map<String, dynamic>? data}) async {
    try {
      var token = await storage.read(key: "token") ?? '';
      final response = await _dio.post(
        '$baseUrl/$path',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            if (token.isNotEmpty) 'Authorization': 'Bearer $token',
          },
        ),
        data: data,
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to make POST request: $error');
    }
  }

  Future<Map<String, dynamic>?> put(String path,
      {Map<String, dynamic>? data}) async {
    try {
      var token = await storage.read(key: "token") ?? '';
      final response = await _dio.put(
        '$baseUrl/$path',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            if (token.isNotEmpty) 'Authorization': 'Bearer $token',
          },
        ),
        data: data,
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to make PUT request: $error');
    }
  }

  Future<Map<String, dynamic>?> delete(String path,
      {Map<String, dynamic>? params}) async {
    try {
      var token = await storage.read(key: "token") ?? '';
      final response = await _dio.delete(
        '$baseUrl/$path',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            if (token.isNotEmpty) 'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: params,
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to make DELETE request: $error');
    }
  }
}
