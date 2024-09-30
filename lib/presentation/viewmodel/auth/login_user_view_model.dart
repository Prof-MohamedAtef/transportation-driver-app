import 'package:flutter/widgets.dart';
import 'package:zeow_driver/domain/usecases/users/login_user_api_use_case.dart';
import '../../../data/models/firebase_user_model.dart';
import '../../../data/repositories/firebase/auth_repository.dart';
import '../../state/auth_state.dart';
import '../user/user_shared_prefs_view_model.dart';

class LoginAuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  final UserViewModel _userViewModel;

  final LoginUserApiUseCase useCase;

  FirebaseUserModel? _user;

  FirebaseUserModel? get user => _user;

  late AuthState _state = AuthInitial();

  AuthState get state => _state;

  LoginAuthViewModel(this.useCase, this._userViewModel, this._authRepository);

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    _state = AuthLoading();
    notifyListeners();

    try {
      final response = await useCase.execute(email: email, password: password);
      if (response.success) {
        _state =
            AuthSuccess(token: response.token, tokenType: response.token_type);
        await _userViewModel.saveUser(FirebaseUserModel(token: response.token));
        notifyListeners();
      } else {
        final errors = response.message ?? ['An unknown error occurred'];
        _state = AuthFailure(errors.toString());
        notifyListeners();
      }
    } catch (e) {
      _state = AuthFailure('Error: $e');
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    _state = AuthLoading();
    notifyListeners();

    try {
      final result = await _authRepository.signInWithGoogle();
      result.fold(
        (failure) {
          _state = AuthFailure(failure.message);
          notifyListeners();
        },
        (firebaseUser) async {
          if (firebaseUser != null) {
            _user = FirebaseUserModel.fromFirebaseUser(firebaseUser);
            await _userViewModel.saveUser(_user!);
            signUpGoogleAccount(_user);
            _state = AuthSuccess(user: _user);
            notifyListeners();
          } else {
            _state = AuthFailure("Google Sign-In failed");
            notifyListeners();
          }
        },
      );
    } catch (e) {
      _state = AuthFailure(e.toString());
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _state = AuthLoading();
    notifyListeners();

    try {
      await _authRepository.signOut();
      _user = null; // Clear user data
      await _userViewModel.clearUser();
      _state = AuthSignOutSuccess();
    } catch (e) {
      _state = AuthSignOutFailure(e.toString());
    }

    notifyListeners();
  }

  void signUpGoogleAccount(FirebaseUserModel? user) {

  }
}