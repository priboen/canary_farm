import 'dart:convert';

class PostingJualRequestModel {
  final int burungId;
  final String burungType;
  final int harga;
  final String deskripsi;

  PostingJualRequestModel({
    required this.burungId,
    required this.burungType,
    required this.harga,
    required this.deskripsi,
  });

  PostingJualRequestModel copyWith({
    int? burungId,
    String? burungType,
    int? harga,
    String? deskripsi,
  }) => PostingJualRequestModel(
    burungId: burungId ?? this.burungId,
    burungType: burungType ?? this.burungType,
    harga: harga ?? this.harga,
    deskripsi: deskripsi ?? this.deskripsi,
  );

  factory PostingJualRequestModel.fromRawJson(String str) =>
      PostingJualRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostingJualRequestModel.fromJson(Map<String, dynamic> json) =>
      PostingJualRequestModel(
        burungId: json["burung_id"],
        burungType: json["burung_type"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
    "burung_id": burungId,
    "burung_type": burungType,
    "harga": harga,
    "deskripsi": deskripsi,
  };
}
