import 'package:flutter_chat_app/features/user/domain/entities/user_entity.dart';
import 'package:flutter_chat_app/features/user/domain/repositories/user_repository.dart';

class GetSingleUserUseCase {
  final UserRepository repository;

  GetSingleUserUseCase({
    required this.repository,
  });

  Stream<List<UserEntity>> call(UserEntity user) {
    return repository.getSingleUser(user);
  }
}
