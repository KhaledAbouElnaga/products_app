// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int? id;
  final String? email;
  final String? password;
  final String? name;
  final String? role;
  final String? avatar;
  final DateTime? creationAt;
  final DateTime? updatedAt;

  UserModel({
    this.id,
    this.email,
    this.password,
    this.name,
    this.role,
    this.avatar,
    this.creationAt,
    this.updatedAt,
  });

  UserModel copyWith({
    int? id,
    String? email,
    String? password,
    String? name,
    String? role,
    String? avatar,
    DateTime? creationAt,
    DateTime? updatedAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        name: name ?? this.name,
        role: role ?? this.role,
        avatar: avatar ?? this.avatar,
        creationAt: creationAt ?? this.creationAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
        avatar: json["avatar"],
        creationAt: json["creationAt"] == null
            ? null
            : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "role": role,
        "avatar": avatar,
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
