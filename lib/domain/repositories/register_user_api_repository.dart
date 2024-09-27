import '../../data/responses/users/register_user_api_response.dart';

abstract class RegisterUserApiRepository{
  Future<RegisterUserApiResponse> registerUser({
    required String name,
    required String email,
    required String password,
  });
}