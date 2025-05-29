import 'dart:convert';

class GetAllAnakModel {
  final String message;
  final int statusCode;
  final List<GetAnak> data;

  GetAllAnakModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  GetAllAnakModel copyWith({
    String? message,
    int? statusCode,
    List<GetAnak>? data,
  }) => GetAllAnakModel(
    message: message ?? this.message,
    statusCode: statusCode ?? this.statusCode,
    data: data ?? this.data,
  );

  factory GetAllAnakModel.fromRawJson(String str) =>
      GetAllAnakModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllAnakModel.fromJson(Map<String, dynamic> json) =>
      GetAllAnakModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: List<GetAnak>.from(json["data"].map((x) => GetAnak.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetAnakById {
  final String message;
  final int statusCode;
  final GetAnak data;

  GetAnakById({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  GetAnakById copyWith({String? message, int? statusCode, GetAnak? data}) =>
      GetAnakById(
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
      );

  factory GetAnakById.fromRawJson(String str) =>
      GetAnakById.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAnakById.fromJson(Map<String, dynamic> json) => GetAnakById(
    message: json["message"],
    statusCode: json["status_code"],
    data: GetAnak.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status_code": statusCode,
    "data": data.toJson(),
  };
}

class GetAnak {
  final int id;
  final String noRing;
  final String gambarBurung;
  final DateTime tanggalLahir;
  final String jenisKelamin;
  final String jenisKenari;
  final String ayahNoRing;
  final String ibuNoRing;

  GetAnak({
    required this.id,
    required this.noRing,
    required this.gambarBurung,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.jenisKenari,
    required this.ayahNoRing,
    required this.ibuNoRing,
  });

  GetAnak copyWith({
    int? id,
    String? noRing,
    String? gambarBurung,
    DateTime? tanggalLahir,
    String? jenisKelamin,
    String? jenisKenari,
    String? ayahNoRing,
    String? ibuNoRing,
  }) => GetAnak(
    id: id ?? this.id,
    noRing: noRing ?? this.noRing,
    gambarBurung: gambarBurung ?? this.gambarBurung,
    tanggalLahir: tanggalLahir ?? this.tanggalLahir,
    jenisKelamin: jenisKelamin ?? this.jenisKelamin,
    jenisKenari: jenisKenari ?? this.jenisKenari,
    ayahNoRing: ayahNoRing ?? this.ayahNoRing,
    ibuNoRing: ibuNoRing ?? this.ibuNoRing,
  );

  factory GetAnak.fromRawJson(String str) => GetAnak.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAnak.fromJson(Map<String, dynamic> json) => GetAnak(
    id: json["id"],
    noRing: json["no_ring"],
    gambarBurung:
        json["gambar_burung"] ?? '', // default to empty string if null
    tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
    jenisKelamin: json["jenis_kelamin"],
    jenisKenari: json["jenis_kenari"],
    ayahNoRing: json["ayah_no_ring"] ?? '', // default to empty string if null
    ibuNoRing: json["ibu_no_ring"] ?? '', // default to empty string if null
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "no_ring": noRing,
    "gambar_burung": gambarBurung,
    "tanggal_lahir":
        "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
    "jenis_kelamin": jenisKelamin,
    "jenis_kenari": jenisKenari,
    "ayah_no_ring": ayahNoRing,
    "ibu_no_ring": ibuNoRing,
  };
}
