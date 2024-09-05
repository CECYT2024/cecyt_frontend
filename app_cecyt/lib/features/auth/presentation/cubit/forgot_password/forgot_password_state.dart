part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitialState extends ForgotPasswordState {}

final class ForgotPasswordLoadingState extends ForgotPasswordState {}

final class ForgotPasswordSuccessState extends ForgotPasswordState {
  final String message;
  ForgotPasswordSuccessState(this.message);
}

final class ForgotPasswordErrorState extends ForgotPasswordState {
  final String message;
  ForgotPasswordErrorState(this.message);
}

final class ForgotPasswordConfirmPageState extends ForgotPasswordState {}
// final class ForgotPasswordLoadedState extends ForgotPasswordState {}
