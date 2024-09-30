import 'package:flutter/cupertino.dart';
import 'package:zeow_driver/domain/repositories/reset_password_repository.dart';
import 'package:zeow_driver/domain/usecases/users/reset_password_use_case.dart';

import '../../state/reset_password_state.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final ResetPasswordUseCase _resetPasswordUseCase;

  late ResetPasswordAuthState _state = ResetPasswordStateInitial();

  ResetPasswordAuthState get state => _state;

  ResetPasswordViewModel(this._resetPasswordUseCase);

  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _errorMessage = '';

  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get errorMessage => _errorMessage;

  // Email validation
  bool isValidEmail(String email) {
    return email.contains('@');
  }

  // Password validation (minimum 6 characters)
  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  // Confirm password validation
  bool isPasswordConfirmed() {
    return _password == _confirmPassword;
  }

  // Update email
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  // Update password
  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  // Update confirm password
  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  // Validate form and return error message if invalid
  bool validateForm() {
    if (_email.isEmpty || !isValidEmail(_email)) {
      _errorMessage = 'Please enter a valid email address';
      notifyListeners();
      return false;
    }
    if (_password.isEmpty || !isValidPassword(_password)) {
      _errorMessage = 'Password must be at least 6 characters long';
      notifyListeners();
      return false;
    }
    if (!isPasswordConfirmed()) {
      _errorMessage = 'Passwords do not match';
      notifyListeners();
      return false;
    }
    _errorMessage = ''; // Clear error if no issues
    notifyListeners();
    return true;
  }

  Future<void> resetPassword({
    required String email,
    required String password,
    required String passwordConfirm,
  }) async  {
    if (validateForm()) {
      _state = ResetPasswordStateLoading();
      notifyListeners();

      try{
        final response = await _resetPasswordUseCase.execute(email: email, password: password, passwordConfirm: password);
        if (response.status!) {
          _state =
              ResetPasswordStateSuccess(message: response.message);
          notifyListeners();
        } else {
          final errors = response.message ?? ['An unknown error occurred'];
          _state = ResetPasswordFailure(errors.toString());
          notifyListeners();
        }
      }catch(e){
        _state = ResetPasswordFailure('Error: $e');
        notifyListeners();
      }
    }
  }
}
