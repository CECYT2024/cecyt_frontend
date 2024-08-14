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
      if (response.status == "ok") {
        emit(RegisterSuccessState(response));
      } else {
        emit(const RegisterErrorState("Error al crear la cuenta"));
      }
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}
