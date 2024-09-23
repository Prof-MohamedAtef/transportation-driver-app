import '../../../data/models/user_model.dart';
import '../../repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository userRepository;

  GetUserUseCase(this.userRepository);

  Future<UserModel?> call() async {
    return await userRepository.getUser();
  }
}