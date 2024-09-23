import 'package:flutter/cupertino.dart';

import '../../../domain/etities/trip.dart';
import '../../../domain/usecases/trip/insert_trip_usecase.dart';

class TripViewModel extends ChangeNotifier {
  final InsertTripUseCase insertTripUseCase;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;

  TripViewModel(this.insertTripUseCase);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

  Future<void> insertTrip(Trip trip) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    bool success = await insertTripUseCase.call(trip);
    if (success) {
      _isSuccess = true;
    } else {
      _errorMessage = 'Failed to create trip';
      _isSuccess = false;
    }

    _isLoading = false;
    notifyListeners();
  }
}