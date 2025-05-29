import 'dart:convert';

class AnakRequestModel {
  final String noRing;
  final DateTime tanggalLahir;
  final String jenisKelamin;
  final String jenisKenari;
  final String keterangan;
  final String? gambarBurung; // nullable
  final int ayahId;
  final int ibuId;

  AnakRequestModel({
    required this.noRing,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.jenisKenari,
    required this.keterangan,
    this.gambarBurung, // nullable constructor param
    required this.ayahId,
    required this.ibuId,
  });

  AnakRequestModel copyWith({
    String? noRing,
    DateTime? tanggalLahir,
    String? jenisKelamin,
    String? jenisKenari,
    String? keterangan,
    String? gambarBurung,
    int? ayahId,
    int? ibuId,
  }) => AnakRequestModel(
    noRing: noRing ?? this.noRing,
    tanggalLahir: tanggalLahir ?? this.tanggalLahir,
    jenisKelamin: jenisKelamin ?? this.jenisKelamin,
    jenisKenari: jenisKenari ?? this.jenisKenari,
    keterangan: keterangan ?? this.keterangan,
    gambarBurung: gambarBurung ?? this.gambarBurung,
    ayahId: ayahId ?? this.ayahId,
    ibuId: ibuId ?? this.ibuId,
  );

  factory AnakRequestModel.fromRawJson(String str) =>
      AnakRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnakRequestModel.fromJson(Map<String, dynamic> json) =>
      AnakRequestModel(
        noRing: json["no_ring"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        jenisKelamin: json["jenis_kelamin"],
        jenisKenari: json["jenis_kenari"],
        keterangan: json["keterangan"],
        gambarBurung: json["gambar_burung"], // nullable, can be null
        ayahId: json["ayah_id"],
        ibuId: json["ibu_id"],
      );

  Map<String, dynamic> toJson() {
    final data = {
      "no_ring": noRing,
      "tanggal_lahir":
          "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
      "jenis_kelamin": jenisKelamin,
      "jenis_kenari": jenisKenari,
      "keterangan": keterangan,
      "ayah_id": ayahId,
      "ibu_id": ibuId,
    };
    if (gambarBurung != null) {
      data["gambar_burung"] = gambarBurung!;
    }
    return data;
  }
}
