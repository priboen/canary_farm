import 'dart:convert';

class GetAllBurungModel {
  final String message;
  final int statusCode;
  final List<GetAllBurung> data;

  GetAllBurungModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  GetAllBurungModel copyWith({
    String? message,
    int? statusCode,
    List<GetAllBurung>? data,
  }) => GetAllBurungModel(
    message: message ?? this.message,
    statusCode: statusCode ?? this.statusCode,
    data: data ?? this.data,
  );

  factory GetAllBurungModel.fromJson(String str) =>
      GetAllBurungModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllBurungModel.fromMap(Map<String, dynamic> json) =>
      GetAllBurungModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: List<GetAllBurung>.from(
          json["data"].map((x) => GetAllBurung.fromMap(x)),
        ),
      );

  Map<String, dynamic> toMap() => {
    "message": message,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class GetAllBurung {
  final int id;
  final Tipe tipe;
  final String noRing;
  final JenisKelamin jenisKelamin;
  final DateTime tanggalLahir;
  final JenisKenari jenisKenari;

  GetAllBurung({
    required this.id,
    required this.tipe,
    required this.noRing,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.jenisKenari,
  });

  GetAllBurung copyWith({
    int? id,
    Tipe? tipe,
    String? noRing,
    JenisKelamin? jenisKelamin,
    DateTime? tanggalLahir,
    JenisKenari? jenisKenari,
  }) => GetAllBurung(
    id: id ?? this.id,
    tipe: tipe ?? this.tipe,
    noRing: noRing ?? this.noRing,
    jenisKelamin: jenisKelamin ?? this.jenisKelamin,
    tanggalLahir: tanggalLahir ?? this.tanggalLahir,
    jenisKenari: jenisKenari ?? this.jenisKenari,
  );

  factory GetAllBurung.fromJson(String str) =>
      GetAllBurung.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllBurung.fromMap(Map<String, dynamic> json) => GetAllBurung(
    id: json["id"],
    tipe: tipeValues.map[json["tipe"]]!,
    noRing: json["no_ring"],
    jenisKelamin: jenisKelaminValues.map[json["jenis_kelamin"]]!,
    tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
    jenisKenari: jenisKenariValues.map[json["jenis_kenari"]]!,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "tipe": tipeValues.reverse[tipe],
    "no_ring": noRing,
    "jenis_kelamin": jenisKelaminValues.reverse[jenisKelamin],
    "tanggal_lahir":
        "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
    "jenis_kenari": jenisKenariValues.reverse[jenisKenari],
  };
}

enum JenisKelamin { BETINA, JANTAN }

final jenisKelaminValues = EnumValues({
  "betina": JenisKelamin.BETINA,
  "jantan": JenisKelamin.JANTAN,
});

enum JenisKenari { AF_MEDIUM, LOCAL, YS }

final jenisKenariValues = EnumValues({
  "AF Medium": JenisKenari.AF_MEDIUM,
  "Local": JenisKenari.LOCAL,
  "YS": JenisKenari.YS,
});

enum Tipe { ANAK, INDUK }

final tipeValues = EnumValues({"anak": Tipe.ANAK, "induk": Tipe.INDUK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
