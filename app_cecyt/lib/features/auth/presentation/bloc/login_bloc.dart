import 'dart:async';
import 'dart:io';

import 'package:app_cecyt/core/exceptions/exceptions.dart';
import 'package:app_cecyt/features/auth/data/models/login_response_model.dart';
import 'package:app_cecyt/features/auth/data/repositories/api_repository.dart';
import 'package:app_cecyt/features/auth/domain/login_params.dart';
import 'package:app_cecyt/utils/constants.dart';
import 'package:app_cecyt/utils/exceptions/servers_exceptions.dart';
import 'package:app_cecyt/utils/helpers/pref_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiRepository repository;
  Timer? _timer;
  LoginBloc(this.repository) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginProgressState());
      if (event is DoLoginEvent) {
        await login(
          LoginParams(matricula: event.matricula, password: event.password),
          emit,
        );
      }
    });
  }

  Future<LoginResponseModel> _postLogin(LoginParams params) async {
    try {
      final response = await repository.login(params);

      return response;
    } catch (e) {
      print("er");
      if (e is SocketException) {
        throw const ServerFailureExeception(message: 'No internet connection');
      }
      rethrow;
    }
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
  Future<void> _refreshToken() async {
    try {
      final newToken = await _postRefreshToken();
      PrefManager(null).setToken(newToken.accessToken);
      tokenCambiable = newToken.accessToken;
      _startTokenRefreshTimer(newToken.expiresIn);
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
      await _refreshToken();
    });
  }

  void refreshToken() {
    _refreshToken();
  }

  Future<void> login(LoginParams params, Emitter<LoginState> emit) async {
    try {
      final data = await _postLogin(params);
      PrefManager(null).setToken(data.accessToken);
      tokenCambiable = data.accessToken;
      _startTokenRefreshTimer(data.expiresIn);

      emit(LoggedState(data));
    } on BadRequestException catch (e) {
      print(e.message);
      print("error");
      if (isClosed) {
        return;
      }
      emit(LoginErrorState(e.message));
    } on NotAuthException {
      if (isClosed) {
        return;
      }
      emit(LoginErrorState("Por favor verifica tus credenciales"));
    } on ServerFailureExeception catch (e) {
      if (isClosed) {
        return;
      }

      emit(LoginErrorState(e.toString()));
    }
  }
}
