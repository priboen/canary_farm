import 'dart:convert';

class IndukRequestModel {
  final String noRing;
  final DateTime tanggalLahir;
  final String jenisKelamin;
  final String jenisKenari;
  final String keterangan;
  final String gambarBurung;

  IndukRequestModel({
    required this.noRing,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.jenisKenari,
    required this.keterangan,
    required this.gambarBurung,
  });

  IndukRequestModel copyWith({
    String? noRing,
    DateTime? tanggalLahir,
    String? jenisKelamin,
    String? jenisKenari,
    String? keterangan,
    String? gambarBurung,
  }) => IndukRequestModel(
    noRing: noRing ?? this.noRing,
    tanggalLahir: tanggalLahir ?? this.tanggalLahir,
    jenisKelamin: jenisKelamin ?? this.jenisKelamin,
    jenisKenari: jenisKenari ?? this.jenisKenari,
    keterangan: keterangan ?? this.keterangan,
    gambarBurung: gambarBurung ?? this.gambarBurung,
  );

  factory IndukRequestModel.fromRawJson(String str) =>
      IndukRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IndukRequestModel.fromJson(Map<String, dynamic> json) =>
      IndukRequestModel(
        noRing: json["no_ring"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        jenisKelamin: json["jenis_kelamin"],
        jenisKenari: json["jenis_kenari"],
        keterangan: json["keterangan"],
        gambarBurung: json["gambar_burung"],
      );

  Map<String, dynamic> toJson() => {
    "no_ring": noRing,
    "tanggal_lahir":
        "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
    "jenis_kelamin": jenisKelamin,
    "jenis_kenari": jenisKenari,
    "keterangan": keterangan,
    "gambar_burung": gambarBurung,
  };
}
