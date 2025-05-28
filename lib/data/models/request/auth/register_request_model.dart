import 'dart:convert';

class RegisterRequestModel {
    final String? username;
    final String? email;
    final String? password;
    final int? roleId;

    RegisterRequestModel({
        this.username,
        this.email,
        this.password,
        this.roleId = 2,
    });

    factory RegisterRequestModel.fromJson(String str) => RegisterRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RegisterRequestModel.fromMap(Map<String, dynamic> json) => RegisterRequestModel(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        roleId: json["role_id"],
    );

    Map<String, dynamic> toMap() => {
        "username": username,
        "email": email,
        "password": password,
        "role_id": roleId,
    };
}
