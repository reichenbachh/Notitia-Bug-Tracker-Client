class CustomException implements Exception {
  final String message;
  final String prefix;

  CustomException([this.message, this.prefix]);

  String toString() {
    return "$prefix $message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String message]) : super(message, "Invalid Request: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised:: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}
