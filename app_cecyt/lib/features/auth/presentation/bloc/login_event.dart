part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class DoLoginEvent extends LoginEvent {
  String matricula;
  String password;
  DoLoginEvent(
    this.matricula,
    this.password,
  );
}
