import 'package:flutter_chat_app/features/group/data/data_sources/remote/group_remote_data_source.dart';
import 'package:flutter_chat_app/features/group/domain/entities/group_entity.dart';
import 'package:flutter_chat_app/features/group/domain/entities/text_message_entitiy.dart';
import 'package:flutter_chat_app/features/group/domain/repositories/group_repsitory.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource groupRemoteDataSource;

  GroupRepositoryImpl({
    required this.groupRemoteDataSource,
  });

  @override
  Future<void> getCreateGroup(GroupEntity groupEntity) async =>
      groupRemoteDataSource.getCreateGroup(groupEntity);

  @override
  Stream<List<GroupEntity>> getGroups() => groupRemoteDataSource.getGroups();

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) =>
      groupRemoteDataSource.getMessages(channelId);

  @override
  Future<void> sendTextMessage(
          TextMessageEntity textMessageEntity, String channelId) async =>
      groupRemoteDataSource.sendTextMessage(textMessageEntity, channelId);

  @override
  Future<void> updateGroup(GroupEntity groupEntity) async =>
      groupRemoteDataSource.updateGroup(groupEntity);
}
