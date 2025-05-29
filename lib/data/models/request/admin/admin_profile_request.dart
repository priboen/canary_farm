import 'dart:convert';

class AdminProfileRequestModel {
    final String? name;

    AdminProfileRequestModel({
        this.name,
    });

    factory AdminProfileRequestModel.fromJson(String str) => AdminProfileRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AdminProfileRequestModel.fromMap(Map<String, dynamic> json) => AdminProfileRequestModel(
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
    };
}
