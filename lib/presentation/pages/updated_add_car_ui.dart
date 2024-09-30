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
  XFile? carLicensePhoto;
  XFile? driverLicensePhoto;
  XFile? nationalIdFrontPhoto;
  XFile? nationalIdBackPhoto;
  XFile? carPhoto;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(Function(XFile?) updateImage) async {
    final XFile? selectedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    updateImage(selectedImage);
  }

  Widget imageBox(XFile? image, Function() onPick, String label) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        width: 100, // Adjust box size here
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), // Rounded corners
          color: Colors.grey[300],
          border: Border.all(
            color: Colors.grey, // Border color
            width: 1.0,
          ),
        ),
        child: image == null
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image, size: 30, color: Colors.grey),
              Text(label, style: TextStyle(color: Colors.grey)),
            ],
          ),
        )
            : Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              // Rounded corners for image
              child: Image.file(
                File(image.path),
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child:
              Icon(Icons.check_circle, color: Colors.green, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Images'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text('Car License Photo'),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          imageBox(
                              carLicensePhoto,
                                  () => pickImage((image) {
                                setState(() {
                                  carLicensePhoto = image;
                                });
                              }),
                              'Car License'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => pickImage((image) {
                              setState(() {
                                carLicensePhoto = image;
                              });
                            }),
                            child: Text('Change'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      Text('Driver License Photo'),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          imageBox(
                              driverLicensePhoto,
                                  () => pickImage((image) {
                                setState(() {
                                  driverLicensePhoto = image;
                                });
                              }),
                              'Driver License'),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => pickImage((image) {
                              setState(() {
                                driverLicensePhoto = image;
                              });
                            }),
                            child: Text('Change'),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text('National ID Front'),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          imageBox(
                              nationalIdFrontPhoto,
                                  () => pickImage((image) {
                                setState(() {
                                  nationalIdFrontPhoto = image;
                                });
                              }),
                              'National ID Front'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => pickImage((image) {
                              setState(() {
                                nationalIdFrontPhoto = image;
                              });
                            }),
                            child: Text('Change'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 30),
                  Column(
                    children: [
                      const Text('National ID Back'),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          imageBox(
                              nationalIdBackPhoto,
                                  () => pickImage((image) {
                                setState(() {
                                  nationalIdBackPhoto = image;
                                });
                              }),
                              'National ID Back'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => pickImage((image) {
                              setState(() {
                                nationalIdBackPhoto = image;
                              });
                            }),
                            child: const Text('Change'),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Text('Car Photo'),
              Row(
                children: [
                  imageBox(
                      carPhoto,
                          () => pickImage((image) {
                        setState(() {
                          carPhoto = image;
                        });
                      }),
                      'Car'),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => pickImage((image) {
                      setState(() {
                        carPhoto = image;
                      });
                    }),
                    child: Text('Change'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
