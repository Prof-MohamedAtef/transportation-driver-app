import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zeow_driver/data/models/car/car_model.dart';
import 'package:zeow_driver/presentation/routes/routes.dart';
import 'package:zeow_driver/presentation/viewmodel/user/user_view_model.dart';
import '../state/add_car_state.dart';
import '../state/car_types_state.dart';
import '../viewmodel/cars/add_cars_view_model.dart';
import '../viewmodel/cars/get_cars_view_model.dart';

class AddBusScreen extends StatefulWidget {
  const AddBusScreen({super.key});

  @override
  _AddBusScreenState createState() => _AddBusScreenState();
}

class _AddBusScreenState extends State<AddBusScreen> {
  Car? selectedCar;
  XFile? carLicenseIdPhoto;
  XFile? driverLicenseIdPhoto;
  XFile? nationalIDFrontSide;
  XFile? nationalIDBackSide;
  XFile? carPhoto;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    Provider.of<CarViewModel>(context, listen: false).fetchCarTypes();
  }

  Future<void> pickImage(ImageSource source,
      Function(XFile?) onSelected) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      onSelected(pickedFile);
    });
  }

  Future<void> submitBusData() async {
    final addCarViewModel = Provider.of<AddCarViewModel>(context, listen: false);
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    if (selectedCar == null ||
        carLicenseIdPhoto == null ||
        driverLicenseIdPhoto == null ||
        nationalIDFrontSide == null ||
        nationalIDBackSide == null ||
        carPhoto == null) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text('Missing Information'),
              content: const Text(
                  'Please fill in all fields and upload all photos before submitting.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
      return;
    }

    // Convert XFile to File
    File carLicenseFile = File(carLicenseIdPhoto!.path);
    File driverLicenseFile = File(driverLicenseIdPhoto!.path);
    File nationalIdFrontFile = File(nationalIDFrontSide!.path);
    File nationalIdBackFile = File(nationalIDBackSide!.path);
    File carPhotoFile = File(carPhoto!.path);

    String? firebaseUi = userViewModel.user?.uid!;

    addCarViewModel.addCar(
      firebaseUserId: firebaseUi!,
      vehicleTypeId: selectedCar!.id.toString(),
      carLicensePhoto: carLicenseFile,
      driverLicensePhoto: driverLicenseFile,
      nationalIdFrontPhoto: nationalIdFrontFile,
      nationalIdBackPhoto: nationalIdBackFile,
      carPhoto: carPhotoFile
    );

    // Show progress indicator or loading state
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Use a listener to handle the response after the API call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addCarViewModel.addListener(() {
        final state = addCarViewModel.state;

        if (state is AddCarCallSuccess) {
          Navigator.pop(context); // Close the progress indicator dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
        } else if (state is AddCarCallFailure) {
          Navigator.pop(context); // Close the progress indicator dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final carViewModel = Provider.of<CarViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text('Add Bus'), backgroundColor: Colors.yellow,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarTypeDropdown(carViewModel),
            const SizedBox(height: 16),
            selectedCar != null
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Brand: ${selectedCar!.brand}',
                  style: const TextStyle(fontSize: 18, color: Colors.pink),),
                Text('Seats: ${selectedCar!.seatsNumber}',
                    style: const TextStyle(fontSize: 18, color: Colors.pink)),
              ],
            )
                : const SizedBox.shrink(),
            const SizedBox(height: 16),
            buildPhotoUploadField(
                'Upload Car License ID Photo', carLicenseIdPhoto, () {
              pickImage(
                  ImageSource.gallery, (file) => carLicenseIdPhoto = file);
            }),
            const SizedBox(height: 16),
            buildPhotoUploadField(
                'Upload Driver License ID Photo', driverLicenseIdPhoto, () {
              pickImage(
                  ImageSource.gallery, (file) => driverLicenseIdPhoto = file);
            }),
            const SizedBox(height: 16),
            buildPhotoUploadField(
                'Upload National ID Front Side Photo', nationalIDFrontSide, () {
              pickImage(
                  ImageSource.gallery, (file) => nationalIDFrontSide = file);
            }),
            const SizedBox(height: 16),
            buildPhotoUploadField(
                'Upload National ID Back Side Photo', nationalIDBackSide, () {
              pickImage(
                  ImageSource.gallery, (file) => nationalIDBackSide = file);
            }),
            const SizedBox(height: 16),
            buildPhotoUploadField('Upload Car Photo', carPhoto, () {
              pickImage(ImageSource.gallery, (file) => carPhoto = file);
            }),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: submitBusData,
                child: const Text('Submit Bus Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarTypeDropdown(CarViewModel carViewModel) {
    // Check the current state from the ViewModel
    final state = carViewModel.state;

    if (state is CarCallLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CarCallFailure) {
      return Center(child: Text(state.message));
    } else if (state is CarCallSuccess) {
      return DropdownButton<Car>(
        hint: const Text('Select Car Brand'),
        value: selectedCar,
        items: state.cars.map((Car car) {
          return DropdownMenuItem<Car>(
            value: car,
            child: Text(car.brand),
          );
        }).toList(),
        onChanged: (Car? newValue) {
          setState(() {
            selectedCar = newValue;
          });
        },
      );
    } else {
      return const Center(child: Text('No car types available'));
    }
  }

  Widget buildPhotoUploadField(String label, XFile? file, Function onTap) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => onTap(),
          child: Text(file == null ? 'Upload' : 'Change',),
        ),
        if (file != null) const Icon(Icons.check, color: Colors.green),
      ],
    );
  }
}