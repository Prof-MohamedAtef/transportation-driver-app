import 'dart:io';

import 'package:flutter/material.dart';

import '../../../domain/usecases/users/store_user_api_use_case.dart';
import '../../state/store_user_state.dart';

class UserApiViewModel extends ChangeNotifier {
  final StoreUserApiUseCase storeUserApiUseCase;

  UserApiViewModel(this.storeUserApiUseCase);

  UserApiState _state = UserCallInitial();

  UserApiState get state => _state;

  Future<void> saveUser({
    required String firebaseUserId,
    required String email,
    required String displayName,
    required String password,
    required bool isVerified,
    required File profilePhoto,
  }) async {
    _state = UserCallLoading();
    notifyListeners();

    try {
      final response = await storeUserApiUseCase.execute(
          firebaseUserId: firebaseUserId,
          email: email,
          displayName: displayName,
          password: password,
          isVerified: isVerified,
          profilePhoto: profilePhoto);
      _state = UserCallSuccess(response);
    } catch (e) {
      _state = UserCallFailure(e.toString());
    } finally{
      notifyListeners();
    }
  }
}
