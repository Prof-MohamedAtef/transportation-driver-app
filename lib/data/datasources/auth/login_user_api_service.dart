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
        },
        body: jsonEncode(driver.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 422) {
        if(response.statusCode == 200){
          try {
            final responseData = jsonDecode(response.body);
            print('Response Data: $responseData');
            return LoginUserApiResponse.successFromJson(responseData);
          } on FormatException catch (e) {
            // If decoding fails, catch the FormatException
            print('Error: Invalid JSON format. ${e.message}');
            // Handle the non-JSON response here, possibly log it for debugging
            print('Raw response: ${response.body}');
          }
        }else {
          // Handle other response codes (e.g., 400, 404, 500)
          print('Error: Server returned ${response.statusCode}');
          print('Response Body: ${response.body}');
        }
        // Parse the response body to RegisterUserApiResponse
        final responseData = jsonDecode(response.body);
        return LoginUserApiResponse.successFromJson(responseData);
      } else {
        final responseData = jsonDecode(response.body);
        return LoginUserApiResponse.failureFromJson(responseData);
      }
    } catch (e) {
      // Handle any other exceptions like network issues, etc.
      print('Error: $e');
      final responseData = jsonDecode(e.toString());
      return LoginUserApiResponse.failureFromJson(responseData);
    }
  }
}
