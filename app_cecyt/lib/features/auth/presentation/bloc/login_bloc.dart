import 'dart:io';

import 'package:app_cecyt/utils/exceptions/servers_exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginParams {
  final String matricula;
  final String password;
  const LoginParams({
    required this.matricula,
    required this.password,
  });
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
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

  Future<Map<String, String>> _postLogin(LoginParams params) async {
    sleep(const Duration(seconds: 6));
    return {"matricula": params.matricula, "password": params.password};
  }

  Future<void> login(LoginParams params, Emitter<LoginState> emit) async {
    try {
      // throw const ServerFailureExeception(message: 'Error');
      final data = await _postLogin(params);
      emit(LoggedState());
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
