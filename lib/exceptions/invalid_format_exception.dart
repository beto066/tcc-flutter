class InvalidFormatException implements Exception {
  final String message;

  InvalidFormatException(this.message);

  @override
  String toString() => 'InvalidFormatException: $message';
}