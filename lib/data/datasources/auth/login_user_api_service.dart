import 'dart:convert';

import 'package:zeow_driver/data/responses/users/login_user_api_response.dart';
import 'package:http/http.dart' as http;
import '../../models/driver_user_model.dart';

class LoginUserApiService {
  final String baseUrl =
      'http://192.168.100.15:8080/rahlat/rahlat/public/api'; // Replace with your endpoint

  Future<LoginUserApiResponse> signInUser({
    required String email,
    required String password,
  }) async {
    var driver = Driver(email: email, password: password);
    final uri = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',  // Specify the content type as JSON
          'Accept': 'application/json'
        },
        body: jsonEncode(driver.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Response Data: $responseData');
        return LoginUserApiResponse.successFromJson(responseData);
      } else if (response.statusCode == 422) {
        print('Validation error: $responseData');
        return LoginUserApiResponse.failureFromJson(responseData);
      } else {
        print('Unexpected error: ${response.statusCode}');
        return LoginUserApiResponse.failureFromJson(responseData);
      }

    } catch (e) {
      print('Error: $e');
      return LoginUserApiResponse.failureFromJson({
        'success': false,
        'message': 'An unexpected error occurred',
        'errors': {}
      });
    }
  }
}
