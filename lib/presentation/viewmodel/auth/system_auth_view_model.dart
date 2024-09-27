import 'package:flutter/cupertino.dart';
import 'package:zeow_driver/domain/usecases/users/register_user_api_use_case.dart';
import '../../state/register_auth_state.dart';
import '../../state/signin_auth_state.dart';
import '../user/user_shared_prefs_view_model.dart';

class SystemAuthViewModel extends ChangeNotifier {
  final RegisterUserApiUseCase useCase;
  final UserViewModel userViewModel;  // Now it's injected

  late RegisterUserState _state = RegisterUserInitial();
  RegisterUserState get state => _state;

  SystemAuthViewModel(this.useCase, this.userViewModel);


  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    _state = RegisterUserLoading();
    notifyListeners();

    try {
      final response = await useCase.execute(
        name: name,
        email: email,
        password: password,
      );

      if (response.success) {
        _state = RegisterUserSuccess(response.token!, response.tokenType!!);
      } else {
        final errors = response.errors?.email ?? ['An unknown error occurred'];
        _state = RegisterUserFailure(errors);
      }
    } catch (e) {
      _state = RegisterUserFailure(['Error: $e']);
    } finally {
      notifyListeners();
    }
  }
}