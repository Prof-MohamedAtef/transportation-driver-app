import '../../data/responses/trips/add_trip_api_response.dart';

abstract class AuthState {}

class AddTripInitial extends AuthState {}

class AddTripLoading extends AuthState {}

class AddTripSuccess extends AuthState {
  final bool? success;
  final String? message;
  final Trip? data;


  AddTripSuccess({this.success, this.message, this.data});
}

class AddTripFailure extends AuthState {
  final String message;

  AddTripFailure(this.message);
  factory AddTripFailure.canceledByUser() => AddTripFailure('Failed to Add Trip');
  factory AddTripFailure.serverError(String error) => AddTripFailure('Server error: $error');
}