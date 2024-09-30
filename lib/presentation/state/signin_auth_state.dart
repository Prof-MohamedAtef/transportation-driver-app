import '../../data/models/firebase_user_model.dart';

abstract class SignInUserState {}

class SignInUserInitial extends SignInUserState {}

class SignInUserLoading extends SignInUserState {}

class SignInUserSuccess extends SignInUserState {
  final String? token;
  final String? tokenType;

  SignInUserSuccess(this.token, this.tokenType);
}

class SignInUserFailure extends SignInUserState {
  final String errorMessage;

  SignInUserFailure(this.errorMessage);
}