import 'dart:convert';

import 'package:canary_farm/data/models/request/buyer/buyer_profile_request_model.dart';
import 'package:canary_farm/data/models/response/buyer/buyer_profile_response_model.dart';
import 'package:canary_farm/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class ProfileBuyerRepository {
  final ServiceHttpClient _serviceHttpClient;
  ProfileBuyerRepository(this._serviceHttpClient);

  Future<Either<String, BuyerProfileResponseModel>> addProfileBuyer(
    BuyerProfileRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWihToken(
        "buyer/profile",
        requestModel.toJson(),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = BuyerProfileResponseModel.fromJson(
          jsonResponse,
        );
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while adding profile: $e");
    }
  }

  Future<Either<String, BuyerProfileResponseModel>> getProfileBuyer() async {
    try {
      final response = await _serviceHttpClient.get("buyer/profile");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = BuyerProfileResponseModel.fromJson(
          jsonResponse,
        );
        print("Profile Response: $profileResponse");
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while fetching profile: $e");
    }
  }
}
