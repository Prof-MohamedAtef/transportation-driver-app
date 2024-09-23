class AddCarsApiResponse {
  final String status;
  final int code;
  final String message;

  AddCarsApiResponse({required this.status, required this.code, required this.message});

  // Factory method to create ApiResponse from JSON
  factory AddCarsApiResponse.fromJson(Map<String, dynamic> json) {
    return AddCarsApiResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
    );
  }
}