abstract class VerifyDriverState {}

class VerifyDriverInitial extends VerifyDriverState {}

class VerifyDriverLoading extends VerifyDriverState {}

class VerifyDriverSuccess extends VerifyDriverState {
  // final AddCarsApiResponse response;
  // VerifyDriverSuccess(this.response);
}

class VerifyDriverFailure extends VerifyDriverState {
  final String message;
  VerifyDriverFailure(this.message);
  factory VerifyDriverFailure.canceledByUser() => VerifyDriverFailure('Car Call canceled by user');
  factory VerifyDriverFailure.serverError(String error) => VerifyDriverFailure('Server error: $error');
}