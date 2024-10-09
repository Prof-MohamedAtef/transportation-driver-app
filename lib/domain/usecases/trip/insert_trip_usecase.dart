import 'package:zeow_driver/data/models/trips/trip_model.dart';
import '../../../data/responses/trips/add_trip_api_response.dart';
import '../../repositories/trip_repository.dart';

class InsertTripUseCase {
  final TripRepository repository;
  InsertTripUseCase(this.repository);

  Future<TripResponse> execute(TripModel trip, String? token) async {
    return await repository.insertTrip(trip, token);
  }
}