import 'package:http/http.dart' as http;
import 'package:zeow_driver/data/responses/trips/add_trip_api_response.dart';
import 'dart:convert';
import '../../models/trips/trip_model.dart';

class TripApiService {
  final String _baseUrl = 'http://192.168.100.15:8080/rahlat/rahlat/public/api'; // Replace with your endpoint

  Future<TripResponse> insertTrip(TripModel trip, String? token) async {
    final url = Uri.parse('$_baseUrl/trips');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(trip.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Response Data: $responseData');
        return TripResponse.fromJson(responseData);
      } else {
        final responseData = jsonDecode(response.body);
        print('Response Data: $responseData');
        return TripResponse.fromJson(responseData);
      }
    } catch (e) {
      print('Response Data: $e');
      final responseData = jsonDecode(e.toString());
      return TripResponse.fromJson(responseData);
    }
  }
}