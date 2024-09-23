import '../../data/models/car/car_model.dart';

abstract class CarsApiState {}

class CarCallInitial extends CarsApiState {}

class CarCallLoading extends CarsApiState {}

class CarCallSuccess extends CarsApiState {
  final List<Car> cars;
  CarCallSuccess(this.cars);
}

class CarCallFailure extends CarsApiState {
  final String message;
  CarCallFailure(this.message);
  factory CarCallFailure.canceledByUser() => CarCallFailure('Car Call canceled by user');
  factory CarCallFailure.serverError(String error) => CarCallFailure('Server error: $error');
}
