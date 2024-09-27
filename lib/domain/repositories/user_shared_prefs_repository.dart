import '../../data/models/firebase_user_model.dart';

abstract class UserSharedPrefsRepository {
  Future<void> saveUser(FirebaseUserModel user);
  Future<FirebaseUserModel?> getUser();
  Future<void> clearUser();
}