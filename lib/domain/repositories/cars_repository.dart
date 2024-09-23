import 'dart:io';

import '../../data/models/car/car_model.dart';
import '../../data/responses/cars/add_cars_response.dart';

abstract class CarRepository {
  Future<List<Car>> getCarTypes();
  Future<AddCarsApiResponse> addCar(
      String firebaseUserId,
      String vehicleTypeId,
      File carLicensePhoto,
      File driverLicensePhoto,
      File nationalIdFrontPhoto,
      File nationalIdBackPhoto,
      File carPhoto,
      );
}