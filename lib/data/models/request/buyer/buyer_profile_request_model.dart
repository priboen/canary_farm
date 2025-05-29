// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BuyerProfileRequestModel {
  final String? name;
  final String? address;
  final String? phone;
  final String? photo;

  BuyerProfileRequestModel({this.name, this.address, this.phone, this.photo});

  BuyerProfileRequestModel copyWith({
    String? name,
    String? address,
    String? phone,
    String? photo,
  }) {
    return BuyerProfileRequestModel(
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
    );
  }

  factory BuyerProfileRequestModel.fromRawJson(String str) =>
      BuyerProfileRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
  factory BuyerProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      BuyerProfileRequestModel(
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        photo: json["photo"],
      );
  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "phone": phone,
    "photo": photo,
  };
}
