import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../state/store_user_state.dart';
import '../viewmodel/user/user_api_view_model.dart';
import '../viewmodel/user/user_shared_prefs_view_model.dart';

class UpdateUserProfileScreen extends StatefulWidget {
  const UpdateUserProfileScreen({super.key});

  @override
  State<UpdateUserProfileScreen> createState() => _UpdateUserProfileScreenState();
}

class _UpdateUserProfileScreenState extends State<UpdateUserProfileScreen> {
  File? _profilePhoto; // For storing the selected profile photo
  final ImagePicker _picker = ImagePicker(); // ImagePicker instance

  // Function to pick an image from the gallery
  Future<void> _pickProfilePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePhoto = File(pickedFile.path); // Set the picked image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sharedPrefsViewModel = Provider.of<UserViewModel>(context); // Accessing ViewModel
    final userApiViewModel = Provider.of<UserApiViewModel>(context); // Accessing ViewModel

    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Profile Photo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickProfilePhoto, // Trigger image picker when tapping on the image area
              child: _profilePhoto == null
                  ? Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.grey[600],
                    size: 50,
                  ),
                ),
              )
                  : Stack(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(_profilePhoto!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                if (_profilePhoto == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a profile photo.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  // Get the data from the UserViewModel
                  String? firebaseUserId = sharedPrefsViewModel.user?.uid;
                  String? email = sharedPrefsViewModel.user?.email;
                  String? displayName = sharedPrefsViewModel.user?.displayName;
                  String? password = 'mohamed123456';
                  bool isVerified = false; // false in this case

                  // Call the ViewModel's saveUser method
                  userApiViewModel.saveUser(
                    firebaseUserId: firebaseUserId.toString(),
                    email: "ahmed@gmail.com",
                    displayName: displayName.toString(),
                    password: password.toString(),
                    isVerified: isVerified,
                    profilePhoto: _profilePhoto!, // File selected via picker
                  );
                }
              },
              child: const Text("Submit"),
            ),
            const SizedBox(height: 20),
            if (userApiViewModel.state is UserCallLoading)
              const CircularProgressIndicator(),
            if (userApiViewModel.state is UserCallFailure)
              Text(
                (userApiViewModel.state as UserCallFailure).message,
                style: const TextStyle(color: Colors.red),
              ),
            if (userApiViewModel.state is UserCallSuccess)
              const Text(
                "User saved successfully!",
                style: TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}