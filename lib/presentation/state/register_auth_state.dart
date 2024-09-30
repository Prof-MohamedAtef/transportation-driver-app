abstract class RegisterUserState {}

class RegisterUserInitial extends RegisterUserState {}

class RegisterUserLoading extends RegisterUserState {}

class RegisterUserSuccess extends RegisterUserState {
  RegisterUserSuccess();
}

class RegisterUserFailure extends RegisterUserState {
  final List<String> errors;

  RegisterUserFailure(this.errors);
}