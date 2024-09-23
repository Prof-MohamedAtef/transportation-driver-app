import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/etities/trip.dart';
import '../viewmodel/trips/trips_viewmodel.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen({super.key});

  @override
  _AddTripScreenState createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form inputs
  final TextEditingController _pickUpLatitudeController =
      TextEditingController();
  final TextEditingController _pickUpLongitudeController =
      TextEditingController();
  final TextEditingController _pickUpCityController = TextEditingController();
  final TextEditingController _destinationLatitudeController =
      TextEditingController();
  final TextEditingController _destinationLongitudeController =
      TextEditingController();
  final TextEditingController _destinationCityController =
      TextEditingController();
  final TextEditingController _departureDateController =
      TextEditingController();
  final TextEditingController _departureTimeController =
      TextEditingController();
  final TextEditingController _arrivalDateController = TextEditingController();
  final TextEditingController _arrivalTimeController = TextEditingController();
  final TextEditingController _carIdController = TextEditingController();
  final TextEditingController _numOfSeatsController = TextEditingController();
  final TextEditingController _tripPriceController = TextEditingController();
  final TextEditingController _frontChairPriceController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tripViewModel = Provider.of<TripViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Trip'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Handles back navigation
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTextField('Pick Up Latitude', _pickUpLatitudeController),
                _buildTextField(
                    'Pick Up Longitude', _pickUpLongitudeController),
                _buildTextField('Pick Up City', _pickUpCityController),
                _buildTextField(
                    'Destination Latitude', _destinationLatitudeController),
                _buildTextField(
                    'Destination Longitude', _destinationLongitudeController),
                _buildTextField('Destination City', _destinationCityController),
                _buildTextField('Departure Date', _departureDateController),
                _buildTextField('Departure Time', _departureTimeController),
                _buildTextField('Arrival Date', _arrivalDateController),
                _buildTextField('Arrival Time', _arrivalTimeController),
                _buildTextField('Car ID', _carIdController),
                _buildTextField('Number of Seats', _numOfSeatsController),
                _buildTextField('Trip Price', _tripPriceController),
                _buildTextField(
                    'Front Chair Price', _frontChairPriceController),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Create a Trip entity from the input
                      final trip = Trip(
                        pickUpLatitude:
                            double.parse(_pickUpLatitudeController.text),
                        pickUpLongitude:
                            double.parse(_pickUpLongitudeController.text),
                        pickUpCity: _pickUpCityController.text,
                        destinationLatitude:
                            double.parse(_destinationLatitudeController.text),
                        destinationLongitude:
                            double.parse(_destinationLongitudeController.text),
                        destinationCity: _destinationCityController.text,
                        departureDate: _departureDateController.text,
                        departureTime: _departureTimeController.text,
                        arrivalDate: _arrivalDateController.text,
                        arrivalTime: _arrivalTimeController.text,
                        carId: int.parse(_carIdController.text),
                        numOfSeats: int.parse(_numOfSeatsController.text),
                        tripPrice: double.parse(_tripPriceController.text),
                        frontChairPrice:
                            double.parse(_frontChairPriceController.text),
                      );

                      // Call ViewModel to insert the trip
                      await tripViewModel.insertTrip(trip);

                      // Navigate based on success or failure
                      if (tripViewModel.isSuccess) {
                        Navigator.pop(
                            context); // Success, return to previous screen
                      } else if (tripViewModel.errorMessage != null) {
                        _showErrorDialog(context, tripViewModel.errorMessage!);
                      }
                    }
                  },
                  child: tripViewModel.isLoading
                      ? CircularProgressIndicator()
                      : const Text('Submit'),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pickUpLatitudeController.dispose();
    _pickUpLongitudeController.dispose();
    _pickUpCityController.dispose();
    _destinationLatitudeController.dispose();
    _destinationLongitudeController.dispose();
    _destinationCityController.dispose();
    _departureDateController.dispose();
    _departureTimeController.dispose();
    _arrivalDateController.dispose();
    _arrivalTimeController.dispose();
    _carIdController.dispose();
    _numOfSeatsController.dispose();
    _tripPriceController.dispose();
    _frontChairPriceController.dispose();
    super.dispose();
  }
}
