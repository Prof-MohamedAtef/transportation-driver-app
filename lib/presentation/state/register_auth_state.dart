abstract class RegisterUserState {}

class RegisterUserInitial extends RegisterUserState {}

class RegisterUserLoading extends RegisterUserState {}

class RegisterUserSuccess extends RegisterUserState {
  final String token;
  final String tokenType;

  RegisterUserSuccess(this.token, this.tokenType);
}

class RegisterUserFailure extends RegisterUserState {
  final List<String> errors;

  RegisterUserFailure(this.errors);
}