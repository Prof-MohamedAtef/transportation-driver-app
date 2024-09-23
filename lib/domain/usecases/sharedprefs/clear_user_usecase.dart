import '../../repositories/user_repository.dart';

class ClearUserUseCase {
  final UserRepository userRepository;

  ClearUserUseCase(this.userRepository);

  Future<void> call() async {
    return await userRepository.clearUser();
  }
}