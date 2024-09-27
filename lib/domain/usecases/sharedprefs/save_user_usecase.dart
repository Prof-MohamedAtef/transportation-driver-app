import '../../../data/models/firebase_user_model.dart';
import '../../repositories/user_shared_prefs_repository.dart';

class SaveUserSharedPrefsUseCase {
  final UserSharedPrefsRepository userRepository;

  SaveUserSharedPrefsUseCase(this.userRepository);

  Future<void> call(FirebaseUserModel user) async {
    return await userRepository.saveUser(user);
  }
}