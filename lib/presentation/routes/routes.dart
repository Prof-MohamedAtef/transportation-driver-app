import 'package:flutter/material.dart';
import 'package:zeow_driver/presentation/pages/add_bus_screen.dart';
import 'package:zeow_driver/presentation/pages/add_trip_screen.dart';
import 'package:zeow_driver/presentation/pages/forgot_password_page.dart';
import 'package:zeow_driver/presentation/pages/location_screen.dart';
import 'package:zeow_driver/presentation/pages/onboading_page.dart';
import 'package:zeow_driver/presentation/pages/signin_screen.dart';
import 'package:zeow_driver/presentation/pages/update_user_profile.dart';
import 'package:zeow_driver/presentation/pages/verification_phase_screen.dart';

import '../pages/home_page.dart';
import '../pages/sign_up_screen.dart';
import '../pages/splash_page.dart';
import '../pages/trips_list_screen.dart';
import '../pages/verify_driver_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const signInScreen = '/SignIn';
  static const signUpScreen = '/SignIUp';
  static const forgotPasswordScreen = '/ForgotPassword';
  static const resetPasswordScreen = '/ResetPassword';
  static const onBoardingScreen = '/OnBoarding';
  static const locationScreen = '/Location';
  static const homeScreen = '/Home';
  static const tripsScreen = '/Trips';
  static const mapsScreen = '/Map';
  static const verificationScreen = '/Verify';
  static const addTripScreen = '/addTrip';
  static const addBusScreen = '/addBus';
  static const verifyDriverScreen = '/verifyDriver';
  static const updateProfileScreen = "/updateProfile";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signInScreen:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case signUpScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());
      case locationScreen:
        return MaterialPageRoute(builder: (_) => const LocationScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case forgotPasswordScreen :
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case tripsScreen:
        return MaterialPageRoute(builder: (_) => TripsListScreen());
      case verificationScreen:
        return MaterialPageRoute(builder: (_) => const VerificationPhaseScreen());
      case addTripScreen:
        return MaterialPageRoute(builder: (_) => const AddTripScreen());
      case addBusScreen:
        return MaterialPageRoute(builder: (_) => const AddBusScreen());
      case verifyDriverScreen:
        // return MaterialPageRoute(builder: (_) => const VerifyDriverScreen());
      case updateProfileScreen:
        return MaterialPageRoute(builder: (_) => const UpdateUserProfileScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
