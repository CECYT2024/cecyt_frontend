import 'dart:convert';

import 'package:app_cecyt/core/exceptions/exceptions.dart';
import 'package:app_cecyt/features/auth/data/models/models.dart';
import 'package:app_cecyt/features/auth/domain/login_params.dart';
import 'package:app_cecyt/features/auth/domain/register_params.dart';
import 'package:http/http.dart' as http;

class AuthApiDataSource {
  static String baseUrl =
      "https://cecyt-app-api-33d7bb093309.herokuapp.com/api";
  Future<LoginResponseModel> login(LoginParams params) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(url, body: params.toMap());
    print(url);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 401) {
      throw BadRequestException(
          message: 'Credenciales incorrectas, intente de nuevo');
    }
    if (response.statusCode == 500) {
      throw BadRequestException(
          message: 'Error en el servidor, intente de nuevo');
    }
    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw BadRequestException(message: json.decode(response.body)['error']);
    }
    // if (response.statusCode != 200) {
    //   throw BadRequestException(
    //       message: 'Error al iniciar sesión, intente de nuevo');
    // }
    return LoginResponseModel.fromRawJson(response.body);
  }

  Future<RegisterResponseModel> register(RegisterParams params) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(url, body: params.toMap());
    print(url);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 401) {
      throw BadRequestException(
          message: 'Credenciales incorrectas, intente de nuevo');
    }
    if (response.statusCode == 500) {
      throw BadRequestException(
          message: 'Error en el servidor, intente de nuevo');
    }
    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw BadRequestException(message: json.decode(response.body)['error']);
    }
    return RegisterResponseModel.fromRawJson(response.body);
  }
}
