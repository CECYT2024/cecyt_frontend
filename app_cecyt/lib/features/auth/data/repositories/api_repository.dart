import 'package:app_cecyt/features/auth/data/api_datasource.dart';
import 'package:app_cecyt/features/auth/data/models/forgot_password_model.dart';

import 'package:app_cecyt/features/auth/data/models/models.dart';
import 'package:app_cecyt/features/auth/domain/confirm_forgot_password_params.dart';
import 'package:app_cecyt/features/auth/domain/login_params.dart';
import 'package:app_cecyt/features/auth/domain/register_params.dart';

class ApiRepository {
  final AuthApiDataSource apiProvider;

  ApiRepository({required this.apiProvider});

  Future<LoginResponseModel> login(LoginParams params) async {
    return apiProvider.login(params);
  }

  Future<LoginResponseModel> refreshToken(String token) async {
    return apiProvider.refreshToken(token);
  }

  Future<RegisterResponseModel> register(RegisterParams params) async {
    return apiProvider.register(params);
  }

  Future<ForgotPasswordModel> forgotPassword(Map<String, String> params) async {
    return apiProvider.forgotSendEmail(params);
  }

  Future<ForgotPasswordModel> confimrForgotPassword(
      ConfirmForgotPasswordParams params) async {
    return apiProvider.confirmForgotPass(params);
  }
}
