import 'dart:convert';

class BurungSemuaTersediaModel {
  final String message;
  final int statusCode;
  final List<DataBurungTersedia> data;

  BurungSemuaTersediaModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  BurungSemuaTersediaModel copyWith({
    String? message,
    int? statusCode,
    List<DataBurungTersedia>? data,
  }) => BurungSemuaTersediaModel(
    message: message ?? this.message,
    statusCode: statusCode ?? this.statusCode,
    data: data ?? this.data,
  );

  factory BurungSemuaTersediaModel.fromRawJson(String str) =>
      BurungSemuaTersediaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BurungSemuaTersediaModel.fromJson(
    Map<String, dynamic> json,
  ) => BurungSemuaTersediaModel(
    message: json["message"],
    statusCode: json["status_code"],
    // data: List<DataBurungTersedia>.from(json["data"].map((x) => DataBurungTersedia.fromJson(x))),
    data: json["data"] == null
        ? []
        : List<DataBurungTersedia>.from(
            json["data"].map((x) => DataBurungTersedia.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BurungSemuaTersediabyIdModel {
  final String message;
  final int statusCode;
  final DataBurungTersedia data;

  BurungSemuaTersediabyIdModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  BurungSemuaTersediabyIdModel copyWith({
    String? message,
    int? statusCode,
    DataBurungTersedia? data,
  }) => BurungSemuaTersediabyIdModel(
    message: message ?? this.message,
    statusCode: statusCode ?? this.statusCode,
    data: data ?? this.data,
  );

  factory BurungSemuaTersediabyIdModel.fromRawJson(String str) =>
      BurungSemuaTersediabyIdModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BurungSemuaTersediabyIdModel.fromJson(Map<String, dynamic> json) =>
      BurungSemuaTersediabyIdModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: DataBurungTersedia.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status_code": statusCode,
    "data": data.toJson(),
  };
}

class DataBurungTersedia {
  final int id;
  final String image;
  final String noRing;
  final String jenisKelamin;
  final String usia;
  final String jenisKenari;
  final int harga;
  final String deskripsi;
  final String status;

  DataBurungTersedia({
    required this.id,
    required this.image,
    required this.noRing,
    required this.jenisKelamin,
    required this.usia,
    required this.jenisKenari,
    required this.harga,
    required this.deskripsi,
    required this.status,
  });

  DataBurungTersedia copyWith({
    int? id,
    String? image,
    String? noRing,
    String? jenisKelamin,
    String? usia,
    String? jenisKenari,
    int? harga,
    String? deskripsi,
    String? status,
  }) => DataBurungTersedia(
    id: id ?? this.id,
    image: image ?? this.image,
    noRing: noRing ?? this.noRing,
    jenisKelamin: jenisKelamin ?? this.jenisKelamin,
    usia: usia ?? this.usia,
    jenisKenari: jenisKenari ?? this.jenisKenari,
    harga: harga ?? this.harga,
    deskripsi: deskripsi ?? this.deskripsi,
    status: status ?? this.status,
  );

  factory DataBurungTersedia.fromRawJson(String str) =>
      DataBurungTersedia.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataBurungTersedia.fromJson(Map<String, dynamic> json) =>
      DataBurungTersedia(
        id: json["id"],
        image: json["image"],
        noRing: json["no_ring"],
        jenisKelamin: json["jenis_kelamin"],
        usia: json["usia"],
        jenisKenari: json["jenis_kenari"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "no_ring": noRing,
    "jenis_kelamin": jenisKelamin,
    "usia": usia,
    "jenis_kenari": jenisKenari,
    "harga": harga,
    "deskripsi": deskripsi,
    "status": status,
  };
}
