import 'dart:convert';

import 'package:zeow_driver/data/models/reset_password_model.dart';
import 'package:zeow_driver/data/responses/users/reset_password_api_response.dart';
import 'package:http/http.dart' as http;

import '../../responses/users/login_user_api_response.dart';

class ResetPasswordApiService {
  final String baseUrl =
      'http://192.168.100.15:8080/rahlat/rahlat/public/api'; // Replace with your endpoint

  Future<ResetPasswordApiResponse> resetPassword({
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    // var resetPassword = ResetPassword(email, password, passwordConfirm);
    final body = jsonEncode({
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirm,
    });

    final uri = Uri.parse('$baseUrl/password/reset');
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // Specify the content type as JSON
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final resetPasswordResponse =
            ResetPasswordApiResponse.successFromJson(jsonResponse);
        print('Success: ${resetPasswordResponse.message}');
        return resetPasswordResponse;
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        // Failure response
        final jsonResponse = jsonDecode(response.body);
        final resetPasswordResponse =
            ResetPasswordApiResponse.failureFromJson(jsonResponse);
        print('Failure: ${resetPasswordResponse.message}');
        print('Errors: ${resetPasswordResponse.errors?.password}');
        return resetPasswordResponse;
      } else {
        final jsonResponse = jsonDecode(response.body);
        // Handle unexpected responses
        print('Unexpected response: ${response.statusCode}');
        final resetPasswordResponse =
            ResetPasswordApiResponse.failureFromJson(jsonResponse);
        return resetPasswordResponse;
      }
    } catch (e) {
      // Handle any other exceptions like network issues, etc.
      print('Error: $e');
      final responseData = jsonDecode(e.toString());
      return ResetPasswordApiResponse.failureFromJson(responseData);
    }
  }
}
