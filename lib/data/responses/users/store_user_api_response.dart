/// status : "success"
/// code : 201
/// message : "User created successfully"
/// user : {"firebaseUserId":"40646","email":"mo@gmail.com","displayName":"Mohamed","profilePhoto":"uploads/1gbF9Q2AuZyOLfJGgnyx8nrrDBMIQ9Z8UNARRmeL.jpg","isVerified":true,"updated_at":"2024-09-25T16:53:24.000000Z","created_at":"2024-09-25T16:53:24.000000Z","id":3}

class StoreUserApiResponse {
  final String status;
  final int code;
  final String message;
  final User? user;

  StoreUserApiResponse({
    required this.status,
    required this.code,
    required this.message,
    this.user,
  });

  factory StoreUserApiResponse.fromJson(Map<String, dynamic> json) {
    return StoreUserApiResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final String firebaseUserId;
  final String email;
  final String displayName;
  final String profilePhoto;
  final bool isVerified;

  User({
    required this.firebaseUserId,
    required this.email,
    required this.displayName,
    required this.profilePhoto,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firebaseUserId: json['firebaseUserId'],
      email: json['email'],
      displayName: json['displayName'],
      profilePhoto: json['profilePhoto'],
      isVerified: json['isVerified'],
    );
  }
}