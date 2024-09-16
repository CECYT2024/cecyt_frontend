import 'dart:convert';
import 'dart:developer';

import 'package:app_cecyt/core/exceptions/exceptions.dart';
import 'package:app_cecyt/features/auth/data/models/forgot_password_model.dart';
import 'package:app_cecyt/features/auth/data/models/models.dart';
import 'package:app_cecyt/features/auth/domain/confirm_forgot_password_params.dart';
import 'package:app_cecyt/features/auth/domain/login_params.dart';
import 'package:app_cecyt/features/auth/domain/register_params.dart';
import 'package:app_cecyt/utils/constants.dart';
import 'package:http/http.dart' as http;

class AuthApiDataSource {
  // static String url = baseUrl;
  // static const headers = {
  //   'Content-Type': 'application/json',
  //   'Accept': 'application/json',
  // };

  Future<LoginResponseModel> login(LoginParams params) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: params.toMap(),
    );
    log(url.toString());
    log(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 401) {
      throw NotAuthException();
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
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode(params.toMap()),
    );
    print(url);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 401) {
      throw NotAuthException();
    }
    if (response.statusCode == 500) {
      throw BadRequestException(
          message: 'Error en el servidor, intente de nuevo');
    }
    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw BadRequestException(message: json.decode(response.body)['message']);
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
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      // "Content-Type": "application/json",
    });
    log(url.toString());
    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 401) {
      throw NotAuthException();
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

  Future<ForgotPasswordModel> forgotSendEmail(
      Map<String, String> params) async {
    final url = Uri.parse('$baseUrl/forgot-password');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: params,
    );
    print(url);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 401) {
      throw NotAuthException();
    }
    if (response.statusCode >= 500) {
      throw BadRequestException(
          message: 'Error en el servidor, intente de nuevo');
    }
    if (response.statusCode >= 400 && response.statusCode < 500) {
      final responseBody = json.decode(response.body);
      final errorMessage = responseBody['error'] ?? 'Error desconocido';
      throw BadRequestException(message: errorMessage);
    }

    return forgotPasswordModelFromJson(response.body);
  }

  Future<ForgotPasswordModel> confirmForgotPass(
      ConfirmForgotPasswordParams params) async {
    final url = Uri.parse('$baseUrl/forgot-password/recover');
    final response = await http.post(
      url,
      body: params.toMap(),
    );
    print(url);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 401) {
      throw NotAuthException();
    }
    if (response.statusCode >= 500) {
      throw BadRequestException(
          message: 'Error en el servidor, intente de nuevo');
    }
    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw BadRequestException(message: json.decode(response.body)['message']);
    }

    return forgotPasswordModelFromJson(response.body);
  }
}
