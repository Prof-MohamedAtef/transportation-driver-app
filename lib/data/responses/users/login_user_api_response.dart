class LoginUserApiResponse {
  final bool success;
  final String? token;
  final String? token_type;
  final String? expires_in;
  final String? message;

  LoginUserApiResponse(
      {required this.success,
      this.token,
      this.token_type,
      this.expires_in,
      this.message});

  factory LoginUserApiResponse.successFromJson(Map<String, dynamic> json) {
    return LoginUserApiResponse(
        success: json['success'],
        token: json['token'],
        token_type: json['token_type'],
        expires_in: json['expires_in']);
  }

  factory LoginUserApiResponse.failureFromJson(Map<String, dynamic> json) {
    return LoginUserApiResponse(
        success: json['success'],
        message: json['message']);
  }
}

class ErrorMessage {
  final bool success;
  final String message;

  ErrorMessage({required this.success, required this.message});

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(success: json['success'], message: json['message']);
  }
}
