import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_chat_app/features/user/domain/entities/user_entity.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/get_single_user.dart';

part 'single_user_state.dart';

class SingleUserCubit extends Cubit<SingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;

  SingleUserCubit({
    required this.getSingleUserUseCase,
  }) : super(SingleUserInitial());

  Future<void> getSingleUserProfile({required UserEntity user}) async {
    emit(SingleUserLoading());

    try {
      final streamRes = getSingleUserUseCase(user);
      streamRes.listen((users) {
        emit(SingleUserSuccess(currentUser: users.first));
      });
    } on SocketException catch (_) {
      emit(SingleUserFailed());
    } catch (_) {
      emit(SingleUserFailed());
    }
  }
}
