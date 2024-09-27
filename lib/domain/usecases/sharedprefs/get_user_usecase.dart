import '../../../data/models/firebase_user_model.dart';
import '../../repositories/user_shared_prefs_repository.dart';

class GetUserSharedPrefsUseCase {
  final UserSharedPrefsRepository userRepository;

  GetUserSharedPrefsUseCase(this.userRepository);

  Future<FirebaseUserModel?> call() async {
    return await userRepository.getUser();
  }
}