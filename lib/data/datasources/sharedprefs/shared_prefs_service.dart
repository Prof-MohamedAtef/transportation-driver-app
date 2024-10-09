import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/firebase_user_model.dart';

class SharedPreferencesService {
  static const String _userKey = 'user_data';

  Future<void> saveUser(FirebaseUserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
      'token': user.token,
      'isVerified': user.isVerified
    });
    await prefs.setString(_userKey, userData);
  }

  Future<FirebaseUserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData == null) return null;

    final Map<String, dynamic> json = jsonDecode(userData);
    return FirebaseUserModel(
        uid: json['uid'],
        email: json['email'],
        displayName: json['displayName'],
        photoUrl: json['photoUrl'],
        token: json['token'],
        isVerified: json['isVerified']);
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
