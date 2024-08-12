class BadRequestException implements Exception {
  final String message;
  BadRequestException({required this.message});
}
