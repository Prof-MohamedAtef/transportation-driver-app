import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserModel {
  final String? uid;
  final String? email;
  final String displayName;
  final String? photoUrl;

  FirebaseUserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    this.photoUrl,
  });

  // Factory constructor to map Firebase User to UserModel
  factory FirebaseUserModel.fromFirebaseUser(User user) {
    return FirebaseUserModel(
      uid: user.uid,
      displayName: user.displayName ?? 'Anonymous',
      email: user.email ?? 'No email',
      photoUrl: user.photoURL,
    );
  }
}
