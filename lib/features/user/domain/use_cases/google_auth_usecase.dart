import 'package:flutter_chat_app/features/user/domain/repositories/user_repository.dart';

class GoogleAuthUseCase {
  final UserRepository repository;

  GoogleAuthUseCase({
    required this.repository,
  });

  Future<void> call() {
    return repository.googleAuth();
  }
}
