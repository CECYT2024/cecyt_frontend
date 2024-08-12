class LoginParams {
  final String matricula;
  final String password;
  const LoginParams({
    required this.matricula,
    required this.password,
  });
  Map<String, String> toMap() {
    return {
      'student_id': matricula,
      'password': password,
    };
  }
}
