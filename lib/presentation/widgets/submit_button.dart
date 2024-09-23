import 'package:flutter/material.dart';

import '../routes/routes.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Action when button is pressed
        print("Submit button clicked");
        Navigator.pushNamed(context, AppRoutes.tripsScreen);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Background color
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // Rounded corners with radius 20
        ),
      ),
      child: const Text(
        "Submit",
        style: TextStyle(
          color: Colors.white, // Text color
          fontSize: 18, // Text size
        ),
      ),
    );
  }
}
