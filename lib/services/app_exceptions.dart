class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad Request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to Process', url);
}

class ApiNotResponding extends AppException {
  ApiNotResponding([String? message, String? url])
      : super(message, 'Api is Not Responding', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'UnAuthorized Request', url);
}
