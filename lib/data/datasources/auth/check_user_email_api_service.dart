import 'dart:convert';

import 'package:zeow_driver/data/models/check_email_model.dart';
import 'package:zeow_driver/data/responses/users/check_email_response.dart';
import 'package:http/http.dart' as http;

import '../../responses/users/login_user_api_response.dart';
import 'login_user_api_service.dart';

// class CheckUserEmailApiService {
//
//   final LoginUserApiService loginService;
//
//   CheckUserEmailApiService(this.loginService);
//
//   final String baseUrl =
//       'http://192.168.100.15:8080/rahlat/rahlat/public/api'; // Replace with your endpoint
//
//   Future<void> checkEmail({required String email}) async {
//     var _email = Email(email);
//     final uri = Uri.parse('$baseUrl/check-email');
//
//     try {
//       final response = await http.post(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',  // Specify the content type as JSON
//         },
//         body: jsonEncode(_email.toJson()),
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         print('Response Data: $responseData');
//
//       } else if (response.statusCode == 500) {
//         final responseData = jsonDecode(response.body);
//         print('Response Data: $responseData');
//         loginService.signInUser(email: email, password: password)
//       }
//     } catch (e) {
//       // Handle any other exceptions like network issues, etc.
//       print('Error: $e');
//       final responseData = jsonDecode(e.toString());
//       throw ErrorMessage.fromJson(responseData);
//     }
//
//   }
// }
