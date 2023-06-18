import 'package:flutter_chat_app/features/user/domain/repositories/user_repository.dart';

class GetCurrentUidUseCase {
  final UserRepository repository;

  GetCurrentUidUseCase({
    required this.repository,
  });

  Future<String> call() {
    return repository.getCurrentUId();
  }
}
