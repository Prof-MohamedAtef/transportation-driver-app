import '../etities/trip.dart';

abstract class TripRepository {
  Future<bool> insertTrip(Trip trip);
}