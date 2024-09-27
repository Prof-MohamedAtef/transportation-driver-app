import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/driver_user_model.dart';
import '../../responses/users/register_user_api_response.dart';

class RegisterUserApiService{
  final String baseUrl =
      'http://192.168.100.15:8080/rahlat/rahlat/public/api'; // Replace with your endpoint

  Future<RegisterUserApiResponse> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    var driver = Driver(name: name, email: email, password: password);
    final uri = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',  // Specify the content type as JSON
        },
        body: jsonEncode(driver.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 422) {
        // Parse the response body to RegisterUserApiResponse
        final responseData = jsonDecode(response.body);
        return RegisterUserApiResponse.fromJson(responseData);
      } else {
        throw Exception('Failed to register user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error registering user: $e');
    }
  }
}