import '../../data/models/user_model.dart';

abstract class UserSharedPrefsRepository {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
}