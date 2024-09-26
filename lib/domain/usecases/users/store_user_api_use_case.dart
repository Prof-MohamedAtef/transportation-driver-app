import 'dart:io';

import 'package:zeow_driver/domain/repositories/user_api_repository.dart';

import '../../../data/responses/users/store_user_api_response.dart';

class StoreUserApiUseCase {
  final UserApiRepository userApiRepository;

  StoreUserApiUseCase(this.userApiRepository);

  Future<StoreUserApiResponse> execute({
    required String firebaseUserId,
    required String email,
    required String displayName,
    required String password,
    required bool isVerified,
    required File profilePhoto,
  }) {
    return userApiRepository.saveUser(
        firebaseUserId: firebaseUserId,
        email: email,
        displayName: displayName,
        password: password,
        isVerified: isVerified,
        profilePhoto: profilePhoto);
  }
}
