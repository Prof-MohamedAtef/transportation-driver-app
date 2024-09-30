// {
// "success": true,
// "code": 200,
// "token": "36|W2EU6VIi2fjuedBmHBQbREeXVQsXcda5pf3XHmc57820cdd9",
// "token_type": "Bearer"
// }

class Errors {
  final List<String>? email;

  Errors({this.email});

  // Factory method to parse errors from JSON
  factory Errors.fromJson(Map<String, dynamic> json) {
    return Errors(
      email: json['email'] != null ? List<String>.from(json['email']) : null,
    );
  }

  // Convert errors back to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

class RegisterUserApiResponse {
  final bool success;
  final int code;
  final Errors? errors;

  RegisterUserApiResponse(
      {required this.success, required this.code, this.errors});

  factory RegisterUserApiResponse.successFromJson(Map<String, dynamic> json) {
    return RegisterUserApiResponse(
      success: json['success'],
      code: json['code'],
    );
  }

  factory RegisterUserApiResponse.failureFromJson(Map<String, dynamic> json) {
    return RegisterUserApiResponse(
      success: json['success'],
      code: json['code'],
      errors: json['errors'] != null
          ? Errors.fromJson(json['errors'] as Map<String, dynamic>)
          : null,
    );
  }
}
