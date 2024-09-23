import '../../../data/models/user_model.dart';
import '../../repositories/user_repository.dart';

class SaveUserUseCase {
  final UserRepository userRepository;

  SaveUserUseCase(this.userRepository);

  Future<void> call(UserModel user) async {
    return await userRepository.saveUser(user);
  }
}