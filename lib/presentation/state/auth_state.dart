import '../../data/models/firebase_user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String? token;
  final String? tokenType;
  final int? isVerified;
  final FirebaseUserModel? user;

  AuthSuccess({this.token, this.tokenType, this.user, this.isVerified});
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
  factory AuthFailure.canceledByUser() => AuthFailure('Sign-in canceled by user');
  factory AuthFailure.serverError(String error) => AuthFailure('Server error: $error');
}

class AuthSignOutSuccess extends AuthState {}
class AuthSignOutFailure extends AuthState {
  final String message;
  AuthSignOutFailure(this.message);
}