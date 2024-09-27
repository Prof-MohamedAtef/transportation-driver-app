// {
// "success": true,
// "code": 200,
// "token": "36|W2EU6VIi2fjuedBmHBQbREeXVQsXcda5pf3XHmc57820cdd9",
// "token_type": "Bearer"
// }

class Errors {
  final List<String> email;

  Errors({required this.email});

  factory Errors.fromJson(Map<String, dynamic> json) {
    return Errors(
      email: List<String>.from(json['email'] ?? []),
    );
  }
}

class RegisterUserApiResponse {
  final bool success;
  final int code;
  final String? token;
  final String? tokenType;
  final Errors? errors;

  RegisterUserApiResponse({
    required this.success,
    required this.code,
    this.token,
    this.tokenType,
    this.errors,
  });

  factory RegisterUserApiResponse.fromJson(Map<String, dynamic> json) {
    return RegisterUserApiResponse(
      success: json['success'],
      code: json['code'],
      token: json['token'],
      tokenType: json['token_type'],
      errors: json['errors'] != null ? Errors.fromJson(json['errors']) : null,
    );
  }
}