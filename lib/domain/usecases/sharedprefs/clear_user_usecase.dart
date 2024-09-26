import '../../repositories/user_shared_prefs_repository.dart';

class ClearUserSharedPrefsUseCase {
  final UserSharedPrefsRepository userRepository;

  ClearUserSharedPrefsUseCase(this.userRepository);

  Future<void> call() async {
    return await userRepository.clearUser();
  }
}