import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zeow_driver/data/models/car/car_model.dart';
import '../../../domain/usecases/cars/add_car_use_case.dart';
import '../../state/add_car_state.dart';
import '../../state/car_types_state.dart';

class AddCarViewModel extends ChangeNotifier {
  final AddCarUseCase addCarUseCase;

  AddCarsApiState _state = AddCarCallInitial();
  AddCarsApiState get state => _state;

  AddCarViewModel(this.addCarUseCase);

  Future<void> addCar({
    required String firebaseUserId,
    required String vehicleTypeId,
    required File carLicensePhoto,
    required File driverLicensePhoto,
    required File nationalIdFrontPhoto,
    required File nationalIdBackPhoto,
    required File carPhoto,
  }) async {
    _state = AddCarCallLoading();
    notifyListeners();

    try {
      final response = await addCarUseCase.execute(
        firebaseUserId: firebaseUserId,
        vehicleTypeId: vehicleTypeId,
        carLicensePhoto: carLicensePhoto,
        driverLicensePhoto: driverLicensePhoto,
        nationalIdFrontPhoto: nationalIdFrontPhoto,
        nationalIdBackPhoto: nationalIdBackPhoto,
        carPhoto: carPhoto,
      );
      _state = AddCarCallSuccess(response);
    } catch (e) {
      _state = AddCarCallFailure.serverError(e.toString());
    } finally {
      notifyListeners();
    }
  }
}