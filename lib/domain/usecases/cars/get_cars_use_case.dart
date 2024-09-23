import 'dart:io';

import '../../../data/models/car/car_model.dart';
import '../../../data/responses/cars/add_cars_response.dart';
import '../../repositories/cars_repository.dart';

class GetCarTypesUseCase {
  final CarRepository carRepository;

  GetCarTypesUseCase(this.carRepository);

  Future<List<Car>> call() async {
    return await carRepository.getCarTypes();
  }
}