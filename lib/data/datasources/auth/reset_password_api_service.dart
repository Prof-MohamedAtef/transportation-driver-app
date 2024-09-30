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
    var resetPassword = ResetPassword(email, password, passwordConfirm);
    final uri = Uri.parse('$baseUrl/password/reset');
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          // Specify the content type as JSON
        },
        body: jsonEncode(resetPassword.toJson()),
      );

      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response.body);
          return ResetPasswordApiResponse.successFromJson(responseData);
        } on FormatException catch (e) {
          final responseData = jsonDecode(response.body);
          return ResetPasswordApiResponse.failureFromJson(responseData);
        }
      } else {
        final responseData = jsonDecode(response.body);
        return ResetPasswordApiResponse.failureFromJson(responseData);
      }
    } catch (e) {
      // Handle any other exceptions like network issues, etc.
      print('Error: $e');
      final responseData = jsonDecode(e.toString());
      return ResetPasswordApiResponse.failureFromJson(responseData);
    }
  }
}