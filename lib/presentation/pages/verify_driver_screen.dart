// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:zeow_driver/presentation/viewmodel/verifydriver/verify_driver_view_model.dart';
//
// import '../routes/routes.dart';
// import '../state/verify_driver_state.dart';
// import '../viewmodel/user/user_shared_prefs_view_model.dart';
//
// class VerifyDriverScreen extends StatefulWidget {
//   const VerifyDriverScreen({super.key});
//
//   @override
//   _VerifyDriverState createState() => _VerifyDriverState();
// }
//
// class _VerifyDriverState extends State<VerifyDriverScreen> {
//   XFile? driverLicenseIdPhoto;
//   XFile? nationalIDFrontSide;
//   XFile? nationalIDBackSide;
//   XFile? driverPhoto;
//
//   late VerifyDriverViewModel verifyDriverViewModel;
//
//   final picker = ImagePicker();
//
//   Future<void> pickImage(
//       ImageSource source, Function(XFile?) onSelected) async {
//     final pickedFile = await picker.pickImage(source: source);
//     setState(() {
//       onSelected(pickedFile);
//     });
//   }
//
//   Future<void> submitBusData() async {
//     final addCarViewModel =
//     Provider.of<VerifyDriverViewModel>(context, listen: false);
//     final userViewModel = Provider.of<UserViewModel>(context, listen: false);
//
//     if (driverLicenseIdPhoto == null ||
//         nationalIDFrontSide == null ||
//         nationalIDBackSide == null ||
//         driverPhoto == null) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Missing Information'),
//           content: const Text(
//               'Please fill in all fields and upload all photos before submitting.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//       return;
//     }
//
//     File driverLicenseFile = File(driverLicenseIdPhoto!.path);
//     File nationalIdFrontFile = File(nationalIDFrontSide!.path);
//     File nationalIdBackFile = File(nationalIDBackSide!.path);
//     File driverPhotoFile = File(driverPhoto!.path);
//
//     addCarViewModel.addCar(
//       driverLicensePhoto: driverLicenseFile,
//       nationalIdFrontPhoto: nationalIdFrontFile,
//       nationalIdBackPhoto: nationalIdBackFile,
//       driverPhoto: driverPhotoFile,
//     );
//
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(child: CircularProgressIndicator()),
//     );
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       verifyDriverViewModel.addListener(() {
//         final state = verifyDriverViewModel.state;
//
//         if (state is VerifyDriverSuccess) {
//           Navigator.pop(context);
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.response.message),
//               backgroundColor: Colors.green,
//             ),
//           );
//           Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
//         } else if (state is VerifyDriverFailure) {
//           Navigator.pop(context);
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
//     return Scaffold(
//       backgroundColor: Colors.yellow,
//       appBar: AppBar(
//         title: const Text('Verify Driver'),
//         backgroundColor: Colors.yellow,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // First Row: Car Photo on the left, Car Type Dropdown on the right
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween ,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text('Driver Photo'),
//                         const SizedBox(height: 10),
//                         imageBox(driverPhoto, () {
//                           pickImage(ImageSource.gallery, (file) {
//                             setState(() {
//                               driverPhoto = file;
//                             });
//                           });
//                         }, 'Driver'),
//                         const SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: () {
//                             pickImage(ImageSource.gallery, (file) {
//                               setState(() {
//                                 driverPhoto = file;
//                               });
//                             });
//                           },
//                           child: const Text('Change'),
//                         ),
//                       ],
//                     ),
//                     buildPhotoColumn(
//                       'Driver License Photo',
//                       driverLicenseIdPhoto,
//                           () {
//                         pickImage(ImageSource.gallery, (file) {
//                           setState(() {
//                             driverLicenseIdPhoto = file;
//                           });
//                         });
//                       },
//                       'Driver License',
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 30),
//
//               // Second Row: Car License and Driver License Photos
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     buildPhotoColumn(
//                       'National ID Front',
//                       nationalIDFrontSide,
//                           () {
//                         pickImage(ImageSource.gallery, (file) {
//                           setState(() {
//                             nationalIDFrontSide = file;
//                           });
//                         });
//                       },
//                       'NID Front',
//                     ),
//                     buildPhotoColumn(
//                       'National ID Back',
//                       nationalIDBackSide,
//                           () {
//                         pickImage(ImageSource.gallery, (file) {
//                           setState(() {
//                             nationalIDBackSide = file;
//                           });
//                         });
//                       },
//                       'NID Back',
//                     ),
//
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),
//
//               // Submit Button
//               Center(
//                 child: ElevatedButton(
//                   onPressed: submitBusData,
//                   child: const Text('Submit Bus Data'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCarTypeDropdown() {
//     return Consumer<CarViewModel>(builder: (context, carViewModel, child) {
//       if (carViewModel.state is VerifyDriverLoading) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (carViewModel.state is VerifyDriverFailure) {
//         final errorMessage = (carViewModel.state as VerifyDriverFailure).message;
//         return Center(child: Text(errorMessage));
//       } else if (carViewModel.state is VerifyDriverSuccess) {
//         final cars = (carViewModel.state as VerifyDriverSuccess).cars;
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             DropdownButton<Car>(
//               hint: const Text('Select Car Brand'),
//               value: selectedCar,
//               items: cars.map((Car car) {
//                 return DropdownMenuItem<Car>(
//                   value: car,
//                   child: Text(car.brand),
//                 );
//               }).toList(),
//               onChanged: (Car? newValue) {
//                 setState(() {
//                   selectedCar = newValue;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),
//
//             // Show number of seats for selected car
//             selectedCar != null
//                 ? Text(
//               'Number of Seats: ${selectedCar!.seatsNumber}',
//               // Displaying seat count
//               style: const TextStyle(fontSize: 16),
//             )
//                 : const SizedBox.shrink(),
//             // Empty widget if no car is selected
//           ],
//         );
//       } else {
//         return const Center(child: Text('No car types available'));
//       }
//     });
//   }
//
//   Widget buildPhotoColumn(
//       String label, XFile? file, Function onTap, String fileType) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(label),
//         const SizedBox(height: 10),
//         imageBox(file, onTap, fileType),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () => onTap(),
//           child: Text(file == null ? 'Upload' : 'Change'),
//         ),
//       ],
//     );
//   }
//
//   Widget imageBox(XFile? file, Function onTap, String label) {
//     return GestureDetector(
//       onTap: () => onTap(),
//       child: Container(
//         height: 100,
//         width: 100,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: Colors.grey[200],
//         ),
//         child: file != null
//             ? Stack(
//           children: [
//             Image.file(File(file.path), fit: BoxFit.cover),
//             const Positioned(
//               top: 5,
//               right: 5,
//               child: Icon(Icons.check, color: Colors.green),
//             ),
//           ],
//         )
//             : Center(
//           child: Text(label, style: const TextStyle(color: Colors.grey)),
//         ),
//       ),
//     );
//   }
// }