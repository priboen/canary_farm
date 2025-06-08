import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServiceHttpClient {
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  final secureStorage = FlutterSecureStorage();

  Future<http.Response> post(String endPoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endPoint");

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      _logRequest("POST", url, body, response);
      return response;
    } catch (e) {
      throw Exception("POST request failed: $e");
    }
  }

  Future<http.Response> get(String endPoint) async {
    final token = await secureStorage.read(key: "authToken");
    final url = Uri.parse("$baseUrl$endPoint");
    try {
      final response = await http.get(
        url,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      _logRequest("GET", url, null, response);
      return response;
    } catch (e) {
      throw Exception("GET request failed: $e");
    }
  }

  Future<http.Response> postWihToken(
    String endPoint,
    Map<String, dynamic> body,
  ) async {
    final token = await secureStorage.read(key: "authToken");
    final url = Uri.parse("$baseUrl$endPoint");

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      _logRequest("POST", url, body, response);
      return response;
    } catch (e) {
      throw Exception("POST request failed: $e");
    }
  }

  void _logRequest(
    String method,
    Uri url,
    Map<String, dynamic>? body,
    http.Response response,
  ) {
    log("==== HTTP REQUEST ====");
    log("Method: $method");
    log("URL: $url");
    if (body != null) log("Body: ${jsonEncode(body)}");
    log("Status Code: ${response.statusCode}");
    log("Response Body: ${response.body}");
    log("======================");
  }
}
