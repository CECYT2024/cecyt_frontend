import 'dart:convert';

class DeleteResponseModel {
  final String message;

  DeleteResponseModel({
    required this.message,
  });

  factory DeleteResponseModel.fromJson(Map<String, dynamic> json) =>
      DeleteResponseModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
