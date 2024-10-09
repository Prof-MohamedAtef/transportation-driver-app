import '../../../domain/repositories/trip_repository.dart';
import '../../datasources/trip/trip_api_service.dart';
import '../../models/trips/trip_model.dart';
import '../../responses/trips/add_trip_api_response.dart';

class TripRepositoryImpl implements TripRepository {
  final TripApiService apiService;

  TripRepositoryImpl(this.apiService);

  @override
  Future<TripResponse> insertTrip(TripModel trip, String? token){
    return apiService.insertTrip(trip, token);
  }
}