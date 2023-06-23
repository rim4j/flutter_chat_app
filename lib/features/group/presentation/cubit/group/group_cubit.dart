import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_chat_app/features/group/domain/entities/group_entity.dart';
import 'package:flutter_chat_app/features/group/domain/use_cases/get_create_group_usecase.dart';
import 'package:flutter_chat_app/features/group/domain/use_cases/get_groups_usecase.dart';
import 'package:flutter_chat_app/features/group/domain/use_cases/update_group_usecase.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GetCreateGroupUseCase getCreateGroupUseCase;
  final GetGroupsUseCase getGroupsUseCase;
  final UpdateGroupUseCase updateGroupUseCase;

  GroupCubit({
    required this.getCreateGroupUseCase,
    required this.getGroupsUseCase,
    required this.updateGroupUseCase,
  }) : super(GroupInitial());

  Future<void> getGroups() async {
    emit(GroupLoading());
    try {
      final streamResponse = getGroupsUseCase();
      streamResponse.listen((groups) {
        emit(GroupSuccess(groups: groups));
      });
    } on SocketException catch (_) {
      emit(GroupFailed());
    } catch (_) {
      emit(GroupFailed());
    }
  }

  Future<void> getCreateGroup({required GroupEntity groupEntity}) async {
    try {
      await getCreateGroupUseCase(groupEntity);
    } on SocketException catch (_) {
      emit(GroupFailed());
    } catch (_) {
      emit(GroupFailed());
    }
  }

  Future<void> updateGroup({required GroupEntity groupEntity}) async {
    try {
      await updateGroupUseCase(groupEntity);
    } on SocketException catch (_) {
      emit(GroupFailed());
    } catch (_) {
      emit(GroupFailed());
    }
  }
}
