import 'package:zeow_driver/data/responses/users/register_user_api_response.dart';

class LoginUserApiResponse {
  final bool success;
  final String? token;
  final String? token_type;

  // final String? expires_in;
  final String? message;
  final int? isVerified;
  final Errors? errors;

  LoginUserApiResponse(
      {required this.success,
      this.token,
      this.token_type,
      this.errors,
      this.isVerified,
      this.message});

  factory LoginUserApiResponse.successFromJson(Map<String, dynamic> json) {
    return LoginUserApiResponse(
        success: json['success'],
        token: json['token'],
        token_type: json['token_type'],
        // expires_in: json['expires_in'],
        isVerified: json['isVerified']);
  }

  factory LoginUserApiResponse.failureFromJson(Map<String, dynamic> json) {
    return LoginUserApiResponse(
      success: json.containsKey('success') ? json['success'] as bool : false, // Ensure success is bool or defaults to false
      // Set to `false` only if `json['success']` is `null`
      message: json['message'] ?? '',
      // Ensure message is not null
      errors: json['errors'] != null
          ? Errors.fromJson(json['errors'] as Map<String, dynamic>)
          : null,
    );
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
