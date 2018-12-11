class ApiException extends Exception {
  factory ApiException(String message) => new ApiException(message);
}