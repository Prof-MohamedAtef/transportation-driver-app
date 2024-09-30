import 'package:zeow_driver/data/responses/users/reset_password_api_response.dart';
import 'package:zeow_driver/domain/repositories/reset_password_repository.dart';

class ResetPasswordUseCase {
  final ResetPasswordApiRepository resetPasswordRepository;

  ResetPasswordUseCase(this.resetPasswordRepository);

  Future<ResetPasswordApiResponse> execute({
    required String email,
    required String password,
    required String passwordConfirm,
  }) {
    return resetPasswordRepository.resetPassword(email: email, password: password, passwordConfirm: passwordConfirm);
  }
}