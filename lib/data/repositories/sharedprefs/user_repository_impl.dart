import '../../../domain/repositories/user_shared_prefs_repository.dart';
import '../../datasources/sharedprefs/shared_prefs_service.dart';
import '../../models/user_model.dart';

class UserRepositoryImpl implements UserSharedPrefsRepository {
  final SharedPreferencesService sharedPreferencesService;

  UserRepositoryImpl(this.sharedPreferencesService);

  @override
  Future<void> saveUser(UserModel user) async {
    await sharedPreferencesService.saveUser(user);
  }

  @override
  Future<UserModel?> getUser() async {
    return await sharedPreferencesService.getUser();
  }

  @override
  Future<void> clearUser() async {
    await sharedPreferencesService.clearUser();
  }
}