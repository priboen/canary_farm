import 'dart:convert';

import 'package:canary_farm/data/models/request/admin/posting_jual_request_model.dart';
import 'package:canary_farm/data/models/response/buyer/burung_semua_tersedia_model.dart';
import 'package:canary_farm/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class PostBurungRepository {
  final ServiceHttpClient _serviceHttpClient;

  PostBurungRepository(this._serviceHttpClient);

  Future<Either<String, DataBurungTersedia>> addInduk(
    PostingJualRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWihToken(
        "admin/anak",
        requestModel.toJson(),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = DataBurungTersedia.fromJson(jsonResponse);
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while adding profile: $e");
    }
  }
}
