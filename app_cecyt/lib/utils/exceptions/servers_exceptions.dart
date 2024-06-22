class ServerFailureExeception implements Exception {
  final String message;

  const ServerFailureExeception({required this.message});
}
