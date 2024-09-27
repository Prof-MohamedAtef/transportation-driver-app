import 'dart:io';

import '../../data/models/driver_user_model.dart';
import '../../data/responses/users/store_user_api_response.dart';

abstract class StoreUserApiRepository {
  Future<StoreUserApiResponse> saveUser({
    required String firebaseUserId,
    required String email,
    required String displayName,
    required String password,
    required bool isVerified,
    required File profilePhoto,
  });
}