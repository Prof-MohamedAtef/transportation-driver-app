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
    // final viewModel = Provider.of<ResetPasswordViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Consumer<ResetPasswordViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.state is ResetPasswordStateLoading) {
                    return const SizedBox.shrink();
                  } else if (viewModel.state is ResetPasswordStateSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      // Adding a short delay before navigating to avoid the progress dialog reappearing
                      Future.delayed(Duration(milliseconds: 100), () {
                        Navigator.pushNamed(context, AppRoutes.signInScreen);
                        showToastMessage("Sign In successful!",
                            Colors.green); // Show success toast
                      });
                    });
                    return const SizedBox.shrink();
                  } else if (viewModel.state is ResetPasswordFailure) {
                    final errorMessage =
                        (viewModel.state as ResetPasswordFailure).message;
                    return resetPasswordForm(viewModel,
                        showErrorToast: true, errorMessage: errorMessage);
                    return Center();
                  } else {
                    return resetPasswordForm(viewModel);
                  }
                },
              ),
            ),
            if (Provider.of<ResetPasswordViewModel>(context).state
                is ResetPasswordStateLoading)
              const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.yellow,
                  color: Colors.pink,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget resetPasswordForm(ResetPasswordViewModel viewModel,
      {bool showErrorToast = false, String? errorMessage}) {
    return Form(
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
              }
            },
            child: Text('Reset Password'),
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
    );
  }
}

/*

 */
