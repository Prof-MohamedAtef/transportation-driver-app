import 'package:zeow_driver/data/responses/users/login_user_api_response.dart';

abstract class LoginUserApiRepository{
  Future<LoginUserApiResponse> login({
    required String email,
    required String password,
  });
}