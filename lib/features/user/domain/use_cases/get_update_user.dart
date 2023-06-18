import 'package:flutter_chat_app/features/user/domain/entities/user_entity.dart';
import 'package:flutter_chat_app/features/user/domain/repositories/user_repository.dart';

class GetUpdateUserUseCase {
  final UserRepository repository;

  GetUpdateUserUseCase({
    required this.repository,
  });

  Future<void> call(UserEntity user) {
    return repository.getUpdateUser(user);
  }
}
