import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/routes.dart';
import '../state/auth_state.dart';
import '../state/register_auth_state.dart';
import '../viewmodel/auth/system_auth_view_model.dart';
import '../widgets/flutter_toast_widget.dart';
class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Consumer<SystemAuthViewModel>(builder: (context, authViewModel, child) {
        if (authViewModel.state is RegisterUserLoading) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.yellow,
              color: Colors.pink,
            ),
          );
        } else if (authViewModel.state is RegisterUserSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(context, AppRoutes.signInScreen); // Navigate after success
          });
          showToastMessage("Sign up successful!", Colors.pink);
          return const Center(child: Text("Sign Up successful!"));
        } else if (authViewModel.state is RegisterUserFailure) {
          showToastMessage((authViewModel.state as RegisterUserFailure).errors[0], Colors.pink);
          return signUpForm(authViewModel);
        } else {
          return signUpForm(authViewModel);
        }
      }),
    );
  }

  Widget signUpForm(SystemAuthViewModel systemAuthViewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    // Toggle password visibility within setState
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              obscureText: _obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final name = _nameController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  systemAuthViewModel.registerUser(
                    name: name,
                    email: email,
                    password: password,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                elevation: 5,
              ),
              child: systemAuthViewModel.state is RegisterUserLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Sign Up'),
            ),
            if (systemAuthViewModel.state is RegisterUserFailure)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  (systemAuthViewModel.state as RegisterUserFailure).errors[0],
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}