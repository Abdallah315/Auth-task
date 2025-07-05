class CustomException implements Exception {
  final String? message;
  final int? statusCode;
  final String? error;

  CustomException({this.message, this.statusCode, this.error});

  @override
  String toString() => '$statusCode - $message';
}
