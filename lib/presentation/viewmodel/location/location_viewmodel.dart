import 'package:flutter/cupertino.dart';

import '../../../data/datasources/location/location_service.dart';

class LocationViewModel extends ChangeNotifier {
  final LocationService _locationService;
  String? latitude;
  String? longitude;
  String? errorMessage;

  LocationViewModel(this._locationService);

  Future<void> requestLocation() async {
    try {
      final locationData = await _locationService.getUserLocation();
      if (locationData != null) {
        latitude = locationData.latitude.toString();
        longitude = locationData.longitude.toString();
      } else {
        errorMessage = 'Location permission denied';
      }
    } catch (e) {
      errorMessage = 'Failed to get location';
    }
    notifyListeners();
  }
}