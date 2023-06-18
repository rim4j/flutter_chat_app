import 'package:flutter_chat_app/features/user/domain/entities/user_entity.dart';
import 'package:flutter_chat_app/features/user/domain/repositories/user_repository.dart';

class GetCreateCurrentUserUseCase {
  final UserRepository repository;

  GetCreateCurrentUserUseCase({
    required this.repository,
  });

  Future<void> call(UserEntity user) {
    return repository.getCreateCurrentUser(user);
  }
}
