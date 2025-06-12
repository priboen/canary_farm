import 'dart:convert';
import 'dart:developer';

import 'package:canary_farm/data/models/request/admin/posting_jual_request_model.dart';
import 'package:canary_farm/data/models/response/burung_semua_tersedia_model.dart';
import 'package:canary_farm/data/models/response/get_all_burung_response_model.dart';
import 'package:canary_farm/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class PostingRepostory {
  final ServiceHttpClient _serviceHttpClient;
  PostingRepostory(this._serviceHttpClient);

  Future<Either<String, BurungSemuaTersediabyIdModel>> addPostBurung(
    PostingJualRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWihToken(
        'admin/posting-jual',
        requestModel.toJson(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        final profileResponse = BurungSemuaTersediabyIdModel.fromJson(
          jsonResponse,
        );
        log("Add Burung  successful: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        log("Add burung failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? "Add burung failed");
      }
    } catch (e) {
      log("Error in Add burung : $e");
      return Left("An error occurred while post burung: $e");
    }
  }

  Future<Either<String, GetAllBurungModel>> getAllBurung() async {
    try {
      final response = await _serviceHttpClient.get("admin/burung-semua");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final getAllBurung = GetAllBurungModel.fromMap(jsonResponse);

        return Right(getAllBurung);
      } else {
        final jsonResponse = json.decode(response.body);

        return Left(jsonResponse['message'] ?? "Get All burung failed");
      }
    } catch (e) {
      return Left("An error occurred while getting all burung: $e");
    }
  }
}
