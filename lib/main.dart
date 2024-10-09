import 'package:zeow_driver/data/datasources/auth/login_user_api_service.dart';
import 'package:zeow_driver/data/datasources/trip/trip_api_service.dart';
import 'package:zeow_driver/data/repositories/trip/trip_repository_impl.dart';
import 'package:zeow_driver/domain/repositories/trip_repository.dart';
import 'package:zeow_driver/domain/usecases/trip/insert_trip_usecase.dart';
import 'package:zeow_driver/domain/usecases/users/reset_password_use_case.dart';
import 'package:zeow_driver/domain/usecases/users/store_user_api_use_case.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zeow_driver/presentation/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:zeow_driver/presentation/viewmodel/auth/login_user_view_model.dart';
import 'package:zeow_driver/presentation/viewmodel/auth/register_user_view_model.dart';
import 'package:zeow_driver/presentation/viewmodel/auth/reset_password_view_model.dart';
import 'package:zeow_driver/presentation/viewmodel/cars/add_cars_view_model.dart';
import 'package:zeow_driver/presentation/viewmodel/cars/get_cars_view_model.dart';
import 'package:zeow_driver/presentation/viewmodel/location/location_viewmodel.dart';
import 'package:zeow_driver/presentation/viewmodel/trips/trips_viewmodel.dart';
import 'package:zeow_driver/presentation/viewmodel/user/user_api_view_model.dart';
import 'package:zeow_driver/presentation/viewmodel/user/user_shared_prefs_view_model.dart';
import 'data/datasources/auth/register_user_api_service.dart';
import 'data/datasources/auth/reset_password_api_service.dart';
import 'data/datasources/cars/get_cars_api_service.dart';
import 'data/datasources/location/location_service.dart';
import 'data/datasources/sharedprefs/shared_prefs_service.dart';
import 'data/datasources/users/store_user_api_service.dart';
import 'data/repositories/cars/cars_repository_impl.dart';
import 'data/repositories/firebase/auth_repository.dart';
import 'data/repositories/sharedprefs/user_repository_impl.dart';
import 'data/repositories/users/login_api_repository_impl.dart';
import 'data/repositories/users/register_api_repository_impl.dart';
import 'data/repositories/users/reset_password_repository_impl.dart';
import 'data/repositories/users/user_api_repository_impl.dart';
import 'domain/repositories/login_user_api_repository.dart';
import 'domain/repositories/reset_password_repository.dart';
import 'domain/usecases/cars/add_car_use_case.dart';
import 'domain/usecases/firebaseauth/usecase/google_sign_in_use_case.dart';
import 'domain/usecases/cars/get_cars_use_case.dart';
import 'domain/usecases/sharedprefs/clear_user_usecase.dart';
import 'domain/usecases/sharedprefs/get_user_usecase.dart';
import 'domain/usecases/sharedprefs/save_user_usecase.dart';
import 'domain/usecases/users/login_user_api_use_case.dart';
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
        // Provide TripApiService first
        Provider<TripApiService>(
          create: (_) => TripApiService(),
        ),
        // Provide TripRepositoryImpl using ProxyProvider
        ProxyProvider<TripApiService, TripRepositoryImpl>(
          update: (_, apiService, __) => TripRepositoryImpl(apiService),
        ),
        // Provide InsertTripUseCase using ProxyProvider
        ProxyProvider<TripRepositoryImpl, InsertTripUseCase>(
          update: (_, tripRepository, __) => InsertTripUseCase(tripRepository),
        ),
        // Provide TripViewModel with InsertTripUseCase and UserViewModel
        ChangeNotifierProvider<UserViewModel>(
          create: (_) => UserViewModel(
            SaveUserSharedPrefsUseCase(
              UserRepositoryImpl(SharedPreferencesService()),
            ),
            GetUserSharedPrefsUseCase(
              UserRepositoryImpl(SharedPreferencesService()),
            ),
            ClearUserSharedPrefsUseCase(
              UserRepositoryImpl(SharedPreferencesService()),
            ),
          ),
        ),
        ChangeNotifierProvider<TripViewModel>(
          create: (context) => TripViewModel(
            context.read<InsertTripUseCase>(),
            Provider.of<UserViewModel>(context, listen: false),
            context.read<TripRepositoryImpl>(), // Now this is properly provided
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ResetPasswordViewModel(
            ResetPasswordUseCase(
              ResetPasswordRepositoryImpl(ResetPasswordApiService()),
            ),
          ),
        ),

        ChangeNotifierProvider(
          create: (context) => LoginAuthViewModel(
            LoginUserApiUseCase(
              LoginApiRepositoryImpl(LoginUserApiService()),
            ),
            Provider.of<UserViewModel>(context, listen: false),
            AuthRepository(GoogleSignInUseCase()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UserApiViewModel(
            StoreUserApiUseCase(
              UserApiRepositoryImpl(StoreUserApiService()),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AddCarViewModel(
            AddCarUseCase(CarRepositoryImpl(CarsApiService())),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CarViewModel(
            GetCarTypesUseCase(CarRepositoryImpl(CarsApiService())),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterAuthViewModel(
            RegisterUserApiUseCase(
              RegisterApiRepositoryImpl(RegisterUserApiService()),
            ),
            Provider.of<UserViewModel>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationViewModel(LocationService()),
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
