part of 'session_cubit.dart';

@immutable
sealed class SessionState {
  final LoginTypes loginType;

  SessionState({required this.loginType});
}

final class SessionNotLoaded extends SessionState {
  SessionNotLoaded() : super(loginType: LoginTypes.notLogged);
}

final class SessionLoaded extends SessionState {
  final String token;
  final bool isAdmin;
  SessionLoaded({required this.token, required this.isAdmin})
      : super(loginType: isAdmin ? LoginTypes.admin : LoginTypes.logged);
}
