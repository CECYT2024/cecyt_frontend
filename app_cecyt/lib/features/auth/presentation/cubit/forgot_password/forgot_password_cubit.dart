import 'package:app_cecyt/features/auth/data/repositories/api_repository.dart';
import 'package:app_cecyt/features/auth/domain/confirm_forgot_password_params.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.repository) : super(ForgotPasswordInitialState());
  final ApiRepository repository;

  void sendEmail(String email, String matricula) async {
    emit(ForgotPasswordLoadingState());
    try {
      await repository.forgotPassword({
        'email': email,
        'student_id': matricula,
      });
      emit(ForgotPasswordConfirmPageState());
    } catch (e) {
      emit(ForgotPasswordErrorState(e.toString()));
    }
  }

  void confirmForgotPassword(ConfirmForgotPasswordParams params) async {
    emit(ForgotPasswordLoadingState());
    try {
      await repository.confimrForgotPassword(params);
      emit(ForgotPasswordSuccessState("contrasena cambiado"));
    } catch (e) {
      emit(ForgotPasswordErrorState(e.toString()));
    }
  }
}
