import '../../data/responses/users/store_user_api_response.dart';

abstract class UserApiState {}

class UserCallInitial extends UserApiState {}

class UserCallLoading extends UserApiState {}

class UserCallSuccess extends UserApiState {
  final StoreUserApiResponse response;
  UserCallSuccess(this.response);
}

class UserCallFailure extends UserApiState {
  final String message;
  UserCallFailure(this.message);
}