import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:zeow_driver/presentation/viewmodel/auth/auth_viewmodel.dart';

import '../routes/routes.dart';
import '../viewmodel/user/user_shared_prefs_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFed4e4e),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/swvl.svg',
            height: 80,
            width: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "Welcome To Swvl",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.yellow),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3)); // Wait for 3 seconds
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    await userViewModel.loadUser();
    if (userViewModel.user != null){
      Navigator.pushNamed(context, AppRoutes.homeScreen);
    }else{
      Navigator.pushNamed(context, AppRoutes.signInScreen);
    }
  }
}
