import 'package:zeow_driver/data/datasources/auth/login_user_api_service.dart';
import 'package:zeow_driver/data/responses/users/login_user_api_response.dart';
import 'package:zeow_driver/domain/repositories/login_user_api_repository.dart';

class LoginApiRepositoryImpl implements LoginUserApiRepository {

  final LoginUserApiService loginService;
  LoginApiRepositoryImpl(this.loginService);

  @override
  Future<LoginUserApiResponse> login({required String email, required String password}) {
    return loginService.signInUser(email: email, password: password);
  }


}