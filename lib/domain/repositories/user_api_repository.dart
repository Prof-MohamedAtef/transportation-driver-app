import 'dart:io';

import '../../data/responses/users/store_user_api_response.dart';

abstract class UserApiRepository {
  Future<StoreUserApiResponse> saveUser({
    required String firebaseUserId,
    required String email,
    required String displayName,
    required String password,
    required bool isVerified,
    required File profilePhoto,
  });
}