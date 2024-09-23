import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../domain/usecases/firebaseauth/firebase_auth_service.dart';
import '../../../domain/usecases/firebaseauth/usecase/google_sign_in_use_case.dart';
import '../../../presentation/state/auth_state.dart';
import '/data/models/user_model.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final GoogleSignInUseCase googleSignInUseCase;

  AuthRepository(this.googleSignInUseCase);

  Future<Either<AuthFailure, User?>> signInWithGoogle() {
    return googleSignInUseCase.signInWithGoogle();
  }

  Future<UserModel?> signInWithEmail(String email, String password) async {
    User? user = await _firebaseAuthService.signInWithEmail(email, password);
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  Future<UserModel?> signUpWithEmail(String email, String password) async {
    User? user = await _firebaseAuthService.signUpWithEmail(email, password);
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  Future<void> signOut() async {
    await googleSignInUseCase.signOutGoogle();
    return await _firebaseAuthService.signOut();
  }

  UserModel? getCurrentUser() {
    User? user = _firebaseAuthService.getCurrentUser();
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }
}