import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/auth_state.dart';
import '../user/user_shared_prefs_view_model.dart';
import '/data/models/user_model.dart';
import '../../../data/repositories/firebase/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserViewModel _userViewModel;  // Now it's injected

  AuthViewModel(this._authRepository, this._userViewModel);  // Inject UserViewModel

  AuthState _state = AuthInitial();

  AuthState get state => _state;
  UserModel? _user;

  UserModel? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> signIn(String email, String password, BuildContext context) async {
    _state = AuthLoading();
    notifyListeners();
    try {
      UserModel? user = await _authRepository.signInWithEmail(email, password);
      if (user != null) {
        _state = AuthSuccess(user);
        // Save the user data to SharedPreferences via UserViewModel
        await _userViewModel.saveUser(user);
      }
    } catch (e) {
      _state = AuthFailure(e.toString());
    }
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    _state = AuthLoading();
    notifyListeners();
    try {
      UserModel? user = await _authRepository.signUpWithEmail(email, password);
      _state = AuthSuccess(user!);
    } catch (e) {
      _state = AuthFailure(e.toString());
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authRepository.signOut(); // remove user from Firebase
    await _userViewModel.clearUser(); // remove user from SharedPrefs
    _state = AuthInitial();
    _user = null;
    notifyListeners();
  }

  // Google Sign-In
  Future<void> signInWithGoogle() async {
    _state = AuthLoading();
    notifyListeners();
    try {
      // signInWithGoogle() returns Either<AuthFailure, User?>

      final result = await _authRepository.signInWithGoogle();
      result.fold(
        (failure) {
          // Handle the failure case
          print(failure.message);
          _state = AuthFailure(failure.message); // or a custom error message
        },
        (firebaseUser) async {
          // Handle the success case
          if (firebaseUser != null) {
            // Convert Firebase User to UserModel
            _user = UserModel.fromFirebaseUser(firebaseUser);
            await _userViewModel.saveUser(_user!);
            _state = AuthSuccess(_user!); // Use the updated AuthSuccess
          } else {
            _state = AuthFailure("Google Sign-In failed");
          }
        },
      );
    } catch (e) {
      _state = AuthFailure(e.toString());
      print(e.toString());
    }
    notifyListeners();
  }

  void fetchCurrentUser() {
    _user = _authRepository.getCurrentUser();
    notifyListeners();
  }
}
