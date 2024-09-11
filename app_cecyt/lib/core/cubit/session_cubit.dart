import 'dart:async';
import 'dart:io';

import 'package:app_cecyt/core/utils/login_types.dart';
import 'package:app_cecyt/features/auth/data/models/login_response_model.dart';
import 'package:app_cecyt/features/auth/data/repositories/api_repository.dart';
import 'package:app_cecyt/utils/exceptions/servers_exceptions.dart';
import 'package:app_cecyt/utils/helpers/pref_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this.repository) : super(SessionNotLoaded());
  final ApiRepository repository;
  Timer? _timer;
  void setSession(String token, bool isAdmin, int expiresIn) {
    _startTokenRefreshTimer(expiresIn);
    emit(SessionLoaded(token: token, isAdmin: isAdmin));
  }

  void logout() {
    PrefManager(null).logout();

    emit(SessionNotLoaded());
  }

  Future<LoginResponseModel> _postRefreshToken() async {
    try {
      final token = PrefManager(null).token ?? '';
      final response = await repository.refreshToken(token);
      return response;
    } catch (e) {
      if (e is SocketException) {
        throw const ServerFailureExeception(message: 'No internet connection');
      }
      rethrow;
    }
  }

  // Función para refrescar el token
  Future<void> refreshToken() async {
    try {
      final newToken = await _postRefreshToken();
      PrefManager(null).setToken(newToken.accessToken);

      _startTokenRefreshTimer(newToken.expiresIn);
      emit(SessionLoaded(
          token: newToken.accessToken, isAdmin: newToken.isAdmin));
      print("Token refreshed successfully");
    } catch (e) {
      print("Error refreshing token: $e");
    }
  }

  // Función para iniciar el temporizador de refresco de token
  void _startTokenRefreshTimer(int durationInMinutes) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer =
        Timer.periodic(Duration(minutes: durationInMinutes), (timer) async {
      await refreshToken();
    });
  }

  // bool isAdmin() {
  //   return false;
  // }
}
