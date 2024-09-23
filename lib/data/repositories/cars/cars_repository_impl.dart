import 'dart:io';

import 'package:zeow_driver/data/responses/cars/add_cars_response.dart';

import '../../../domain/repositories/cars_repository.dart';
import '../../datasources/cars/get_cars_api_service.dart';
import '../../models/car/car_model.dart';

class CarRepositoryImpl implements CarRepository {
  final CarsApiService carsApiService;

  CarRepositoryImpl(this.carsApiService);

  @override
  Future<List<Car>> getCarTypes() async {
    return await carsApiService.fetchCarTypes();
  }

  @override
  Future<AddCarsApiResponse> addCar(
      String firebaseUserId,
      String vehicleTypeId,
      File carLicensePhoto,
      File driverLicensePhoto,
      File nationalIdFrontPhoto,
      File nationalIdBackPhoto,
      File carPhoto) async {
    return await carsApiService.addCar(
      firebaseUserId: firebaseUserId,
      vehicleTypeId: vehicleTypeId,
      carLicensePhoto: carLicensePhoto,
      driverLicensePhoto: driverLicensePhoto,
      nationalIdFrontPhoto: nationalIdFrontPhoto,
      nationalIdBackPhoto: nationalIdBackPhoto,
      carPhoto: carPhoto,
    );
  }
}
