import 'dart:convert';

class RegisterResponseModel {
  final String status;
  final String message;
  final DataRegister data;
  final String token;
  final int expiresIn;

  RegisterResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.token,
    required this.expiresIn,
  });

  factory RegisterResponseModel.fromRawJson(String str) =>
      RegisterResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        status: json["status"],
        message: json["message"],
        data: DataRegister.fromJson(json["data"]),
        token: json["token"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
        "token": token,
        "expires_in": expiresIn,
      };
}

class DataRegister {
  final String studentId;
  final String email;
  final String name;
  final String lastname;
  final int userType;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  DataRegister({
    required this.studentId,
    required this.email,
    required this.name,
    required this.lastname,
    required this.userType,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory DataRegister.fromRawJson(String str) =>
      DataRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataRegister.fromJson(Map<String, dynamic> json) => DataRegister(
        studentId: json["student_id"],
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        userType: json["user_type"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "email": email,
        "name": name,
        "lastname": lastname,
        "user_type": userType,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
