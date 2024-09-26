import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../responses/users/store_user_api_response.dart';

class StoreUserApiService {
  final String baseUrl =
      'http://192.168.100.15:8080/rahlat/rahlat/public/api'; // Replace with your endpoint

  Future<StoreUserApiResponse> saveUser({
    required String firebaseUserId,
    required String email,
    required String displayName,
    required String password,
    required bool isVerified,
    required File profilePhoto,
  }) async {
    final uri = Uri.parse('$baseUrl/users');

    try {
      var request = http.MultipartRequest('POST', uri);

      // Add fields
      request.fields['firebaseUserId'] = firebaseUserId;
      request.fields['email'] = email;
      request.fields['displayName'] = displayName;
      request.fields['password'] = password;
      request.fields['isVerified'] = isVerified.toString();

      // Add the profile photo file
      var profilePhotoFile = await http.MultipartFile.fromPath(
        'profilePhoto',
        profilePhoto.path,
      );
      request.files.add(profilePhotoFile);

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Handle the response
      if (response.statusCode == 201) {
        // Success: parse the response and return
        return StoreUserApiResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 422) {
        // Validation error: throw an exception with detailed error message
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message'] ?? 'Validation failed');
      } else {
        // Handle unexpected errors
        throw Exception('Failed to save user: ${response.statusCode}');
      }
    } catch (e) {
      // Catch and rethrow any exceptions
      print('Error: $e');
      throw Exception('An error occurred while saving the user');
    }
  }
}
