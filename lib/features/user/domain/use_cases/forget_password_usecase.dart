import 'package:flutter_chat_app/features/user/domain/repositories/user_repository.dart';

class ForgetPasswordUseCase {
  final UserRepository repository;

  ForgetPasswordUseCase({
    required this.repository,
  });

  Future<void> call(String email) {
    return repository.forgotPassword(email);
  }
}
