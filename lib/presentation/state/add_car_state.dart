import 'package:zeow_driver/data/responses/cars/add_cars_response.dart';

abstract class AddCarsApiState {}

class AddCarCallInitial extends AddCarsApiState {}

class AddCarCallLoading extends AddCarsApiState {}

class AddCarCallSuccess extends AddCarsApiState {
  final AddCarsApiResponse response;
  AddCarCallSuccess(this.response);
}

class AddCarCallFailure extends AddCarsApiState {
  final String message;
  AddCarCallFailure(this.message);
  factory AddCarCallFailure.canceledByUser() => AddCarCallFailure('Car Call canceled by user');
  factory AddCarCallFailure.serverError(String error) => AddCarCallFailure('Server error: $error');
}
