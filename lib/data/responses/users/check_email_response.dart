class CheckUserEmailResponse {
  final String? message;
  final String? status;
  final String? code;
  CheckUserEmailResponse({this.message, this.status, this.code});

  factory CheckUserEmailResponse.fromJson(Map<String, dynamic> json) {
    return CheckUserEmailResponse(
      message: json['message'],
      status: json['status'],
      code: json['code'],
    );
  }
}
