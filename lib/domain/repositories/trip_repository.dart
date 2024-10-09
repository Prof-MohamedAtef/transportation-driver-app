import 'package:zeow_driver/data/models/trips/trip_model.dart';
import '../../data/responses/trips/add_trip_api_response.dart';

abstract class TripRepository {
  Future<TripResponse> insertTrip(TripModel trip, String? token);
}