import '../../../data/responses/users/register_user_api_response.dart';
import '../../repositories/register_user_api_repository.dart';

class RegisterUserApiUseCase {
  final RegisterUserApiRepository userApiRepository;

  RegisterUserApiUseCase(this.userApiRepository);

  Future<RegisterUserApiResponse> execute({
    required String name,
    required String email,
    required String password,
  }) {
    return userApiRepository.registerUser(name: name, email: email, password: password);
  }
}
