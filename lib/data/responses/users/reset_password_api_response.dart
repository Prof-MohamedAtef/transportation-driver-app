class ResetPasswordApiResponse {
  final String? message;
  final bool? status;
  final int? code;
  ResetPasswordApiResponse({this.message, this.code, this.status});

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
        code: json['code'],
        status: json['status']
    );
  }
}