import 'package:flutter_chat_app/features/group/domain/entities/group_entity.dart';
import 'package:flutter_chat_app/features/group/domain/repositories/group_repsitory.dart';

class GetGroupsUseCase {
  final GroupRepository groupRepository;

  GetGroupsUseCase({
    required this.groupRepository,
  });

  Stream<List<GroupEntity>> call() {
    return groupRepository.getGroups();
  }
}
