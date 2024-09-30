import 'package:flutter/cupertino.dart';
import 'package:zeow_driver/domain/usecases/users/register_user_api_use_case.dart';
import '../../state/register_auth_state.dart';
import '../user/user_shared_prefs_view_model.dart';

class RegisterAuthViewModel extends ChangeNotifier {
  final RegisterUserApiUseCase useCase;
  final UserViewModel userViewModel; // Now it's injected

  late RegisterUserState _state = RegisterUserInitial();

  RegisterUserState get state => _state;

  RegisterAuthViewModel(this.useCase, this.userViewModel);

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
        _state = RegisterUserSuccess();
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

  // Method to reset state to initial
  void resetState() {
    _state = RegisterUserInitial();  // Or whichever is the initial state
    notifyListeners(); // Notify UI to refresh
  }
}
