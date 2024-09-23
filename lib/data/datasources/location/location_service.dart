import 'package:location/location.dart' as location_pkg;
import 'package:permission_handler/permission_handler.dart' as permission_pkg;

class LocationService {
  location_pkg.Location location = location_pkg.Location();


  Future<location_pkg.LocationData?> getUserLocation() async {
    permission_pkg.PermissionStatus permissionStatus = await _checkLocationPermission();

    if (permissionStatus == permission_pkg.PermissionStatus.granted) {
      return await location.getLocation();
    }
    return null;
  }

  Future<permission_pkg.PermissionStatus> _checkLocationPermission() async {
    final status = await permission_pkg.Permission.location.request();
    return status;
  }
}