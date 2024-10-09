import 'package:flutter/cupertino.dart';
import 'package:zeow_driver/data/models/firebase_user_model.dart';
import 'package:zeow_driver/data/models/trips/trip_model.dart';
import '../../../domain/repositories/trip_repository.dart';
import '../../../domain/usecases/trip/insert_trip_usecase.dart';
import '../../state/add_trip_state.dart';
import '../user/user_shared_prefs_view_model.dart';

class TripViewModel extends ChangeNotifier {
  final TripRepository tripRepository;
  final UserViewModel _userViewModel;

  final InsertTripUseCase insertTripUseCase;
  late AuthState _state = AddTripInitial();

  AuthState get state => _state;

  TripViewModel(
      this.insertTripUseCase, this._userViewModel, this.tripRepository);

  Future<void> insertTrip(TripModel trip) async {
    _state = AddTripLoading();
    notifyListeners();

    await _userViewModel.loadUser();
    FirebaseUserModel? user = _userViewModel.user;
    String? token = user?.token;

    try {
      final response = await insertTripUseCase.execute(trip, token);
      if (response.success) {
        _state = AddTripSuccess(
            success: response.success,
            message: response.message,
            data: response.data);
        notifyListeners();
      } else {
        final errors = response.message ?? ['An unknown error occurred'];
        _state = AddTripFailure(errors.toString());
        notifyListeners();
      }
    } catch (e) {
      _state = AddTripFailure('Error: $e');
      notifyListeners();
    }
  }
}
