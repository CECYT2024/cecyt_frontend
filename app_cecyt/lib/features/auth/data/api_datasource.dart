import 'dart:convert';

import 'package:app_cecyt/core/exceptions/exceptions.dart';
import 'package:app_cecyt/features/auth/data/models/models.dart';
import 'package:app_cecyt/features/auth/domain/login_params.dart';
import 'package:app_cecyt/features/auth/domain/register_params.dart';
import 'package:app_cecyt/utils/constants.dart';
import 'package:http/http.dart' as http;

class AuthApiDataSource {
  // static String url = baseUrl;
  Future<LoginResponseModel> login(LoginParams params) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(url, body: params.toMap());
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
    if (response.statusCode == 409) {
      throw BadRequestException(
          message: 'Usuario ya registrado, intente de nuevo');
    }
    return RegisterResponseModel.fromRawJson(response.body);
  }

  Future<LoginResponseModel> refreshToken(String token) async {
    final url = Uri.parse('$baseUrl/refresh');
    final response = await http.post(url, headers: {
      "Authorization": "Bearer $token",
    });
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
}
