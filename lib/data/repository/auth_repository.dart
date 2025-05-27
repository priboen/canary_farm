import 'dart:convert';
import 'dart:developer';

import 'package:canary_farm/data/models/request/auth/login_request_model.dart';
import 'package:canary_farm/data/models/response/auth_response_model.dart';
import 'package:canary_farm/services/service_http_client.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._serviceHttpClient);

  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.post(
        "login",
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final loginResponse = AuthResponseModel.fromMap(jsonResponse);
        await secureStorage.write(
          key: "authToken",
          value: loginResponse.user!.token,
        );
        log("Login successful: ${loginResponse.message}");
        return Right(loginResponse);
      } else {
        log("Login failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? "Login failed");
      }
    } catch (e) {
      log("Error in login: $e");
      return Left("An error occurred while logging in.");
    }
  }
}
