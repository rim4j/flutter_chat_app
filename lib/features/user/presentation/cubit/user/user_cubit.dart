import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_chat_app/features/user/domain/entities/user_entity.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/get_all_users.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/get_update_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetUpdateUserUseCase getUpdateUserUseCase;

  UserCubit({
    required this.getAllUsersUseCase,
    required this.getUpdateUserUseCase,
  }) : super(UserInitial());

  Future<void> getUsers({required UserEntity user}) async {
    emit(UserLoading());

    try {
      final streamRes = getAllUsersUseCase(user);
      streamRes.listen((users) {
        emit(UserSuccess(users: users));
      });
    } on SocketException catch (_) {
      emit(UserFailed());
    } catch (_) {
      emit(UserFailed());
    }
  }

  Future<void> getUpdateUser({required UserEntity user}) async {
    try {
      await getUpdateUserUseCase(user);
    } on SocketException catch (_) {
      emit(UserFailed());
    } catch (_) {
      emit(UserFailed());
    }
  }
}
