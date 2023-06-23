import 'package:flutter_chat_app/features/group/domain/entities/group_entity.dart';
import 'package:flutter_chat_app/features/group/domain/repositories/group_repsitory.dart';

class GetCreateGroupUseCase {
  final GroupRepository groupRepository;

  GetCreateGroupUseCase({
    required this.groupRepository,
  });

  Future<void> call(GroupEntity groupEntity) {
    return groupRepository.getCreateGroup(groupEntity);
  }
}
