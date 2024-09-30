import 'package:zeow_driver/data/datasources/auth/reset_password_api_service.dart';
import 'package:zeow_driver/data/responses/users/reset_password_api_response.dart';

import '../../../domain/repositories/reset_password_repository.dart';

class ResetPasswordRepositoryImpl extends ResetPasswordApiRepository {

  final ResetPasswordApiService resetPasswordService;
  ResetPasswordRepositoryImpl(this.resetPasswordService);

  @override
  Future<ResetPasswordApiResponse> resetPassword({required String email, required String password, required String passwordConfirm}) {
    return resetPasswordService.resetPassword(email: email, password: password, passwordConfirm: passwordConfirm);
  }

}