part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

final class LoginProgressState extends LoginState {}

final class LoggedState extends LoginState {}

final class LoginSuccessState extends LoginState {}
