import 'dart:convert';

import 'package:app_cecyt/core/exceptions/exceptions.dart';
import 'package:app_cecyt/features/auth/data/models/register_response_model.dart';
import 'package:app_cecyt/features/auth/data/repositories/api_repository.dart';
import 'package:app_cecyt/features/auth/domain/register_params.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final ApiRepository repository;
  RegisterCubit({required this.repository}) : super(RegisterInitial());

  Future<void> register(RegisterParams params) async {
    emit(RegisterProgressState());
    try {
      final response = await repository.register(params);
      print(response.status);
      if (response.status == "ok") {
        emit(RegisterSuccessState(response));
      } else {
        emit(const RegisterErrorState("Error al crear la cuenta"));
      }
    } on BadRequestException catch (e) {
      emit(RegisterErrorState(e.message));
    } catch (e) {
      // Formatear el error de manera similar al EventsBloc
      print(e);
      final errorMessage = _formatError(e);
      emit(RegisterErrorState(errorMessage));
    }
  }

  String _formatError(dynamic error) {
    try {
      final responseBody = jsonDecode(error.toString());
      if (responseBody is Map && responseBody.containsKey('message')) {
        if (responseBody['message'] == 'User already exists') {
          return 'usuario ya creado';
        }
        return responseBody['message'];
      } else {
        return 'Error desconocido';
      }
    } catch (_) {
      return error.toString();
    }
  }
}
