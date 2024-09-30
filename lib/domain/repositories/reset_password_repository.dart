import 'package:zeow_driver/data/responses/users/reset_password_api_response.dart';

abstract class ResetPasswordApiRepository{
  Future<ResetPasswordApiResponse> resetPassword({
    required String email,
    required String password,
    required String passwordConfirm,
  });
}