import 'package:zeow_driver/data/responses/users/login_user_api_response.dart';
import 'package:zeow_driver/domain/repositories/login_user_api_repository.dart';

class LoginUserApiUseCase {

  final LoginUserApiRepository loginApiRepository;

  LoginUserApiUseCase(this.loginApiRepository);

  Future<LoginUserApiResponse> execute({
    required String email,
    required String password,
  }) {
    return loginApiRepository.login(email: email, password: password);
  }
}