import '../../etities/trip.dart';
import '../../repositories/trip_repository.dart';

class InsertTripUseCase {
  final TripRepository repository;

  InsertTripUseCase(this.repository);

  Future<bool> call(Trip trip) async {
    return await repository.insertTrip(trip);
  }
}