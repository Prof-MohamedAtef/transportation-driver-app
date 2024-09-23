import 'package:zeow_driver/presentation/widgets/auth_custom_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:zeow_driver/presentation/routes/routes.dart';
import 'package:zeow_driver/presentation/widgets/custom_button_widget.dart';
import 'package:zeow_driver/presentation/widgets/custom_text_field_widget.dart';
import 'package:zeow_driver/presentation/viewmodel/auth/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../state/auth_state.dart';
import '../widgets/flutter_toast_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  static const String id = 'sign_in';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  String? email, password, errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          title: const Text('Sign In'),
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
                  context, AppRoutes.homeScreen); // Navigate after success
            });
            showToastMessage("Sign `In successful!", Colors.pink);
            return const Center(child: Text("Sign In successful!"));
          } else if (authViewModel.state is AuthFailure) {
            showToastMessage(
                (authViewModel.state as AuthFailure).message, Colors.pink);
            return signInForm(authViewModel);
          } else {
            return signInForm(authViewModel);
          }
        }));
  }

  Widget signInForm(AuthViewModel authViewModel) {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome Back',
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
                onTap: () {
                  signInWithEmail(
                      email.toString(), password.toString(), context);
                },
                title: "Sign In",
              ),
              const SizedBox(height: 20),
              AuthCustomRowWidget(
                text1: 'Do not have An Account ?',
                text2: 'Sign Up',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signUpScreen);
                },
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('OR', style: TextStyle(color: Colors.white),),
                  ),
                  Expanded(child: Divider(thickness: 1)),

                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.login, color: Colors.white),
                onPressed: () async {
                  // Call Google sign-in logic in the ViewModel
                  await authViewModel.signInWithGoogle();
                  if (authViewModel.state is AuthFailure) {
                    setState(() {
                      errorMessage = (authViewModel.state as AuthFailure).message;
                    });
                  }
                },
                label: const Text('Sign In with Google'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
            ],
          ),
        ));
  }
}

Future<void> signInWithEmail(
    String email, String password, BuildContext context) async {
  Provider.of<AuthViewModel>(context, listen: false).signIn(
    email,
    password,
    context
  );
}
