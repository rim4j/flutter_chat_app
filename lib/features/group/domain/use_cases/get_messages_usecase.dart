import 'package:flutter_chat_app/features/group/domain/entities/text_message_entitiy.dart';
import 'package:flutter_chat_app/features/group/domain/repositories/group_repsitory.dart';

class GetMessagesUseCase {
  final GroupRepository groupRepository;

  GetMessagesUseCase({
    required this.groupRepository,
  });

  Stream<List<TextMessageEntity>> call(String channelId) {
    return groupRepository.getMessages(channelId);
  }
}
