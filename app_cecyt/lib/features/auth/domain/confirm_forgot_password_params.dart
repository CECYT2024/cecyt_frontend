class ConfirmForgotPasswordParams {
  final String email;
  final String password;
  final String code;
  final String confirmPassword;
  const ConfirmForgotPasswordParams({
    required this.email,
    required this.code,
    required this.confirmPassword,
    required this.password,
  });
  Map<String, String> toMap() {
    return {
      'email': email,
      'code': code,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
