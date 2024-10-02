import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zeow_driver/data/models/car/car_model.dart';
import 'package:zeow_driver/presentation/routes/routes.dart';
import 'package:zeow_driver/presentation/viewmodel/user/user_shared_prefs_view_model.dart';
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
  late CarViewModel carViewModel;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CarViewModel>(context, listen: false).fetchCarTypes();
    });
  }

  Future<void> pickImage(
      ImageSource source, Function(XFile?) onSelected) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      onSelected(pickedFile);
    });
  }

  Future<void> submitBusData() async {
    final addCarViewModel =
        Provider.of<AddCarViewModel>(context, listen: false);
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    if (selectedCar == null ||
        carLicenseIdPhoto == null ||
        driverLicenseIdPhoto == null ||
        nationalIDFrontSide == null ||
        nationalIDBackSide == null ||
        carPhoto == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
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

    File carLicenseFile = File(carLicenseIdPhoto!.path);
    File driverLicenseFile = File(driverLicenseIdPhoto!.path);
    File nationalIdFrontFile = File(nationalIDFrontSide!.path);
    File nationalIdBackFile = File(nationalIDBackSide!.path);
    File carPhotoFile = File(carPhoto!.path);

    String? firebaseUi = userViewModel.user?.uid;

    addCarViewModel.addCar(
      firebaseUserId: firebaseUi!,
      vehicleTypeId: selectedCar!.id.toString(),
      carLicensePhoto: carLicenseFile,
      driverLicensePhoto: driverLicenseFile,
      nationalIdFrontPhoto: nationalIdFrontFile,
      nationalIdBackPhoto: nationalIdBackFile,
      carPhoto: carPhotoFile,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      addCarViewModel.addListener(() {
        final state = addCarViewModel.state;

        if (state is AddCarCallSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
        } else if (state is AddCarCallFailure) {
          Navigator.pop(context);
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
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text('Add Bus'),
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Row: Car Photo on the left, Car Type Dropdown on the right
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Car Photo'),
                        const SizedBox(height: 10),
                        imageBox(carPhoto, () {
                          pickImage(ImageSource.gallery, (file) {
                            setState(() {
                              carPhoto = file;
                            });
                          });
                        }, 'Car'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            pickImage(ImageSource.gallery, (file) {
                              setState(() {
                                carPhoto = file;
                              });
                            });
                          },
                          child: const Text('Change'),
                        ),
                      ],
                    ),
                    _buildCarTypeDropdown(),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Second Row: Car License and Driver License Photos
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildPhotoColumn(
                      'Car License Photo',
                      carLicenseIdPhoto,
                      () {
                        pickImage(ImageSource.gallery, (file) {
                          setState(() {
                            carLicenseIdPhoto = file;
                          });
                        });
                      },
                      'Car License',
                    ),
                    buildPhotoColumn(
                      'Driver License Photo',
                      driverLicenseIdPhoto,
                      () {
                        pickImage(ImageSource.gallery, (file) {
                          setState(() {
                            driverLicenseIdPhoto = file;
                          });
                        });
                      },
                      'Driver License',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Third Row: National ID Back and Front Photos
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildPhotoColumn(
                      'National ID Back',
                      nationalIDBackSide,
                      () {
                        pickImage(ImageSource.gallery, (file) {
                          setState(() {
                            nationalIDBackSide = file;
                          });
                        });
                      },
                      'NID Back',
                    ),
                    buildPhotoColumn(
                      'National ID Front',
                      nationalIDFrontSide,
                      () {
                        pickImage(ImageSource.gallery, (file) {
                          setState(() {
                            nationalIDFrontSide = file;
                          });
                        });
                      },
                      'NID Front',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: submitBusData,
                  child: const Text('Submit Bus Data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarTypeDropdown() {
    return Consumer<CarViewModel>(builder: (context, carViewModel, child) {
      if (carViewModel.state is CarCallLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (carViewModel.state is CarCallFailure) {
        final errorMessage = (carViewModel.state as CarCallFailure).message;
        return Center(child: Text(errorMessage));
      } else if (carViewModel.state is CarCallSuccess) {
        final cars = (carViewModel.state as CarCallSuccess).cars;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton<Car>(
              hint: const Text('Select Car Brand'),
              value: selectedCar,
              items: cars.map((Car car) {
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
            ),
            const SizedBox(height: 10),

            // Show number of seats for selected car
            selectedCar != null
                ? Text(
              'Number of Seats: ${selectedCar!.seatsNumber}',
              // Displaying seat count
              style: const TextStyle(fontSize: 16),
            )
                : const SizedBox.shrink(),
            // Empty widget if no car is selected
          ],
        );
      } else {
        return const Center(child: Text('No car types available'));
      }
    });
  }

  Widget buildPhotoColumn(
      String label, XFile? file, Function onTap, String fileType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        const SizedBox(height: 10),
        imageBox(file, onTap, fileType),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => onTap(),
          child: Text(file == null ? 'Upload' : 'Change'),
        ),
      ],
    );
  }

  Widget imageBox(XFile? file, Function onTap, String label) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[200],
        ),
        child: file != null
            ? Stack(
                children: [
                  Image.file(File(file.path), fit: BoxFit.cover),
                  const Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ],
              )
            : Center(
                child: Text(label, style: const TextStyle(color: Colors.grey)),
              ),
      ),
    );
  }
}

// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:zeow_driver/data/models/car/car_model.dart';
// import 'package:zeow_driver/presentation/routes/routes.dart';
// import 'package:zeow_driver/presentation/viewmodel/user/user_shared_prefs_view_model.dart';
// import '../state/add_car_state.dart';
// import '../state/car_types_state.dart';
// import '../viewmodel/cars/add_cars_view_model.dart';
// import '../viewmodel/cars/get_cars_view_model.dart';
//

// ancient
// class AddBusScreen extends StatefulWidget {
//   const AddBusScreen({super.key});
//
//   @override
//   _AddBusScreenState createState() => _AddBusScreenState();
// }
//
// class _AddBusScreenState extends State<AddBusScreen> {
//   Car? selectedCar;
//   XFile? carLicenseIdPhoto;
//   XFile? driverLicenseIdPhoto;
//   XFile? nationalIDFrontSide;
//   XFile? nationalIDBackSide;
//   XFile? carPhoto;
//
//   final picker = ImagePicker();
//
//
//
//   Future<void> pickImage(ImageSource source,
//       Function(XFile?) onSelected) async {
//     final pickedFile = await picker.pickImage(source: source);
//     setState(() {
//       onSelected(pickedFile);
//     });
//   }
//
//   Future<void> submitBusData() async {
//     final addCarViewModel = Provider.of<AddCarViewModel>(context, listen: false);
//     final userViewModel = Provider.of<UserViewModel>(context, listen: false);
//     if (selectedCar == null ||
//         carLicenseIdPhoto == null ||
//         driverLicenseIdPhoto == null ||
//         nationalIDFrontSide == null ||
//         nationalIDBackSide == null ||
//         carPhoto == null) {
//       showDialog(
//         context: context,
//         builder: (context) =>
//             AlertDialog(
//               title: const Text('Missing Information'),
//               content: const Text(
//                   'Please fill in all fields and upload all photos before submitting.'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('OK'),
//                 ),
//               ],
//             ),
//       );
//       return;
//     }
//
//     // Convert XFile to File
//     File carLicenseFile = File(carLicenseIdPhoto!.path);
//     File driverLicenseFile = File(driverLicenseIdPhoto!.path);
//     File nationalIdFrontFile = File(nationalIDFrontSide!.path);
//     File nationalIdBackFile = File(nationalIDBackSide!.path);
//     File carPhotoFile = File(carPhoto!.path);
//
//     String? firebaseUi = userViewModel.user?.uid!;
//
//     addCarViewModel.addCar(
//       firebaseUserId: firebaseUi!,
//       vehicleTypeId: selectedCar!.id.toString(),
//       carLicensePhoto: carLicenseFile,
//       driverLicensePhoto: driverLicenseFile,
//       nationalIdFrontPhoto: nationalIdFrontFile,
//       nationalIdBackPhoto: nationalIdBackFile,
//       carPhoto: carPhotoFile
//     );
//
//     // Show progress indicator or loading state
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(child: CircularProgressIndicator()),
//     );
//
//     // Use a listener to handle the response after the API call
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       addCarViewModel.addListener(() {
//         final state = addCarViewModel.state;
//
//         if (state is AddCarCallSuccess) {
//           Navigator.pop(context); // Close the progress indicator dialog
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.response.message),
//               backgroundColor: Colors.green,
//             ),
//           );
//           Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
//         } else if (state is AddCarCallFailure) {
//           Navigator.pop(context); // Close the progress indicator dialog
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.message),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final carViewModel = Provider.of<CarViewModel>(context);
//
//     return Scaffold(
//       backgroundColor: Colors.yellow,
//       appBar: AppBar(
//         title: const Text('Add Bus'), backgroundColor: Colors.yellow,),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildCarTypeDropdown(carViewModel),
//             const SizedBox(height: 16),
//             selectedCar != null
//                 ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Brand: ${selectedCar!.brand}',
//                   style: const TextStyle(fontSize: 18, color: Colors.pink),),
//                 Text('Seats: ${selectedCar!.seatsNumber}',
//                     style: const TextStyle(fontSize: 18, color: Colors.pink)),
//               ],
//             )
//                 : const SizedBox.shrink(),
//             const SizedBox(height: 16),
//             buildPhotoUploadField(
//                 'Upload Car License ID Photo', carLicenseIdPhoto, () {
//               pickImage(
//                   ImageSource.gallery, (file) => carLicenseIdPhoto = file);
//             }),
//             const SizedBox(height: 16),
//             buildPhotoUploadField(
//                 'Upload Driver License ID Photo', driverLicenseIdPhoto, () {
//               pickImage(
//                   ImageSource.gallery, (file) => driverLicenseIdPhoto = file);
//             }),
//             const SizedBox(height: 16),
//             buildPhotoUploadField(
//                 'Upload National ID Front Side Photo', nationalIDFrontSide, () {
//               pickImage(
//                   ImageSource.gallery, (file) => nationalIDFrontSide = file);
//             }),
//             const SizedBox(height: 16),
//             buildPhotoUploadField(
//                 'Upload National ID Back Side Photo', nationalIDBackSide, () {
//               pickImage(
//                   ImageSource.gallery, (file) => nationalIDBackSide = file);
//             }),
//             const SizedBox(height: 16),
//             buildPhotoUploadField('Upload Car Photo', carPhoto, () {
//               pickImage(ImageSource.gallery, (file) => carPhoto = file);
//             }),
//             const SizedBox(height: 32),
//             Center(
//               child: ElevatedButton(
//                 onPressed: submitBusData,
//                 child: const Text('Submit Bus Data'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// Widget _buildCarTypeDropdown(CarViewModel carViewModel) {
//   // Check the current state from the ViewModel
//   final state = carViewModel.state;
//
//   if (state is CarCallLoading) {
//     return const Center(child: CircularProgressIndicator());
//   } else if (state is CarCallFailure) {
//     return Center(child: Text(state.message));
//   } else if (state is CarCallSuccess) {
//     return DropdownButton<Car>(
//       hint: const Text('Select Car Brand'),
//       value: selectedCar,
//       items: state.cars.map((Car car) {
//         return DropdownMenuItem<Car>(
//           value: car,
//           child: Text(car.brand),
//         );
//       }).toList(),
//       onChanged: (Car? newValue) {
//         setState(() {
//           selectedCar = newValue;
//         });
//       },
//     );
//   } else {
//     return const Center(child: Text('No car types available'));
//   }
// }
//
//   Widget buildPhotoUploadField(String label, XFile? file, Function onTap) {
//     return Row(
//       children: [
//         Expanded(child: Text(label)),
//         const SizedBox(width: 10),
//         ElevatedButton(
//           onPressed: () => onTap(),
//           child: Text(file == null ? 'Upload' : 'Change',),
//         ),
//         if (file != null) const Icon(Icons.check, color: Colors.green),
//       ],
//     );
//   }
// }
