import 'dart:convert';

LogInModel logInModelFromJson(String str) =>
    LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
  final String? accessToken;
  final String? refreshToken;

  LogInModel({
    this.accessToken,
    this.refreshToken,
  });

  LogInModel copyWith({
    String? accessToken,
    String? refreshToken,
  }) =>
      LogInModel(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
