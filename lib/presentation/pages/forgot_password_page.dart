import 'package:zeow_driver/presentation/routes/routes.dart';
import 'package:zeow_driver/presentation/widgets/custom_button_widget.dart';
import 'package:zeow_driver/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/flutter_toast_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String id = 'Forgot_view';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Forget Password'),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomTextField(
                title: 'Reset Password',
                obscureText: false,
                hint: 'Enter email address',
                controller: _emailController,
                onChanged: (value) {
                  // Field is controlled by controller, no extra handling needed
                },
              ),
              const SizedBox(height: 30),
              CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // Simulate sending the reset email
                    showToastMessage("Password reset email sent!", Colors.pink);
                    Navigator.popUntil(context, ModalRoute.withName(AppRoutes.signInScreen));
                  }
                },
                title: "Send",
              )
            ],
          ),
        ),
      ),
    );
  }
}