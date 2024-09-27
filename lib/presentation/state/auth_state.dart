import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/firebase_user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final FirebaseUserModel user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
  factory AuthFailure.canceledByUser() => AuthFailure('Sign-in canceled by user');
  factory AuthFailure.serverError(String error) => AuthFailure('Server error: $error');
}