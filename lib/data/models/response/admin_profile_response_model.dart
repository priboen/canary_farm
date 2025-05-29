import 'dart:convert';

class AdminProfileResponseModel {
    final String? message;
    final int? statusCode;
    final AdminProfile? data;

    AdminProfileResponseModel({
        this.message,
        this.statusCode,
        this.data,
    });

    factory AdminProfileResponseModel.fromJson(String str) => AdminProfileResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AdminProfileResponseModel.fromMap(Map<String, dynamic> json) => AdminProfileResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: json["data"] == null ? null : AdminProfile.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "status_code": statusCode,
        "data": data?.toMap(),
    };
}

class AdminProfile {
    final int? id;
    final String? name;

    AdminProfile({
        this.id,
        this.name,
    });

    factory AdminProfile.fromJson(String str) => AdminProfile.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AdminProfile.fromMap(Map<String, dynamic> json) => AdminProfile(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
    };
}
