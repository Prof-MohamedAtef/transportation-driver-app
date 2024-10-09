import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserModel {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? token;
  final int? isVerified;

  FirebaseUserModel({
    this.uid,
    this.displayName,
    this.email,
    this.photoUrl,
    this.token,
    this.isVerified
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
