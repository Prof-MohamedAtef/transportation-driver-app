import 'package:google_sign_in/google_sign_in.dart';
import 'package:zeow_driver/data/datasources/trip/trip_api_service.dart';
import 'package:zeow_driver/data/repositories/trip/trip_repository_impl.dart';
import 'package:zeow_driver/domain/repositories/trip_repository.dart';
import 'package:zeow_driver/domain/usecases/trip/insert_trip_usecase.dart';
import 'package:zeow_driver/domain/usecases/users/store_user_api_use_case.dart';
import 'package:zeow_driver/presentation/viewmodel/auth/auth_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zeow_driver/presentation/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:zeow_driver/presentation/viewmodel/auth/system_auth_view_model.dart';
import 'package:zeow_driver/presentation/viewmodel/cars/add_cars_view_model.dart';
import 'package:zeow_driver/presentation/viewmodel/cars/get_cars_view_model.dart';
import 'package:zeow_driver/presentation/viewmodel/location/location_viewmodel.dart';
import 'package:zeow_driver/presentation/viewmodel/trips/trips_viewmodel.dart';
import 'package:zeow_driver/presentation/viewmodel/user/user_api_view_model.dart';
import 'package:zeow_driver/presentation/viewmodel/user/user_shared_prefs_view_model.dart';

import 'data/datasources/auth/register_user_api_service.dart';
import 'data/datasources/cars/get_cars_api_service.dart';
import 'data/datasources/location/location_service.dart';
import 'data/datasources/sharedprefs/shared_prefs_service.dart';
import 'data/datasources/users/store_user_api_service.dart';
import 'data/repositories/cars/cars_repository_impl.dart';
import 'data/repositories/firebase/auth_repository.dart';
import 'data/repositories/sharedprefs/user_repository_impl.dart';
import 'data/repositories/users/register_api_repository_impl.dart';
import 'data/repositories/users/user_api_repository_impl.dart';
import 'data/responses/users/store_user_api_response.dart';
import 'domain/etities/trip.dart';
import 'domain/usecases/cars/add_car_use_case.dart';
import 'domain/usecases/firebaseauth/usecase/google_sign_in_use_case.dart';
import 'domain/usecases/cars/get_cars_use_case.dart';
import 'domain/usecases/sharedprefs/clear_user_usecase.dart';
import 'domain/usecases/sharedprefs/get_user_usecase.dart';
import 'domain/usecases/sharedprefs/save_user_usecase.dart';
import 'domain/usecases/users/register_user_api_use_case.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  // // injecting dependencies
  // final googleSignInUseCase = GoogleSignInUseCase();
  // final authRepository = AuthRepository(googleSignInUseCase);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UserApiViewModel(
                StoreUserApiUseCase((UserApiRepositoryImpl(StoreUserApiService()))))),
        ChangeNotifierProvider(
            create: (_) => AddCarViewModel(
                AddCarUseCase((CarRepositoryImpl(CarsApiService()))))),
        ChangeNotifierProvider(
            create: (_) => CarViewModel(
                GetCarTypesUseCase((CarRepositoryImpl(CarsApiService()))))),
        ChangeNotifierProvider<UserViewModel>(
          create: (_) => UserViewModel(
            SaveUserSharedPrefsUseCase(UserRepositoryImpl(SharedPreferencesService())),
            GetUserSharedPrefsUseCase(UserRepositoryImpl(SharedPreferencesService())),
            ClearUserSharedPrefsUseCase(UserRepositoryImpl(SharedPreferencesService())),
          ),
        ),
        ChangeNotifierProvider(
            create: (context) => SystemAuthViewModel(
                RegisterUserApiUseCase((RegisterApiRepositoryImpl(RegisterUserApiService()))),
                Provider.of<UserViewModel>(context,
                    listen: false)
            )),
        // Create AuthViewModel after UserViewModel
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(
            AuthRepository(GoogleSignInUseCase()),
            Provider.of<UserViewModel>(context,
                listen: false), // Inject UserViewModel
          ),
        ),
        ChangeNotifierProvider(
            create: (_) => LocationViewModel(LocationService())),
        // Providing TripApiService for API calls
        Provider<TripApiService>(create: (_) => TripApiService()),

        // Providing TripRepositoryImpl as the concrete implementation of TripRepository
        ProxyProvider<TripApiService, TripRepositoryImpl>(
          update: (_, apiService, __) => TripRepositoryImpl(apiService),
        ),

        // Providing InsertTripUseCase with the injected repository
        ProxyProvider<TripRepositoryImpl, InsertTripUseCase>(
          update: (_, tripRepository, __) => InsertTripUseCase(tripRepository),
        ),

        // Providing TripViewModel with the injected use case
        ChangeNotifierProvider<TripViewModel>(
          create: (context) => TripViewModel(context.read<InsertTripUseCase>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true),
      initialRoute:
          AppRoutes.splash, // Set the home screen as the initial route
      onGenerateRoute: AppRoutes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
