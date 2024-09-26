import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/usecases/sharedprefs/clear_user_usecase.dart';
import '../../../domain/usecases/sharedprefs/get_user_usecase.dart';
import '../../../domain/usecases/sharedprefs/save_user_usecase.dart';

class UserViewModel extends ChangeNotifier {
  final SaveUserSharedPrefsUseCase saveUserUseCase;
  final GetUserSharedPrefsUseCase getUserUseCase;
  final ClearUserSharedPrefsUseCase clearUserUseCase;

  UserModel? _user;

  UserModel? get user => _user;

  UserViewModel(this.saveUserUseCase, this.getUserUseCase, this.clearUserUseCase);

  Future<void> saveUser(UserModel user) async {
    await saveUserUseCase(user);
    _user = user;
    notifyListeners();
  }

  Future<void> loadUser() async {
    _user = await getUserUseCase();
    notifyListeners();
  }

  Future<void> clearUser() async {
    await clearUserUseCase();
    _user = null;
    notifyListeners();
  }
}