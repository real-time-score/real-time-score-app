class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  AppException({
    required this.message,
    this.code,
    this.data,
  });

  @override
  String toString() => 'AppException: $message (code: $code)';
}

class NetworkException extends AppException {
  NetworkException({required super.message, super.code, super.data});
}

class ServerException extends AppException {
  final int? statusCode;

  ServerException({
    required super.message,
    super.code,
    super.data,
    this.statusCode,
  });
}

class CacheException extends AppException {
  CacheException({required super.message, super.code, super.data});
}

class AuthException extends AppException {
  AuthException({required super.message, super.code, super.data});
}

class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  ValidationException({
    required super.message,
    super.code,
    super.data,
    this.fieldErrors,
  });
}
