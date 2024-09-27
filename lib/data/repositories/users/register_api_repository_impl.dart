import 'package:zeow_driver/data/models/driver_user_model.dart';
import 'package:zeow_driver/domain/repositories/register_user_api_repository.dart';

import '../../datasources/auth/register_user_api_service.dart';
import '../../responses/users/register_user_api_response.dart';

class RegisterApiRepositoryImpl implements RegisterUserApiRepository {
  final RegisterUserApiService apiService;

  RegisterApiRepositoryImpl(this.apiService);

  @override
  Future<RegisterUserApiResponse> registerUser(
      {required String name, required String email, required String password}) {
    return apiService.registerUser(
        name: name, email: email, password: password);
  }
}
