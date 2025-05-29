// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BuyerProfileRequestModel {
  final String? name;
  final String? address;
  final String? phone;
  final String? photo;

  BuyerProfileRequestModel({
    required this.name,
    required this.address,
    required this.phone,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'phone': phone,
      'photo': photo,
    };
  }

  factory BuyerProfileRequestModel.fromMap(Map<String, dynamic> map) {
    return BuyerProfileRequestModel(
      name: map['name'] != null ? map['name'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyerProfileRequestModel.fromJson(String source) =>
      BuyerProfileRequestModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
