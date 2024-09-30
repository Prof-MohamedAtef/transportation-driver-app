import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeow_driver/presentation/state/reset_password_state.dart';

import '../routes/routes.dart';
import '../viewmodel/auth/reset_password_view_model.dart';
import '../widgets/flutter_toast_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ResetPasswordViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onChanged: (value) => viewModel.setEmail(value),
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: viewModel.isValidEmail(viewModel.email)
                      ? null
                      : 'Invalid email',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) => viewModel.setPassword(value),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  errorText: viewModel.isValidPassword(viewModel.password)
                      ? null
                      : 'Password must be at least 6 characters long',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) => viewModel.setConfirmPassword(value),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  errorText: viewModel.isPasswordConfirmed()
                      ? null
                      : 'Passwords do not match',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await viewModel.resetPassword(
                        email: viewModel.email,
                        password: viewModel.password,
                        passwordConfirm: viewModel.confirmPassword);
                    if (viewModel.state is ResetPasswordStateSuccess) {
                      showToastMessage((viewModel.state as ResetPasswordStateSuccess).message, Colors.green);
                      Navigator.pushReplacementNamed(context, AppRoutes.signInScreen);
                      // Navigate to success page or show success message
                    } else {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(viewModel.errorMessage),
                        ),
                      );
                    }
                  }
                },
                child: Text('Reset Password'),
              ),
              if (viewModel.errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    viewModel.errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
