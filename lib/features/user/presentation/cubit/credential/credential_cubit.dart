import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat_app/features/user/domain/entities/user_entity.dart';

import 'package:flutter_chat_app/features/user/domain/use_cases/forget_password_usecase.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/google_auth_usecase.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/sign_in_usecase.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/sign_up_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final GoogleAuthUseCase googleAuthUseCase;

  CredentialCubit({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.forgetPasswordUseCase,
    required this.googleAuthUseCase,
  }) : super(CredentialInitial());

  Future<void> forgetPassword({required String email}) async {
    try {
      await forgetPasswordUseCase(email);
    } on SocketException catch (_) {
      emit(CredentialFailed());
    } catch (e) {
      emit(CredentialFailed());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(CredentialLoading());
    try {
      await signInUseCase(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailed());
    } catch (e) {
      emit(CredentialFailed());
    }
  }

  Future<void> signUp({
    required UserEntity user,
  }) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase(user);
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailed());
    } catch (e) {
      emit(CredentialFailed());
    }
  }

  Future<void> googleAuthSubmit() async {
    emit(GoogleCredentialLoading());
    try {
      await googleAuthUseCase();
      emit(GoogleCredentialSuccess());
    } on SocketException catch (_) {
      emit(GoogleCredentialFailed());
    } catch (_) {
      emit(GoogleCredentialFailed());
    }
  }
}
