import 'package:flutter_chat_app/features/user/domain/entities/user_entity.dart';
import 'package:flutter_chat_app/features/user/domain/repositories/user_repository.dart';

class SignUpUseCase {
  final UserRepository repository;

  SignUpUseCase({
    required this.repository,
  });

  Future<void> call(UserEntity user) {
    return repository.signUp(user);
  }
}
