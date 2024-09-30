import 'package:flutter/material.dart';

import '../routes/routes.dart';

class CustomTextField extends StatefulWidget {
  final String title, hint;
  final Function(String)? onChanged;
  final bool obscureText;
  final TextEditingController controller;

  CustomTextField({
    super.key,
    required this.title,
    this.onChanged,
    required this.obscureText,
    required this.hint,
    required this.controller, // Pass the controller explicitly
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

bool isValidEmail(String email) {
  return email.contains('@');
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        TextFormField(
          validator: (value) {
            if (widget.title == 'email') {
              if (value == null || value.isEmpty) {
                return 'Please enter your Email';
              } else if (!isValidEmail(value)) {
                return 'Please enter a valid email';
              }
            }
            return null;
          },
          controller: widget.controller,
          // Use passed controller
          cursorColor: const Color.fromARGB(255, 255, 255, 255),
          obscureText: widget.title == 'password' && !showPassword,
          decoration: InputDecoration(
            suffixIcon: widget.title == 'password'
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  )
                : null,
            filled: true,
            fillColor: const Color.fromARGB(255, 10, 189, 220),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: widget.hint,
          ),
          onChanged: widget.onChanged,
          style: const TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
