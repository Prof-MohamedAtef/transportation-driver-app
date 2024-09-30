import 'package:zeow_driver/data/responses/users/check_email_response.dart';

abstract class CheckUserEmailRepository {
  Future<CheckUserEmailResponse> checkEmail({required String email});
}
