import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'dart:convert';

import '../../models/car/car_model.dart';
import '../../responses/cars/add_cars_response.dart';

class CarsApiService {
  final String _baseUrl = 'http://192.168.100.15:8080/rahlat/rahlat/public/api';

  Future<List<Car>> fetchCarTypes() async {
    final url = '$_baseUrl/getCars';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> carListJson = json.decode(response.body);
      // Convert the list of JSON objects into a list of Car objects
      return carListJson.map((json) => Car.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load car types');
    }
  }

  Future<AddCarsApiResponse> addCar({
    required String firebaseUserId,
    required String vehicleTypeId,
    required File carLicensePhoto,
    required File driverLicensePhoto,
    required File nationalIdFrontPhoto,
    required File nationalIdBackPhoto,
    required File carPhoto,
  }) async {
    final url = Uri.parse('$_baseUrl/addCar');

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add text fields
    request.fields['firebaseUserId'] = firebaseUserId;
    request.fields['vehicleTypeId'] = vehicleTypeId;

    // Add file fields
    request.files.add(await _createMultipartFile(carLicensePhoto, 'car_license_photo'));
    request.files.add(await _createMultipartFile(driverLicensePhoto, 'driver_license_photo'));
    request.files.add(await _createMultipartFile(nationalIdFrontPhoto, 'national_id_front_photo'));
    request.files.add(await _createMultipartFile(nationalIdBackPhoto, 'national_id_back_photo'));
    request.files.add(await _createMultipartFile(carPhoto, 'car_photo'));

    // Send the request
    final response = await request.send();

    // Process the response
    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      return AddCarsApiResponse.fromJson(decodedResponse);
    } else {
      throw Exception('Failed to upload car data. Error code: ${response.statusCode}');
    }
  }

  // Helper function to create MultipartFile for images
  Future<http.MultipartFile> _createMultipartFile(File file, String fieldName) async {
    final mimeTypeData = lookupMimeType(file.path)!.split('/');
    return await http.MultipartFile.fromPath(
      fieldName,
      file.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    );
  }
}