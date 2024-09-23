import 'dart:io';

import '../../../data/responses/cars/add_cars_response.dart';
import '../../repositories/cars_repository.dart';

class AddCarUseCase {
  final CarRepository repository;

  AddCarUseCase(this.repository);

  Future<AddCarsApiResponse> execute({
    required String firebaseUserId,
    required String vehicleTypeId,
    required File carLicensePhoto,
    required File driverLicensePhoto,
    required File nationalIdFrontPhoto,
    required File nationalIdBackPhoto,
    required File carPhoto,
  }) async {
    return await repository.addCar(
      firebaseUserId,
      vehicleTypeId,
      carLicensePhoto,
      driverLicensePhoto,
      nationalIdFrontPhoto,
      nationalIdBackPhoto,
      carPhoto,
    );
  }
}