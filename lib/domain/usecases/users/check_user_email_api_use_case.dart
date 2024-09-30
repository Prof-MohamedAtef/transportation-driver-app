import 'package:zeow_driver/data/responses/users/check_email_response.dart';
import 'package:zeow_driver/domain/repositories/check_user_email_repository.dart';

class CheckUserEmailApiUseCase {

  final CheckUserEmailRepository checkEmailApiRepository;

  CheckUserEmailApiUseCase(this.checkEmailApiRepository);

  Future<CheckUserEmailResponse> execute({
    required String email,
  }) {
    return checkEmailApiRepository.checkEmail(email: email);
  }
}