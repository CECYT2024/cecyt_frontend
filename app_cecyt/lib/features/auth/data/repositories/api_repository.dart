import 'package:app_cecyt/features/auth/data/api_datasource.dart';

import 'package:app_cecyt/features/auth/data/models/models.dart';
import 'package:app_cecyt/features/auth/domain/login_params.dart';
import 'package:app_cecyt/features/auth/domain/register_params.dart';

class ApiRepository {
  final AuthApiDataSource apiProvider;

  ApiRepository({required this.apiProvider});

  Future<LoginResponseModel> login(LoginParams params) async {
    return apiProvider.login(params);
  }

  Future<RegisterResponseModel> register(RegisterParams params) async {
    return apiProvider.register(params);
  }
}
