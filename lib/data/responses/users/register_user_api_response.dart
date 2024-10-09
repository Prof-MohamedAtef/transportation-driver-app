// {
// "success": true,
// "code": 200,
// "token": "36|W2EU6VIi2fjuedBmHBQbREeXVQsXcda5pf3XHmc57820cdd9",
// "token_type": "Bearer"
// }

class Errors {
  final List<String>? email;
  final List<String>? password;

  Errors({this.email, this.password});

  // Factory method to parse errors from JSON
  factory Errors.fromJson(Map<String, dynamic> json) {
    return Errors(
        email: json['email'] != null ? List<String>.from(json['email']) : null,
        password: json['password'] != null ? List<String>.from(json['password']) : null);
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
