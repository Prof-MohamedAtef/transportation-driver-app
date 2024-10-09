import 'package:zeow_driver/data/responses/users/register_user_api_response.dart';

class ResetPasswordApiResponse {
  final String? message;
  final bool? status;
  final int? code;
  final Errors? errors;
  ResetPasswordApiResponse({this.message, this.code, this.status, this.errors});

  factory ResetPasswordApiResponse.successFromJson(Map<String, dynamic> json) {
    return ResetPasswordApiResponse(
      message: json['message'],
      code: json['code'],
      status: json['status']
    );
  }

  factory ResetPasswordApiResponse.failureFromJson(Map<String, dynamic> json) {
    return ResetPasswordApiResponse(
        message: json['message'],
        errors: json.containsKey('errors') ? Errors.fromJson(json['errors']) : null
    );
  }
}