import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? uid;
  final String? email;
  final String displayName;
  final String? photoUrl;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    this.photoUrl,
  });

  // Factory constructor to map Firebase User to UserModel
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      displayName: user.displayName ?? 'Anonymous',
      email: user.email ?? 'No email',
      photoUrl: user.photoURL,
    );
  }
}
