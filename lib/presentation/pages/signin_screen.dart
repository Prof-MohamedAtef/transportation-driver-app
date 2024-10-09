import 'package:zeow_driver/presentation/pages/reset_password_screen.dart';
import 'package:zeow_driver/presentation/pages/sign_up_screen.dart';
import 'package:zeow_driver/presentation/viewmodel/auth/login_user_view_model.dart';
import 'package:zeow_driver/presentation/widgets/auth_custom_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:zeow_driver/presentation/routes/routes.dart';
import 'package:zeow_driver/presentation/widgets/custom_button_widget.dart';
import 'package:zeow_driver/presentation/widgets/custom_text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../state/auth_state.dart';
import '../state/signin_auth_state.dart';
import '../viewmodel/user/user_shared_prefs_view_model.dart';
import '../widgets/flutter_toast_widget.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  static const String id = 'sign_in';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    //   String? savedEmail = userViewModel.user?.email;
    //   if (savedEmail != null) {
    //     emailController.text = savedEmail;
    //   }
    // });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    userViewModel.loadUser();
    // emailController.text = userViewModel.user!.email!;
    return WillPopScope(
      onWillPop: () async {
        // Reset state when going back to avoid any previous state issues
        // authViewModel.resetState();
        return false; // Allow back navigation
      },
      child: Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Center(child: Text('Sign In')),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Consumer<LoginAuthViewModel>(
                  builder: (context, authViewModel, child) {
                if (authViewModel.state is AuthLoading) {
                  return const SizedBox.shrink();
                  // return const Center(
                  //   child: CircularProgressIndicator(
                  //     backgroundColor: Colors.yellow,
                  //     color: Colors.pink,
                  //   ),
                  // );
                } else if (authViewModel.state is AuthSuccess && !_isNavigating) {
                  _isNavigating = true;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // Adding a short delay before navigating to avoid the progress dialog reappearing
                    Future.delayed(Duration(milliseconds: 100), () {
                      Navigator.pushNamed(context, AppRoutes.homeScreen);
                      showToastMessage("Sign In successful!",
                          Colors.green); // Show success toast
                    });
                  });
                  return const SizedBox.shrink();
                  // return const Center(
                  //   child: CircularProgressIndicator(
                  //     backgroundColor: Colors.yellow,
                  //     color: Colors.pink,
                  //   ),
                  // );
                } else if (authViewModel.state is AuthFailure) {
                  final errorMessage =
                      (authViewModel.state as AuthFailure).message;
                  // showToastMessage(errorMessage, Colors.red);
                  return signInForm(authViewModel,
                      showErrorToast: true, errorMessage: errorMessage);
                } else {
                  return signInForm(authViewModel);
                }
              }),
            ),
            if (Provider.of<LoginAuthViewModel>(context).state is AuthLoading)
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

  Widget signInForm(LoginAuthViewModel authViewModel,
      {bool showErrorToast = false, String? errorMessage}) {
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
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            CustomTextField(
              title: 'Email',
              controller: emailController,
              // Pass controller here
              obscureText: false,
              hint: 'Enter Your Email',
              onChanged: (value) {
                emailController.text = value; // Keep email value updated
                // setState(() {

                // });
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              title: 'password',
              controller: passwordController,
              // Pass controller here
              obscureText: true,
              hint: 'Enter Your Password',
              onChanged: (val) {
                passwordController.text = val; // Keep password value updated
                // No need to call setState here, keep password value updated without triggering UI changes
                // setState(() {
                //
                // });
              },
            ),
            const SizedBox(height: 12),
            GestureDetector(
              child: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forget Password',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ResetPasswordScreen()));
              },
            ),
            const SizedBox(height: 40),
            CustomButton(
              onTap: () {
                signInWithEmail(emailController.text.trim(),
                    passwordController.text.trim(), context);
              },
              title: "Sign In",
            ),
            const SizedBox(height: 20),
            AuthCustomRowWidget(
              text1: 'Do not have an account?',
              text2: 'Sign Up',
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SignupScreen()));
              },
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'OR',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: SvgPicture.asset(
                'assets/images/google_logo.svg',
                height: 24, // Adjust size as needed
                width: 24,
              ),
              onPressed: () async {
                // Implement Google sign-in logic in ViewModel
                // final authViewModel = Provider.of<GoogleAuthViewModel>(context, listen: false);
                await authViewModel.signInWithGoogle();
                if (authViewModel.state is AuthFailure) {
                  showToastMessage((authViewModel.state as AuthFailure).message,
                      Colors.pink);
                } else if (authViewModel.state is AuthSuccess) {
                  // Successful login, navigate to the desired screen (Home or Dashboard)
                  Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
                }
              },
              label: const Text('Sign In with Google'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue, // Text color
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
            ),
            // Show error toast message if needed
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
      ),
    );
  }
}

Future<void> signInWithEmail(
    String email, String password, BuildContext context) async {
  Provider.of<LoginAuthViewModel>(context, listen: false)
      .signInUser(email: email, password: password);
}
