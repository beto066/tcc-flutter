class UnexpectedException implements Exception {
  final String message;

  UnexpectedException(this.message);

  @override
  String toString() => 'UnexpectedException: $message';
}