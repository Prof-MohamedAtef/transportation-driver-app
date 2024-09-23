import 'package:flutter/cupertino.dart';

import '../../../data/models/car/car_model.dart';
import '../../../domain/usecases/cars/get_cars_use_case.dart';
import '../../state/auth_state.dart';
import '../../state/car_types_state.dart';

class CarViewModel extends ChangeNotifier {
  final GetCarTypesUseCase getCarTypesUseCase;

  List<Car> cars = [];
  CarsApiState _state = CarCallInitial();

  CarsApiState get state => _state;

  CarViewModel(this.getCarTypesUseCase);

  Future<void> fetchCarTypes() async {
    _state = CarCallLoading();
    notifyListeners();

    try {
      cars = await getCarTypesUseCase();
      _state = CarCallSuccess(cars);
    } catch (e) {
      _state = CarCallFailure(e.toString());
    } finally {
      notifyListeners();
    }
  }
}