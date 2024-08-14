class RegisterParams {
  final String email;
  final String password;
  final String name;
  final String lastname;
  final String studentID;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.name,
    required this.lastname,
    required this.studentID,
  });

  Map<String, String> toMap() {
    return {
      'student_id': studentID,
      'password': password,
      "email": email,
      'name': name,
      'lastname': lastname,
    };
  }
}
