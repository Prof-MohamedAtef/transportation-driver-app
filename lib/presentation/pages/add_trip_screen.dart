import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeow_driver/data/models/trips/trip_model.dart';
import '../routes/routes.dart';
import '../state/add_trip_state.dart';
import '../viewmodel/trips/trips_viewmodel.dart';
import '../widgets/flutter_toast_widget.dart';

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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Consumer<TripViewModel>(builder: (context, viewModel, child) {
                if (viewModel.state is AddTripLoading) {
                  return const SizedBox.shrink();
                }else if (viewModel.state is AddTripSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // Adding a short delay before navigating to avoid the progress dialog reappearing
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
                      showToastMessage("Trip Added Successfully!",
                          Colors.green); // Show success toast
                    });
                  });
                  return const SizedBox.shrink();
                }else if (viewModel.state is AddTripFailure) {
                  final errorMessage =
                      (viewModel.state as AddTripFailure).message;
                  // showToastMessage(errorMessage, Colors.red);
                  return _addTripScreenWidget(viewModel,
                      showErrorToast: true, errorMessage: errorMessage);
                }else {
                  return _addTripScreenWidget(viewModel);
                }
              }),
            ),
            if (Provider.of<TripViewModel>(context).state is AddTripLoading)
              const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.yellow,
                  color: Colors.pink,
                ),
              ),
          ],
        ));
  }

  // _addTripScreenWidget(tripViewModel)
  Widget _addTripScreenWidget(TripViewModel tripViewModel,
      {bool showErrorToast = false, String? errorMessage}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField('Pick Up Latitude', _pickUpLatitudeController),
            _buildTextField('Pick Up Longitude', _pickUpLongitudeController),
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
            _buildTextField('Front Chair Price', _frontChairPriceController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Create a Trip entity from the input
                  final trip = TripModel(
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
                  // if (tripViewModel.state is ) {
                  //   Navigator.pop(
                  //       context); // Success, return to previous screen
                  // } else if (tripViewModel.errorMessage != null) {
                  //   _showErrorDialog(context, tripViewModel.errorMessage!);
                  // }
                }
              },
              child: tripViewModel.state == AddTripLoading()
                  ? const CircularProgressIndicator()
                  : const Text('Submit'),
            ),
            if (showErrorToast && errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
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
