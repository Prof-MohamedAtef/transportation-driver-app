import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/routes.dart';
import '../viewmodel/location/location_viewmodel.dart';
import '../viewmodel/location/location_viewmodel.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LocationViewModel>();

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Get User Location')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Allow us to access your location',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await viewModel.requestLocation();
                if (viewModel.latitude != null && viewModel.longitude != null) {
                  _showLocationDialog(context, viewModel.latitude!, viewModel.longitude!);
                } else if (viewModel.errorMessage != null) {
                  _showErrorDialog(context, viewModel.errorMessage!);
                }
              },
              child: const Text('Get Location'),
            ),
            if (viewModel.latitude != null && viewModel.longitude != null) ...[
              Text('Latitude: ${viewModel.latitude}'),
              Text('Longitude: ${viewModel.longitude}'),
            ]
          ],
        ),
      ),
    );
  }

  void _showLocationDialog(BuildContext context, String latitude, String longitude) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your Location'),
          content: Text('Latitude: $latitude\nLongitude: $longitude'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.signInScreen);
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}