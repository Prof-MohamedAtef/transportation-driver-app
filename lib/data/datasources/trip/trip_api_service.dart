import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/trips/trip_model.dart';

class TripApiService {
  final String _baseUrl = 'http://192.168.100.15:8080/rahlat/rahlat/public/api'; // Replace with your endpoint

  Future<bool> insertTrip(TripModel trip) async {
    final url = Uri.parse('$_baseUrl/trips');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(trip.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Failed to insert trip: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}