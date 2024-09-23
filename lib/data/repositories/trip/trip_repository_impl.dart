import '../../../domain/etities/trip.dart';
import '../../../domain/repositories/trip_repository.dart';
import '../../datasources/trip/trip_api_service.dart';
import '../../models/trips/trip_model.dart';

class TripRepositoryImpl implements TripRepository {
  final TripApiService apiService;

  TripRepositoryImpl(this.apiService);

  @override
  Future<bool> insertTrip(Trip trip) async {
    final tripModel = TripModel(
      pickUpLatitude: trip.pickUpLatitude,
      pickUpLongitude: trip.pickUpLongitude,
      pickUpCity: trip.pickUpCity,
      destinationLatitude: trip.destinationLatitude,
      destinationLongitude: trip.destinationLongitude,
      destinationCity: trip.destinationCity,
      departureDate: trip.departureDate,
      departureTime: trip.departureTime,
      arrivalDate: trip.arrivalDate,
      arrivalTime: trip.arrivalTime,
      carId: trip.carId,
      numOfSeats: trip.numOfSeats,
      tripPrice: trip.tripPrice,
      frontChairPrice: trip.frontChairPrice,
    );

    return await apiService.insertTrip(tripModel);
  }
}