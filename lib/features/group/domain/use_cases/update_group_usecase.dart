import 'package:flutter_chat_app/features/group/domain/entities/group_entity.dart';
import 'package:flutter_chat_app/features/group/domain/repositories/group_repsitory.dart';

class UpdateGroupUseCase {
  final GroupRepository groupRepository;

  UpdateGroupUseCase({
    required this.groupRepository,
  });

  Future<void> call(GroupEntity groupEntity) {
    return groupRepository.updateGroup(groupEntity);
  }
}
