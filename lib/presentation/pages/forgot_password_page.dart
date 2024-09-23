import 'package:zeow_driver/presentation/routes/routes.dart';
import 'package:zeow_driver/presentation/widgets/custom_button_widget.dart';
import 'package:zeow_driver/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  static const String id = 'Forgot_view';

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
        padding: const EdgeInsets.only(top: 40, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                title: 'Reset Password',
                obscureText: false,
                hint: 'Enter email address'),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              onTap: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(AppRoutes.signInScreen));
              },
              title: "Send",
            )
          ],
        ),
      ),
    );
  }
}
