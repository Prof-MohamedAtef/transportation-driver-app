import 'package:zeow_driver/presentation/widgets/custom_text_field_widget.dart';
import 'package:zeow_driver/presentation/widgets/custom_button_widget.dart';
import 'package:zeow_driver/presentation/widgets/auth_custom_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:zeow_driver/presentation/viewmodel/auth/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import '../routes/routes.dart';
import '../state/auth_state.dart';
import '../widgets/flutter_toast_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Sign Up'),
        ),
        body: Consumer<AuthViewModel>(builder: (context, authViewModel, child) {
          if (authViewModel.state is AuthLoading) {
            return const Center(child: CircularProgressIndicator(
              backgroundColor: Colors.yellow,
              color: Colors.pink,
            ));
          } else if (authViewModel.state is AuthSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(
                  context, AppRoutes.signInScreen); // Navigate after success
            });
            showToastMessage("Sign up successful!", Colors.pink);
            return const Center(child: Text("Sign Up successful!"));
            } else if (authViewModel.state is AuthFailure) {
            showToastMessage(
                (authViewModel.state as AuthFailure).message, Colors.pink);
            return SignUpForm(authViewModel);
            } else {
            return SignUpForm(authViewModel);
          }
        }));
  }

  Widget SignUpForm(AuthViewModel authViewModel) {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Please Sign Up',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                title: 'email',
                onChanged: (value) {
                  email = value;
                },
                obscureText: false,
                hint: 'Enter Your email',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                title: 'password',
                onChanged: (val) {
                  password = val;
                },
                obscureText: true,
                hint: 'Enter Your password',
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                onTap: () async {
                  signUpWithEmail(
                      email.toString(), password.toString(), context);
                },
                title: "Sign Up",
              ),
              const SizedBox(
                height: 5,
              ),
              AuthCustomRowWidget(
                text1: 'Already have An Account ?',
                text2: 'Sign In',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }
}

Future<void> signUpWithEmail(
    String email, String password, BuildContext context) async {
  await Provider.of<AuthViewModel>(context, listen: false).signUp(
    email,
    password,
  );
}