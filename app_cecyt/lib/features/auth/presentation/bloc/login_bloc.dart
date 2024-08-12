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
      if (e is SocketException) {
        throw const ServerFailureExeception(message: 'No internet connection');
      }
      rethrow;
    }
  }

  Future<void> login(LoginParams params, Emitter<LoginState> emit) async {
    try {
      final data = await _postLogin(params);
      PrefManager(null).setToken(data.accessToken);
      tokenCambiable = data.accessToken;

      emit(LoggedState(data));
    } on BadRequestException catch (e) {
      if (isClosed) {
        return;
      }
      emit(LoginErrorState(e.message));
    } catch (e) {
      if (e is ServerFailureExeception) {
        if (isClosed) {
          return;
        }
        emit(LoginErrorState(e.message));
      }
    }
  }
}
