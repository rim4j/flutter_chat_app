import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_chat_app/features/user/domain/use_cases/get_current_uid.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/is_sign_in_usecase.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;

  AuthCubit({
    required this.isSignInUseCase,
    required this.signOutUseCase,
    required this.getCurrentUidUseCase,
  }) : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUseCase();

      if (isSignIn) {
        final uid = await getCurrentUidUseCase();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase();

      emit(Authenticated(uid: uid));
    } catch (e) {
      emit(UnAuthenticated());
    }
  }

  Future<void> logout() async {
    try {
      await signOutUseCase();
      emit(UnAuthenticated());
    } catch (e) {
      emit(UnAuthenticated());
    }
  }
}
