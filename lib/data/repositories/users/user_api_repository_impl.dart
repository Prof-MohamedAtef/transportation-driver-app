import 'dart:io';
import 'package:zeow_driver/data/responses/users/store_user_api_response.dart';
import 'package:zeow_driver/domain/repositories/store_user_api_repository.dart';

import '../../datasources/users/store_user_api_service.dart';

class UserApiRepositoryImpl implements StoreUserApiRepository {
  final StoreUserApiService apiService;

  UserApiRepositoryImpl(this.apiService);

  @override
  Future<StoreUserApiResponse> saveUser(
      {required String firebaseUserId,
      required String email,
      required String displayName,
      required String password,
      required bool isVerified,
      required File profilePhoto}) {
    return apiService.saveUser(
        firebaseUserId: firebaseUserId,
        email: email,
        displayName: displayName,
        password: password,
        isVerified: isVerified,
        profilePhoto: profilePhoto);
  }
}
