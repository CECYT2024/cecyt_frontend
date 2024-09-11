import 'dart:convert';

class LoginResponseModel {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final bool isAdmin;

  LoginResponseModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.isAdmin,
  });

  factory LoginResponseModel.fromRawJson(String str) =>
      LoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        isAdmin: json["isAdmin"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "is_admin": isAdmin,
      };
}
