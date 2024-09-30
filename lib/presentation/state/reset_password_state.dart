abstract class ResetPasswordAuthState {}

class ResetPasswordStateInitial extends ResetPasswordAuthState {}

class ResetPasswordStateLoading extends ResetPasswordAuthState {}

class ResetPasswordStateSuccess extends ResetPasswordAuthState {
  final String? message;
  ResetPasswordStateSuccess({this.message});
}

class ResetPasswordFailure extends ResetPasswordAuthState {
  final String message;
  ResetPasswordFailure(this.message);
  factory ResetPasswordFailure.canceledByUser() => ResetPasswordFailure('Sign-in canceled by user');
  factory ResetPasswordFailure.serverError(String error) => ResetPasswordFailure('Server error: $error');
}
